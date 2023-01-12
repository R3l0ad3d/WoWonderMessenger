//
//  GetFriendRequestManager.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/17/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import Foundation
import Alamofire
import WowonderMessengerSDK

class GetFriendRequestManager{
    
    static let sharedInstance = GetFriendRequestManager()
    private init() {}
    
    //MARK: - GetFriendRequest Api call
    func getFriendRequest(completionBlock : @escaping (_ Success:GetFriendRequestModal.getFirend_RequestSuccessModal?, _ AuthError :GetFriendRequestModal.getFirend_Request_ErrorModel?, Error?)->()){
        
        let params = [API.Params.ServerKey: API.SERVER_KEY.Server_Key,
                      API.Params.FetchType: API.Params.friendRequest]
        
        AF.request(API.Following_Methods.GetFollow_Request + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response.value)
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] as? Any else {return}
                if apiStatusCode as? Int == 200{
                    let result = GetFriendRequestModal.getFirend_RequestSuccessModal.init(json: res)
                    completionBlock(result,nil,nil)
                }
                else {
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    guard let result = try? JSONDecoder().decode(GetFriendRequestModal.getFirend_Request_ErrorModel.self, from: data) else {return}
                    completionBlock(nil,result,nil)
                }
            }
            else {
                print(response.error?.localizedDescription)
                completionBlock(nil,nil,response.error)
            }
        }
    }
    
    //MARK: - FetchGroupRequest Api call
    func fetchGroupRequest(session_Token: String,fetchType:String,offset:Int,setOnline:Int,completionBlock: @escaping (_ Success:GroupRequestModel.GroupRequestSuccessModel?,_ AuthError:GroupRequestModel.GroupRequestErrorModel?,_ ServerKeyError:UserSuggestionModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.FetchType : "group_chat_requests",
            API.Params.offset : offset,
            API.Params.SetOnline : setOnline,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
        ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_REQUEST_API.GROUP_REQUEST_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"] else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try? JSONDecoder().decode(GroupRequestModel.GroupRequestSuccessModel.self, from: data!)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try? JSONDecoder().decode(GroupRequestModel.GroupRequestErrorModel.self, from: data!)
                        log.error("AuthError = \(result?.errors!.errorText  ?? "")")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try? JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try? JSONDecoder().decode(UserSuggestionModel.ServerKeyErrorModel.self, from: data!)
                        log.error("AuthError = \(result?.errors!.errorText  ?? "")")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription ?? "")")
                completionBlock(nil,nil,nil,response.error)
            }
        }
    }
    
    //MARK: - accceptGroupRequest Api call
    func accceptGroupRequest(session_Token: String,
                             type: String,
                             groupID: Int,
                             userid: String,
                             completionBlock: @escaping (_ Success:AcceptGroupRequestModel.AcceptGroupRequestSuccessModel?,_ AuthError:AcceptGroupRequestModel.AcceptGroupRequestErrorModel?,_ ServerKeyError:AcceptGroupRequestModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [API.Params.requestAction : type,
                      API.Params.ServerKey : API.SERVER_KEY.Server_Key,
                      API.Params.group_id : groupID,
                      API.Params.user_id: userid] as [String : Any]
        
        
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_REQUEST_API.ACCEPT_GROUP_REQUEST_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(AcceptGroupRequestModel.AcceptGroupRequestSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(AcceptGroupRequestModel.AcceptGroupRequestErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(AcceptGroupRequestModel.ServerKeyErrorModel.self, from: data)
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
    
    //MARK: - RejectGroupRequest Api call
    func rejectGroupRequest(session_Token: String,
                            type:String,
                            groupID: Int,
                            userID: String,
                            completionBlock: @escaping (_ Success:RejectGroupRequestModel.RejectGroupRequestSuccessModel?,_ AuthError:RejectGroupRequestModel.RejectGroupRequestErrorModel?,_ ServerKeyError:RejectGroupRequestModel.ServerKeyErrorModel?, Error?) ->()){
        
//        let params = [
//
//            API.Params.groupType : "delete_request",
//            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
//            API.Params.group_id : groupID
//        ] as [String : Any]
        
        let params = [API.Params.ServerKey : API.SERVER_KEY.Server_Key,
                      "type": type,
                      "group_id": groupID,
                      "user_id": userID,
                      ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.GROUP_REQUEST_API.REJECT_GROUP_REQUEST_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(RejectGroupRequestModel.RejectGroupRequestSuccessModel.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(RejectGroupRequestModel.RejectGroupRequestErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(AcceptGroupRequestModel.ServerKeyErrorModel.self, from: data)
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
