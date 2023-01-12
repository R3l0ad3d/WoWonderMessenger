//
//  FollowRequestActionManager.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/18/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import Foundation
import Alamofire
import WowonderMessengerSDK

class FollowRequestActionManager {
    
    static let sharedInstance = FollowRequestActionManager()
    
    func followRequestAction(user_Id: String,action: String,completionBlock : @escaping (_ Success:FollowRequestActionModal.FollowRequest_SuccessModal?, _ AuthError :FollowRequestActionModal.FollowRequest_ErrorModel?, Error?)->()){
        
        let params = [API.Params.ServerKey:API.SERVER_KEY.Server_Key,API.Params.user_id:user_Id,API.Params.requestAction:action]
        
        AF.request(API.Following_Methods.Accept_DeclineRequest + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] as? Any else {return}
                if apiStatusCode as? Int == 200{
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    guard let result = try? JSONDecoder().decode(FollowRequestActionModal.FollowRequest_SuccessModal.self, from: data) else {return}
                    completionBlock(result,nil,nil)
                }
                else{
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    guard let result = try? JSONDecoder().decode(FollowRequestActionModal.FollowRequest_ErrorModel.self, from: data) else {return}
                    completionBlock(nil,result,nil)
                }
            }
            else {
                print(response.error?.localizedDescription)
                completionBlock(nil,nil,response.error)
            }
        }
    }
    
    
    func followRequest(user_Id: String,
                       ServerKey: String,
                       completionBlock : @escaping (_ Success: String, Error?)->()){
        
        let params = [API.Params.ServerKey:API.SERVER_KEY.Server_Key,
                      API.Params.user_id:user_Id]
        
        AF.request(API.Following_Methods.FOLLOW_UNFOLLOW_API + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"]  else {return}
                guard let followstatus = res["follow_status"]else {return}
                if apiStatusCode as? Int == 200{
                    completionBlock(followstatus as! String,nil)
                }
            } else {
                completionBlock("",response.error)
            }
        }
    }
}
