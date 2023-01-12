
import Foundation
import Alamofire
import WowonderMessengerSDK

class TwilloCallmanager {
    
    static let instance = TwilloCallmanager()
    
    func twilloCall(user_id: String, session_Token: String, recipient_Id: String, completionBlock: @escaping (_ Success: Result<TwilloCallSuccessModel, Error>) -> Void) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.session_token : session_Token,
            API.Params.RecipientId : recipient_Id,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
        ] as [String : Any]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Twillo_Calls_Methods.TWILLO_CREATE_AUDIO_CALL_API, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(TwilloCallSuccessModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                break
            case .failure(let error):
                completionBlock(.failure(error))
                break
            }
            
//            if (response.value != nil) {
//                guard let res = response.value as? [String:Any] else {return}
////                log.verbose("Response = \(res)")
//                guard let apiStatus = res["status"]  as? Any else {return}
//                if apiStatus is Int {
////                    log.verbose("apiStatus Int = \(apiStatus)")
//                    let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
//                    let result = try? JSONDecoder().decode(TwilloCallModel.TwilloCallSuccessModel.self, from: data!)
////                    log.debug("Success = \(result?.roomName ?? nil)")
//                    completionBlock(result,nil,nil,nil)
//                }else {
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try? JSONDecoder().decode(TwilloCallModel.TwilloCallErrorModel.self, from: data!)
////                        log.error("AuthError = \(result?.errors!.errorText)")
//                        completionBlock(nil,result,nil,nil)
//                    }else if apiStatusString == "404" {
//                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try? JSONDecoder().decode(TwilloCallModel.ServerKeyErrorModel.self, from: data!)
////                        log.error("AuthError = \(result?.errors!.errorText)")
//                        completionBlock(nil,nil,result,nil)
//                    }
//                }
//            }else {
////                log.error("error = \(response.error?.localizedDescription)")
//                completionBlock(nil,nil,nil,response.error)
//            }
        }
    }

    func twilloAudioCallAction(user_id: String, session_Token: String, call_id: String, answer_type: String, completionBlock: @escaping (_ Success: Result<TwilloCallActionSuccessModel, Error>) -> Void) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.session_token : session_Token,
            API.Params.CallId : call_id,
            API.Params.AnswerType : answer_type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Twillo_Calls_Methods.TWILLO_AUDIO_CALL_ACTION_API, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(TwilloCallActionSuccessModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                
//                guard let res = response.value as? [String : Any] else { return }
////                log.verbose("Response = \(res)")
//                guard let apiStatus = res["status"] as? Any else { return }
//
//                if apiStatus is Int {
////                    log.verbose("apiStatus Int = \(apiStatus)")
//                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                    let result = try! JSONDecoder().decode(TwilloCallActionModel.TwilloCallActionSuccessModel.self, from: data)
////                    log.debug("Success = \(result.status ?? nil)")
//                    completionBlock(result,nil,nil,nil)
//
//                }else {
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloCallActionModel.TwilloCallActionErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,result,nil,nil)
//                    }else if apiStatusString == "404" {
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloCallActionModel.ServerKeyErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,nil,result,nil)
//                    }
//                }
                break
                
            case .failure(let error):
                completionBlock(.failure(error))
                break
            }
        }
    }
    
    func checkForTwilloCall(user_id: String, session_Token: String, call_id: Int, call_Type: String, completionBlock: @escaping (_ Success: Result<CheckTwilloCallSuccessModel, Error>) -> Void) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.session_token : session_Token,
            API.Params.CallId : call_id,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
            API.Params.CallType : call_Type
            ] as [String : Any]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Twillo_Calls_Methods.TWILLO_CHECK_FOR_ANSWER_API, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(CheckTwilloCallSuccessModel.self, from: data)
                    completionBlock(.success(model))
                }catch {
                    completionBlock(.failure(error))
                }
                break
                
            case .failure(let error):
                completionBlock(.failure(error))
                break
            }
            
