
import Foundation
import Alamofire
import WowonderMessengerSDK
class GroupChatManager {
    
    static let instance = GroupChatManager()
    
    func createGroup(session_Token: String,groupName:String,parts:String,type:String,avatar_data:Data?, completionBlock: @escaping (_ Success:CreateGroupModel.CreateGroupSuccessModel?,_ AuthError:CreateGroupModel.CreateGroupErrorModel?,_ ServerKeyError:CreateGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.groupType : type,
            API.Params.group_name : groupName,
            API.Params.parts :parts,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
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
          
                if let avatarData = avatar_data{
                    multipartFormData.append(avatarData, withName: "avatar", fileName: "avatar.jpg", mimeType: "image/png")
                }
            
        }, to: API.GROUP_CHATS_METHODS.CREATE_GROUP_API + "\(session_Token)", usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            print("Succesfully uploaded")
            log.verbose("response = \(response.value)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try? JSONDecoder().decode(CreateGroupModel.CreateGroupSuccessModel.self, from: data!)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try? JSONDecoder().decode(CreateGroupModel.CreateGroupErrorModel.self, from: data!)
                        log.error("AuthError = \(result?.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try? JSONDecoder().decode(CreateGroupModel.ServerKeyErrorModel.self, from: data!)
                        log.error("AuthError = \(result?.errors!.errorText)")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        })
    }
    
