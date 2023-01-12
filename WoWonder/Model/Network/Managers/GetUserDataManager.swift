

import Foundation
import Alamofire
import WowonderMessengerSDK

class GetUserDataManager {
    
    static let instance = GetUserDataManager()
    
    func getUserData(user_id: String, session_Token: String, fetch_type: String, completionBlock: @escaping (_ Success: UserDataResponse?, _ AuthError: GetUserDataModel.GetUserDataErrorModel?, _ ServerKeyError: GetUserDataModel.ServerKeyErrorModel?, Error?) ->()) {
        
        let convertUserId = Int(user_id) ?? 0
        
        let params = [
            API.Params.user_id : convertUserId,
            API.Params.FetchType : fetch_type,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
//        let jsonData = (try! JSONSerialization.data(withJSONObject: params, options: []))
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        log.verbose("Hamad API = \(API.GetUserData_Constants_Methods.GET_USER_Data_API) => \(params)")
        
        AF.request(API.GetUserData_Constants_Methods.GET_USER_Data_API + "\(session_Token)", method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).responseData (completionHandler: { (response) in
            
            if (response.value != nil) {
//                guard let res = response.value as? [String : Any] else { return }
//                guard let apiStatus = res["api_status"] else { return }
                
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(UserDataResponse.self, from: data)
                        completionBlock(result ,nil ,nil ,nil)
                    } catch {
                        print("Hamad ERROR \(error.localizedDescription)")
                    }
                    break
                    
                case .failure(let error):
                    print("Hamad FAILURE \(error.localizedDescription)")
                    break
                }
                
//                log.verbose("Response = \(res)")
                
//                if apiStatus is Int {
//                    let data = try? JSONSerialization.data(withJSONObject: res, options: [])
//                    let result = try? JSONDecoder().decode(GetUserDataModel.GetUserDataSuccessModel.self, from: data!)
////                    log.debug("Success = \(result?.userData ?? nil)")
//                    completionBlock(result ,nil ,nil ,nil)
//
//                }else {
//                    let apiStatusString = apiStatus as? String
//                    if apiStatusString == "400" {
////                        log.verbose("apiStatus String = \(apiStatus)")
//                        let data = try? JSONSerialization.data(withJSONObject: res, options: [])
//                        let result = try? JSONDecoder().decode(GetUserDataModel.GetUserDataErrorModel.self, from: data!)
////                        log.error("AuthError = \(result?.errors!.errorText)")
//                        completionBlock(nil ,result ,nil ,nil)
//
//                    }else if apiStatusString == "404" {
//                        let data = try? JSONSerialization.data(withJSONObject: res, options: [])
//                        let result = try? JSONDecoder().decode(GetUserDataModel.ServerKeyErrorModel.self, from: data!)
////                        log.error("AuthError = \(result?.errors!.errorText)")
//                        completionBlock(nil ,nil ,result ,nil)
//                    }
//                }
                
            }else {
//                log.error("error = \(response.error?.localizedDescription)")
                completionBlock(nil,nil,nil,response.error)
            }
        })
    }
}
