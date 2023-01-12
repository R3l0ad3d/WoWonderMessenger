//
//  BotttomSiteUserList.swift
//  WoWonder
//
//  Created by UnikApp on 10/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import Alamofire
import WowonderMessengerSDK

class BotttomSiteUserList {
    
    static let instance = BotttomSiteUserList()
    
    func deleteChat(user_id: String,session_Token: String, completionBlock: @escaping (_ Success:DeleteChatModel.DeleteChatSuccessModel?,_ AuthError:DeleteChatModel.DeleteChatErrorModel?,_ ServerKeyError:DeleteChatModel.ServerKeyErrorModel?, Error?) ->()){
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
        ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        
        AF.request(API.Chat_Methods.DELETE_CHAT_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
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
                
            }else {
                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        }
    }
    
    func blockUnblockUser(session_Token: String,blockTo_userId:String,block_Action:String, completionBlock: @escaping (_ Success:BlockUnblockModel.BlockUnblockSuccessModel?,_ AuthError:BlockUnblockModel.BlockUnblockErrorModel?,_ ServerKeyError:BlockUnblockModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.user_id : blockTo_userId,
            API.Params.BlockAction : block_Action,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.BlockUser_Methods.BLOCK_UNBLOCK_USERS_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(BlockUnblockModel.BlockUnblockSuccessModel.self, from: data)
                    log.debug("Success = \(result.blockStatus ?? "")")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(BlockUnblockModel.BlockUnblockErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(BlockUnblockModel.ServerKeyErrorModel.self, from: data)
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
    
    func addNotifyMute(session_Token: String, notify: String, chat_id: String) {
        let params = [API.Params.ServerKey : API.SERVER_KEY.Server_Key,
                      "notify": notify,
                      "type": "user",
                      "chat_id": chat_id] as [String : Any]
        
        AF.request(API.baseURL + "/api/mute?access_token=" + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] else {return}
                
                print("apiStatusCode ==> \(apiStatusCode)")
                
                if apiStatusCode as? Int == 200 {
                    
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    print("API.baseURL => \(API.baseURL)")
                    print("AppInstance.instance.sessionId => \(AppInstance.instance.sessionId)")
                    print("API.SERVER_KEY.Server_Key => \(API.SERVER_KEY.Server_Key)")
                    
                } else {
                    print(response.error?.localizedDescription as Any)
                }
            } else {
                
            }
        }
    }
    
    func archiveAdd(session_Token: String, archive: String, chat_id: String) {
        let params = [API.Params.ServerKey : API.SERVER_KEY.Server_Key,
                      "archive": archive,
                      "type": "user",
                      "chat_id": chat_id] as [String : Any]
        
        AF.request(API.baseURL + "/api/mute?access_token=" + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] else {return}
                
                print("apiStatusCode ==> \(apiStatusCode)")
                
                if apiStatusCode as? Int == 200 {
                    
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    print("API.baseURL => \(API.baseURL)")
                    print("AppInstance.instance.sessionId => \(AppInstance.instance.sessionId)")
                    print("API.SERVER_KEY.Server_Key => \(API.SERVER_KEY.Server_Key)")
                    
                } else {
                    print(response.error?.localizedDescription as Any)
                }
            } else {
                
            }
        }
    }
}
