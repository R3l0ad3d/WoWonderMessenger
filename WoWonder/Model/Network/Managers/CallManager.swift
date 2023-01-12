
import Foundation
import Alamofire
import WowonderMessengerSDK

class CallManager {
    
    static let instance = CallManager()
    
    func checkForAgoraCall(access_token: String, call_id: Int, completionBlock: @escaping (_ Success: Result<AgoraCheckCallModel, Error>) -> Void) {
        
        let params = [
            API.Params.CallId : call_id,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
            "type" : "check",
        ] as [String : Any]
        
        //        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        //        let decoded = String(data: jsonData, encoding: .utf8)!
        //        log.verbose("Decoded String = \(decoded)")
        
        AF.request("\(API.baseURL)/api/agora?access_token=\(access_token)", method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                
                //                if let string = String(data: data, encoding: .utf8) {
                //                    print("Data \(string)")
                //                }
                
                do {
                    let model = try JSONDecoder().decode(AgoraCheckCallModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                
            case .failure(let error):
                completionBlock(.failure(error))
            }
            
            //            if (response.value != nil) {
            //                guard let res = response.value as? [String:Any] else {return}
            //                log.verbose("Response = \(res)")
            //                guard let apiStatus = res["api_status"] as? Any else {return}
            //
            //                if apiStatus is String {
            ////                    log.verbose("apiStatus Int = \(apiStatus)")
            //                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
            //                    let result = try! JSONDecoder().decode(CheckForAgoraCallModel.CheckForAgoraCallSuccessModel.self, from: data)
            ////                    log.debug("Success = \(result.apiText ?? nil)")
            //                    completionBlock(result,nil,nil,nil)
            //
            //                }else {
            //                    let apiStatusString = apiStatus as? String
            //                    if apiStatusString == "400" {
            ////                        log.verbose("apiStatus String = \(apiStatus)")
            //                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
            //                        let result = try! JSONDecoder().decode(CheckForAgoraCallModel.CheckForAgoraCallErrorModel.self, from: data)
            ////                        log.error("AuthError = \(result.errors!.errorText)")
            //                        completionBlock(nil,result,nil,nil)
            //                    }else if apiStatusString == "404" {
            //                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
            //                        let result = try! JSONDecoder().decode(CheckForAgoraCallModel.ServerKeyErrorModel.self, from: data)
            ////                        log.error("AuthError = \(result.errors!.errorText)")
            //                        completionBlock(nil,nil,result,nil)
            //                    }
            //                }
            //
            //            }else{
            ////                log.error("error = \(response.error?.localizedDescription)")
            //                completionBlock(nil,nil,nil,response.error)
            //            }
        }
    }
    
    func agoraCallAction(access_token: String, call_id: String, action: String, completionBlock: @escaping (_ Success: Result<AgoraCallActionSuccessModel, Error>) -> Void) {
        
        let params = [
            API.Params.CallId : call_id,
            "type" : "action",
            "action" : action,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
        ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        
        AF.request("\(API.baseURL)/api/agora?access_token=\(access_token)", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                
                if let string = String(data: data, encoding: .utf8) {
                    print("Data \(string)")
                }
                
                do {
                    let model = try JSONDecoder().decode(AgoraCallActionSuccessModel.self, from: data)
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
            //                    let result = try! JSONDecoder().decode(AgoraCallActionModel.AgoraCallActionSuccessModel.self, from: data)
            ////                    log.debug("Success = \(result.status ?? nil)")
            //                    completionBlock(result,nil,nil,nil)
            //                }else{
            //                    let apiStatusString = apiStatus as? String
            //                    if apiStatusString == "400" {
            ////                        log.verbose("apiStatus String = \(apiStatus)")
            //                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
            //                        let result = try! JSONDecoder().decode(AgoraCallActionModel.AgoraCallActionErrorModel.self, from: data)
            ////                        log.error("AuthError = \(result.errors!.errorText)")
            //                        completionBlock(nil,result,nil,nil)
            //                    }else if apiStatusString == "404" {
            //                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
            //                        let result = try! JSONDecoder().decode(AgoraCallActionModel.ServerKeyErrorModel.self, from: data)
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
    
    func agoraCall(recipient_id: String,
                   access_token: String,
                   type: String,
                   call_Type: String,
                   token: String? = nil,
                   completionBlock: @escaping (_ Success: Result<AgoraCallSuccessModel, Error>) -> Void) {
        
        let params = [ API.Params.RecipientId : recipient_id,
                       "type" : type,
                       API.Params.CallType : call_Type,
                       "token" : token ?? "",
                       API.Params.ServerKey : API.SERVER_KEY.Server_Key] as [String : Any]
        
        AF.request("\(API.baseURL)/api/agora?access_token=\(access_token)", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(AgoraCallSuccessModel.self, from: data)
                    completionBlock(.success(model))
                } catch {
                    completionBlock(.failure(error))
                }
                
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
}
