

import Foundation
import Alamofire
import WowonderMessengerSDK

class GetUserListManager {
    
    static let instance = GetUserListManager()
    
    func getUserList(user_id: String, session_Token: String, _ completionBlock: @escaping (Result<UserModelResponse, Error>) -> Void) {
        
        let params = [
            API.Params.data_type : "users",
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        AF.request(API.GetUserList_Constants_Methods.GET_USER_LIST_API+session_Token, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            if (response.value != nil) {
                switch response.result {
                case .success(let data):
                    do {
                        let object = try JSONDecoder().decode(UserModelResponse.self, from: data)
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
