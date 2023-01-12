//
//  ArchivedManager.swift
//  WoWonder
//
//  Created by UnikaApp on 14/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import WowonderMessengerSDK

class ArchivedManager {
    static let instance = ArchivedManager()
    
    func getArchivedChats(session_Token: String, completionBlock: @escaping (_ Success: ArchivedModel?, Error?) ->()) {
        let params = [API.Params.ServerKey : API.SERVER_KEY.Server_Key] as [String : Any]
        
        AF.request(API.baseURL + "/api/get_archived_chats?access_token=" + "\(AppInstance.instance.sessionId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.value != nil{
                guard let res = response.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] else {return}
                
                print("apiStatusCode ==> \(apiStatusCode)")
                
                if apiStatusCode as? Int == 200 {
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    
                    let result = try! JSONDecoder().decode(ArchivedModel.self, from: data)
                    completionBlock(result,nil)
                    
                } else {
                    print(response.error?.localizedDescription as Any)
                }
            } else {
                
            }
        }
    }        
}
