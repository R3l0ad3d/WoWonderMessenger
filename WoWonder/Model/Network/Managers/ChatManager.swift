
import Foundation
import Alamofire
import WowonderMessengerSDK

class ChatManager {
    
    static let instance = ChatManager()
    
    func getUserMessages(user_id: String, session_Token: String, receipent_id: String, limit: Int = -1, afterMsgId: String? = nil, beforeMsgId: String? = nil, messageId: String? = nil, _ completionBlock: @escaping (_ result: Result<MessageModelResponse, Error>) ->()) {
        
//        let convertUserId = Int(user_id)
        let covertedReceipientId = Int(receipent_id) ?? 0
        
        var params: [String : Any] = [
            //            API.Params.session_token : session_Token,
            //            API.Params.user_id : convertUserId,
            API.Params.RecipientId : covertedReceipientId,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
        ]
        
        if limit > 0 {
            params["limit"] = limit
        }
    
        if let afterMsgId = afterMsgId {
            params["after_message_id"] = afterMsgId
        }
        
        if let beforeMsgId = beforeMsgId {
            params["before_message_id"] = beforeMsgId
        }
        
        if let messageId = messageId {
            params["message_id"] = messageId
        }
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
//        log.verbose("Hamad API = \(API.Chat_Methods.GET_USER_CHATS_API + session_Token)")
//        print("Hamad Params \(API.Chat_Methods.GET_USER_CHATS_API)")
        
        AF.request(API.Chat_Methods.GET_USER_CHATS_API + session_Token, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            if (response.value != nil) {

                switch response.result {

                case .success(let data):
                    do {
                        let object = try JSONDecoder().decode(MessageModelResponse.self, from: data)
                        completionBlock(.success(object))
                    } catch {
                        completionBlock(.failure(error))

                    }
                    break
                case .failure(let error):
                    completionBlock(.failure(error))

                    break
                }

            }
        }
    }
            
    func sendMessage(message: String,
                     session_token: String,
                     ReceipientId: String,
                     lat: Double,
                     lng: Double,
                     reply_id: String,
                     completionBlock: @escaping (_ Success: SendMessageResponse?, _ AuthError: SendMessageModelOld.SendMessageErrorModel?, _ ServerKeyError:SendMessageModelOld.ServerKeyErrorModel?, Error?) ->()){

        let covertedReceipientId = Int(ReceipientId) ?? 0
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        
        let params = [
            API.Params.MessageHashId : messageHashId,
            API.Params.user_id : covertedReceipientId,
            API.Params.Text : message,
            "lat": lat,
            "lng": lng,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
            "reply_id" : reply_id] as [String : Any]


        AF.request("\(API.Chat_Methods.SEND_MESSAGE_API)\(session_token)", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            if (response.value != nil) {
                switch response.result {
                case .success(let data):
                    do {
                        let object = try JSONDecoder().decode(SendMessageResponse.self, from: data)
                        completionBlock(object, nil, nil, nil)
                    } catch {
                        print("Hamad ERROR \(error.localizedDescription)")
                    }
                    break

                case .failure(let error):
                    print("Hamad FAILURE \(error.localizedDescription)")
                    break
                }
            } else {
                completionBlock(nil,nil,nil,response.error)
            }
        }

    }
    
    
    func sendChatData(message_hash_id: Int,receipent_id:String,session_Token: String,type:String, audio_data:Data? ,image_data:Data?,video_data:Data?,imageMimeType:String?,videoMimeType:String?, audioMimeType:String?,text:String,file_data:Data?,file_Extension:String?,fileMimeType:String?, completionBlock: @escaping (_ Success:SendMessageModelOld.SendMessageSuccessModel?,_ AuthError:SendMessageModelOld.SendMessageErrorModel?,_ ServerKeyError:SendMessageModelOld.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedReceipientId = Int(receipent_id)
        
        let params = [ API.Params.MessageHashId : message_hash_id,
                       API.Params.user_id : receipent_id,
                       API.Params.ServerKey : API.SERVER_KEY.Server_Key ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if type == "image"{
                if let data = image_data{
                    multipartFormData.append(data, withName:"file", fileName: "image.jpg", mimeType: imageMimeType ?? "")
                }
                
            }
            else if type == "video"{
                if let data = video_data{
                    multipartFormData.append(data, withName: "file", fileName: "video.mp4", mimeType: videoMimeType ?? "")
                }
            }
            
            else if type == "audio"{
                if let data = audio_data {
                    multipartFormData.append(data, withName: "file", fileName: "audio.\(file_Extension ?? "")", mimeType: audioMimeType ?? "")
                    
                }
            }
            
            else if type == "location" {
                if let fileData = file_data{
                    multipartFormData.append(fileData, withName: "file", fileName: "location.\(file_Extension ?? "")", mimeType: fileMimeType ?? "")
                }
            }
            
            else{
                if let fileData = file_data{
                    multipartFormData.append(fileData, withName: "file", fileName: "file.\(file_Extension ?? "")", mimeType: fileMimeType ?? "")
                }
                
            }
            
        }, to: API.Chat_Methods.SEND_MESSAGE_API + "\(session_Token)", usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            print("Succesfully uploaded")
            log.verbose("response = \(response.value)")
            print("\(session_Token)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageSuccessModel.self, from: data)
                    log.debug("Success = \(result.apiStatus ?? nil)")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        })
    }
    