//            if (response.value != nil) {
//                guard let res = response.value as? [String:Any] else {return}
////                log.verbose("Response = \(res)")
//                guard let apiStatus = res["api_status"] as? Any else {return}
//                if apiStatus is String {
////                    log.verbose("apiStatus Int = \(apiStatus)")
//                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                    let result = try! JSONDecoder().decode(CheckForTwilloCallModel.CheckForTwilloCallSuccessModel.self, from: data)
////                    log.debug("Success = \(result.apiText ?? nil)")
//                    completionBlock(result)
//
//                }else {
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(CheckForTwilloCallModel.CheckForTwilloCallErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,result,nil,nil)
//
//                    }else if apiStatusString == "404" {
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(CheckForTwilloCallModel.ServerKeyErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,nil,result,nil)
//                    }
//                }
//
//            }else {
////                log.error("error = \(response.error?.localizedDescription)")
//                completionBlock(nil,nil,nil,response.error)
//            }
        }
    }
    
    func twilloVideoCall(user_id: String, session_Token: String, recipient_Id: String, completionBlock: @escaping (_ Success: Result<TwilloVidooCallSuccessModel, Error>) -> Void) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.session_token : session_Token,
            API.Params.RecipientId : recipient_Id,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Twillo_Calls_Methods.TWILLO_CREATE_VIDEO_CALL_API, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
//            log.verbose("Response = \(response.value)")
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(TwilloVidooCallSuccessModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                break
            case .failure(let error):
                completionBlock(.failure(error))
                break
            }
            
//            if (response.value != nil) {
//                guard let res = response.value as? [String : Any] else {return}
////                log.verbose("Response = \(res)")
//                guard let apiStatus = res["status"] as? Any else {return}
//
//                if apiStatus is Int {
////                    log.verbose("apiStatus Int = \(apiStatus)")
//                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                    let result = try! JSONDecoder().decode(TwilloVidooCallModel.TwilloVidooCallSuccessModel.self, from: data)
////                    log.debug("Success = \(result.roomName ?? nil)")
//                    completionBlock(result,nil,nil,nil)
//                }else{
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloVidooCallModel.TwilloVidooCallErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,result,nil,nil)
//                    }else if apiStatusString == "404" {
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloVidooCallModel.ServerKeyErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,nil,result,nil)
//                    }
//                }
//
//            }else {
////                log.error("error = \(response.error?.localizedDescription)")
//                completionBlock(nil,nil,nil,response.error)
//            }
        }
    }
    
    func twilloVideoCallAction(user_id: String, session_Token: String, call_id: String, answer_type: String, completionBlock: @escaping (_ Success: Result<TwilloVideoCallActionSuccessModel, Error>) -> Void) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.session_token : session_Token,
            API.Params.CallId : call_id,
            API.Params.AnswerType : answer_type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Twillo_Calls_Methods.TWILLO_VIDEO_CALL_ACTION_API, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(TwilloVideoCallActionSuccessModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                break
            case .failure(let error):
                completionBlock(.failure(error))
                break
            }
            
//            if (response.value != nil) {
//                guard let res = response.value as? [String:Any] else {return}
////                log.verbose("Response = \(res)")
//                guard let apiStatus = res["status"]  as? Any else {return}
//                if apiStatus is Int{
////                    log.verbose("apiStatus Int = \(apiStatus)")
//                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                    let result = try! JSONDecoder().decode(TwilloVideoCallActionModel.TwilloVideoCallActionSuccessModel.self, from: data)
////                    log.debug("Success = \(result.status ?? nil)")
//                    completionBlock(result,nil,nil,nil)
//                }else{
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloVideoCallActionModel.TwilloVideoCallActionErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,result,nil,nil)
//                    }else if apiStatusString == "404" {
//                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
//                        let result = try! JSONDecoder().decode(TwilloVideoCallActionModel.ServerKeyErrorModel.self, from: data)
////                        log.error("AuthError = \(result.errors!.errorText)")
//                        completionBlock(nil,nil,result,nil)
//                    }
//                }
//            }else{
////                log.error("error = \(response.error?.localizedDescription)")
//                completionBlock(nil,nil,nil,response.error)
//            }
        }
    }
}
