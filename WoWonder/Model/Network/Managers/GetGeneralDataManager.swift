//
//  
//  GetGeneralData.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit
import Alamofire
import WowonderMessengerSDK

class GetGeneralDataManager {
    
    static let instance = GetGeneralDataManager()
    
    func getUserList(session_Token: String, setOnline: Int = 1, _ completionBlock: @escaping (Result<GeneralDataResponse, Error>) -> Void) {
        //        let convertUserId = Int(user_id)
        
        let params = [
            API.Params.FetchType : "announcement,group_chat_requests,notifications,count_new_messages,friend_requests",
            API.Params.ServerKey : API.SERVER_KEY.Server_Key,
            "SetOnline" : setOnline,
        ] as [String : Any]
        
        AF.request("\(API.GROUP_REQUEST_API.GROUP_REQUEST_API)\(session_Token)", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            if (response.value != nil) {
                switch response.result {
                case .success(let data):
                    
                    //                    if let string = String(data: data, encoding: .utf8) {
                    //                        print("Hamad Response = \(string)")
                    //                    }
                    
                    do {
                        let object = try JSONDecoder().decode(GeneralDataResponse.self, from: data)
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
}