    func fetchGroups(session_Token: String,type:String,limit:Int,completionBlock: @escaping (_ Success:FetchGroupModel.FetchGroupSuccessModel?,_ AuthError:FetchGroupModel.FetchGroupErrorModel?,_ ServerKeyError:FetchGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.groupType : type,
            API.Params.Limit_id : limit,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.FETCH_GROUP_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(FetchGroupModel.FetchGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(FetchGroupModel.FetchGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(FetchGroupModel.ServerKeyErrorModel.self, from: data)
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
    
    func getGroupChats(group_Id: String, session_Token: String,type:String, completionBlock: @escaping (_ Success:GroupChatModel.GroupChatSuccessModel?,_ AuthError:GroupChatModel.GroupChatErrorModel?,_ ServerKeyError:GroupChatModel.ServerKeyErrorModel?, Error?) ->()){
        let convertUserId = Int(group_Id)
        let params = [
            API.Params.session_token : session_Token,
            API.Params.Id : convertUserId,
            API.Params.groupType : type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.FETCH_GROUP_CHAT_API + "\(session_Token)" , method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(GroupChatModel.GroupChatSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(GroupChatModel.GroupChatErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(GroupChatModel.ServerKeyErrorModel.self, from: data)
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
    
    func leaveGroup(group_Id: String, session_Token: String,type:String, completionBlock: @escaping (_ Success:LeaveGroupModel.LeaveGroupSuccessModel?,_ AuthError:LeaveGroupModel.LeaveGroupErrorModel?,_ ServerKeyError:LeaveGroupModel.ServerKeyErrorModel?, Error?) ->()){
        let convertUserId = Int(group_Id)
        let params = [
            API.Params.session_token : session_Token,
            API.Params.Id : convertUserId,
            API.Params.groupType : type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.EXIT_GROUP_CHAT_API + "\(session_Token)" , method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int {
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(LeaveGroupModel.LeaveGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(LeaveGroupModel.LeaveGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(LeaveGroupModel.ServerKeyErrorModel.self, from: data)
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
    func deleteGroup(group_Id: String, session_Token: String,type:String, completionBlock: @escaping (_ Success:DeleteGroupModel.DeleteGroupSuccessModel?,_ AuthError:DeleteGroupModel.DeleteGroupErrorModel?,_ ServerKeyError:DeleteGroupModel.ServerKeyErrorModel?, Error?) ->()){
        let convertUserId = Int(group_Id)
        let params = [
            API.Params.session_token : session_Token,
            API.Params.Id : convertUserId,
            API.Params.groupType : type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.DELETE_GROUP_CHAT_API + "\(session_Token)" , method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(DeleteGroupModel.DeleteGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteGroupModel.DeleteGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteGroupModel.ServerKeyErrorModel.self, from: data)
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
    func updateGroup(session_Token: String,groupName:String,groupId:String,type:String,avatar_data:Data?, completionBlock: @escaping (_ Success:UpdateGroupModel.CreateGroupSuccessModel?,_ AuthError:UpdateGroupModel.UpdateGroupErrorModel?,_ ServerKeyError:UpdateGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.groupType : type,
            API.Params.group_name : groupName,
            API.Params.Id :groupId,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
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
            
            if let avatarData = avatar_data{
                multipartFormData.append(avatarData, withName: "avatar", fileName: "avatar.jpg", mimeType: "image/png")
            }
            
        }, to: API.GROUP_CHATS_METHODS.UPDATE_GROUP_CHAT_API + "\(session_Token)", usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            print("Succesfully uploaded")
            log.verbose("response = \(response.value)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(UpdateGroupModel.CreateGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(UpdateGroupModel.UpdateGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(UpdateGroupModel.ServerKeyErrorModel.self, from: data)
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
    func addParticipants(group_Id: String, session_Token: String,type:String,part:String, completionBlock: @escaping (_ Success:AddUserToGroupModel.AddUserToGroupSuccessModel?,_ AuthError:AddUserToGroupModel.AddUserToGroupErrorModel?,_ ServerKeyError:AddUserToGroupModel.ServerKeyErrorModel?, Error?) ->()){
        let convertUserId = Int(group_Id)
        let params = [
            API.Params.session_token : session_Token,
            API.Params.Id : convertUserId,
            API.Params.groupType : type,
            API.Params.parts : part,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.ADD_USER_TO_GROUP_CHAT_API + "\(session_Token)" , method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(AddUserToGroupModel.AddUserToGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(AddUserToGroupModel.AddUserToGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(AddUserToGroupModel.ServerKeyErrorModel.self, from: data)
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
    func sendMessageToGroup(message_hash_id: Int,
                            GroupId:String,
                            text:String,
                            type:String,
                            session_Token:String,
                            lat: Double,
                            lag: Double,
                            replyID: String,
                            completionBlock: @escaping (_ Success:SendMessageToGroupModel.SendMessageToGroupSuccessModel?,_ AuthError:SendMessageToGroupModel.SendMessageToGroupErrorModel?,_ ServerKeyError:SendMessageToGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedGroupId = Int(GroupId)
        let convertedHashID = "\(message_hash_id)"
        let params = [
            API.Params.MessageHashId : convertedHashID,
            API.Params.Id : covertedGroupId as Any,
            API.Params.Text : text,
            API.Params.groupType : type,
            "lat": lat,
            "lng": lag,
            "reply_id": replyID,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.SEND_MESSAGE_TO_GROUP_CHAT_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            log.verbose("Response = \(response.value)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.ServerKeyErrorModel.self, from: data)
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
    
    func sendGroupChatData(message_hash_id: Int,
                           groupId:String,
                           sendType:String,
                           session_Token: String,
                           type:String,
                           image_data:Data?,
                           video_data:Data?,
                           imageMimeType:String?,
                           videoMimeType:String?,
                           text:String,
                           file_data:Data?,
                           file_Extension:String?,
                           fileMimeType:String?,
                           auido:Data?,
                           auidoMimeType: String?,
                           auido_Extension: String?,
                           completionBlock: @escaping (_ Success:SendMessageToGroupModel.SendMessageToGroupSuccessModel?,_ AuthError:SendMessageToGroupModel.SendMessageToGroupErrorModel?,_ ServerKeyError:SendMessageToGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedGroupId = Int(groupId)
        let params = [ API.Params.MessageHashId : message_hash_id,
                       API.Params.groupType : sendType,
                       API.Params.Id : groupId,
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
                
            } else if type == "video"{
                if let data = video_data{
                    multipartFormData.append(data, withName: "file", fileName: "video.mp4", mimeType: videoMimeType ?? "")
                }
                
                
            } else if type == "audio" {
                if let data = auido {
                    multipartFormData.append(data, withName: "file", fileName: "audio.\(auido_Extension ?? "")", mimeType: auidoMimeType ?? "")
                }
            }else{
                if let fileData = file_data{
                    multipartFormData.append(fileData, withName: "file", fileName: "file.\(file_Extension ?? "")", mimeType: fileMimeType ?? "")
                }
                
            }
            
        }, to: API.GROUP_CHATS_METHODS.SEND_MESSAGE_TO_GROUP_CHAT_API + "\(session_Token)", usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            print("Succesfully uploaded")
            log.verbose("response = \(response.value ?? "")")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"] else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupSuccessModel.self, from: data)
                    log.debug("Success = \(result.apiStatus ?? nil)")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.ServerKeyErrorModel.self, from: data)
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
    
    func sendContactToGroup(message_hash_id: Int,groupId:String,sendType:String,jsonPayload:String,session_Token:String,Contact:String = "1", completionBlock: @escaping (_ Success:SendMessageToGroupModel.SendMessageToGroupSuccessModel?,_ AuthError:SendMessageToGroupModel.SendMessageToGroupErrorModel?,_ ServerKeyError:SendMessageToGroupModel.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedGroupId = Int(groupId)
        let convertedHashID = "\(message_hash_id)"
        let params = [
            API.Params.MessageHashId : convertedHashID,
            API.Params.Id : groupId,
            API.Params.Text : jsonPayload,
            API.Params.Contact : Contact,
            API.Params.groupType : sendType,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_CHATS_METHODS.SEND_MESSAGE_TO_GROUP_CHAT_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            log.verbose("Response = \(response.value)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.SendMessageToGroupErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(SendMessageToGroupModel.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription ?? "")")
                completionBlock(nil,nil,nil,response.error)
            }
        }
        
    }
    
    func sendGIF(message_hash_id: Int,
                 groupId:String,
                 URl: String,
                 session_Token: String,
                 type: String,
                 completionBlock: @escaping (_ Success: SendMessageModelOld.SendMessageSuccessModel?,_ AuthError: SendMessageModelOld.SendMessageErrorModel?,_ ServerKeyError: SendMessageModelOld.ServerKeyErrorModel?, Error?) ->()){
        
        let covertedReceipientId = Int(groupId)
        let convertedHashID = "\(message_hash_id)"
        
//        let params = [
//            API.Params.MessageHashId : convertedHashID,
//            "id" : covertedReceipientId,
//            "gif" : URl,
//            "type": type,
//            API.Params.ServerKey : API.SERVER_KEY.Server_Key
//            ] as [String : Any]
        
        let params = [
            API.Params.MessageHashId : convertedHashID,
            API.Params.Id : groupId,
            API.Params.Text : URl,
            API.Params.gif : URl,
            API.Params.groupType : type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.GROUP_CHATS_METHODS.SEND_MESSAGE_TO_GROUP_CHAT_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
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
}