    func sendContactApiCall(message_hash_id: Int,
                            receipent_id:String,
                            sendType:String,
                            jsonPayload:String,
                            session_Token:String,
                            Contact: String = "1",
                            completionBlock: @escaping (_ Success: SendMessageModelOld.SendMessageSuccessModel?,_ AuthError: SendMessageModelOld.SendMessageErrorModel?,_ ServerKeyError: SendMessageModelOld.ServerKeyErrorModel?, Error?) ->()) {
        
        let params = [ API.Params.MessageHashId : message_hash_id,
                       API.Params.user_id : receipent_id,
                       API.Params.Text : jsonPayload,
                       API.Params.Contact : Contact,
                       API.Params.type : sendType,
                       API.Params.ServerKey : API.SERVER_KEY.Server_Key ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Chat_Methods.SEND_MESSAGE_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            log.verbose("Response = \(response.value ?? "")")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                
                guard let apiStatus = res["api_status"] else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value as Any, options: [])
                    let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageSuccessModel.self, from: data)
                    log.debug("Success = \(result.messageData ?? nil)")
                    completionBlock(result,nil,nil,nil)
                } else {
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value as Any, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText ?? "")")
                        completionBlock(nil,result,nil,nil)
                    } else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value as Any, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText ?? "")")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            } else {
                log.error("error = \(response.error?.localizedDescription ?? "")")
                completionBlock(nil,nil,nil,response.error)
            }
        }
    }
    
    func deleteChatMessage(messageId: String,session_Token: String, completionBlock: @escaping (_ Success:DeleteChatModel.DeleteChatSuccessModel?,_ AuthError: DeleteChatModel.DeleteChatErrorModel?,_ ServerKeyError: DeleteChatModel.ServerKeyErrorModel?, Error?) ->()) {
        
        let params = [
            API.Params.message_id : messageId,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
        ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.Chat_Methods.DELETE_MESSAGE_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(DeleteChatModel.DeleteChatSuccessModel.self, from: data)
                    log.debug("Success = \(result.message ?? nil)")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteChatModel.DeleteChatErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteChatModel.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        }
    }
    
    func sendGIF(message_hash_id: Int,
                 receipent_id: String,
                 URl: String, session_Token: String, completionBlock: @escaping (_ Success: SendMessageModelOld.SendMessageSuccessModel?,_ AuthError: SendMessageModelOld.SendMessageErrorModel?,_ ServerKeyError: SendMessageModelOld.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedReceipientId = Int(receipent_id)
        let convertedHashID = "\(message_hash_id)"
        
        let params = [
            API.Params.MessageHashId : convertedHashID,
            API.Params.user_id : covertedReceipientId,
            API.Params.gif : URl,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Chat_Methods.SEND_MESSAGE_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            log.verbose("Response = \(response.value)")
            
            if (response.value != nil) {
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatus = res["api_status"] else {return}
                
                if apiStatus is Int {
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageSuccessModel.self, from: data)
                    log.debug("Success = \(result.messageData ?? nil)")
                    completionBlock(result,nil,nil,nil)
                }else {
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.SendMessageErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageModelOld.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,nil,result,nil)
                    }
                }
                
            }else{
                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        }
    }
    
//    func GetAllData(user_id: String, session_Token: String, receipent_id: String _ completionBlock: @escaping (_ result: Result<MessageModelResponse, Error>) ->()) {
//        var params: [String : Any] = [
//            //            API.Params.session_token : session_Token,
//            //            API.Params.user_id : convertUserId,
//            API.Params.RecipientId : covertedReceipientId,
//            API.Params.ServerKey : API.SERVER_KEY.Server_Key,]
//    }
    
//    func chatPinmessage(user_id: String, session_Token: String, ) {
//        
//    }
    
}


