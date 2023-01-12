

import Foundation
import Alamofire
import WowonderMessengerSDK

class StoriesManager {
    
    static let instance = StoriesManager()
    
    func getStories(session_Token: String,limit:Int, completionBlock: @escaping (_ Success: StoriesResponse?, _ AuthError:GetStoriesModel.GetStoriesErrorModel?, _ ServerKeyError:GetStoriesModel.ServerKeyErrorModel?, Error?) ->()){

        let params = [
            API.Params.List_id : limit,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        
        log.verbose("Decoded String = \(decoded)")
        
//        AF.request(API.Stories_Constants_Methods.GET_STORIES_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseData { (response) in
//
//            if (response.value != nil) {
//
//                switch response.result {
//                case .success(let data):
//                        let result = try JSONDecoder().decode(StoriesResponse.self, from: data)
//                        completionBlock(result,nil,nil,nil)
//                    break
//                case .failure(let error):
//                    print("HAMAD ERROR \(error.localizedDescription)")
//                    break
//                }
//            }else{
//                completionBlock(nil,nil,nil,response.error)
//            }
//        }
        AF.request(API.Stories_Constants_Methods.GET_STORIES_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"] else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value as Any, options: [])
                    let result = try! JSONDecoder().decode(StoriesResponse.self, from: data)
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value as Any, options: [])
                        let result = try! JSONDecoder().decode(GetStoriesModel.GetStoriesErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText ?? "")")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(GetStoriesModel.ServerKeyErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText ?? "")")
                        completionBlock(nil,nil,result,nil)
                    }
                }
            }else{
                log.error("error = \(response.error?.localizedDescription ?? "")")
                completionBlock(nil,nil,nil,response.error)
            }
        })
    }
    
    func createStory(session_Token: String,type:String,storyDescription:String,storyTitle:String,data:Data?, completionBlock: @escaping (_ Success:CreateStoryModel.CreateStorySuccessModel?,_ AuthError:CreateStoryModel.CreateStoryErrorModel?,_ ServerKeyError:CreateStoryModel.ServerKeyErrorModel?, Error?) ->()){
        
        let params = [
            API.Params.FileType : type,
            API.Params.StoryDescription : storyDescription,
            API.Params.StoryTitle : storyTitle,
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
            if let data = data{
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/png")
            }
            
        }, to: API.Stories_Constants_Methods.CREATE_STORY_API + "\(session_Token)", usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            print("Succesfully uploaded")
            log.verbose("response = \(response.value)")
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(CreateStoryModel.CreateStorySuccessModel.self, from: data)
                    log.debug("Success = \(result.storyID ?? nil)")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(CreateStoryModel.CreateStoryErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(CreateStoryModel.ServerKeyErrorModel.self, from: data)
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
    func deleteStory(session_Token: String,story_id:String, completionBlock: @escaping (_ Success:DeleteStoryModel.DeleteStorySuccessModel?,_ AuthError:DeleteStoryModel.DeleteStoryErrorModel?,_ ServerKeyError:DeleteStoryModel.ServerKeyErrorModel?, Error?) ->()){
        let converted = Int(story_id)
        let params = [
            API.Params.storyID : converted,
            API.Params.ServerKey : API.SERVER_KEY.Server_Key
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        log.verbose("Decoded String = \(decoded)")
        AF.request(API.Stories_Constants_Methods.DELETE_STORY_API + "\(session_Token)", method: .post, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            if (response.value != nil){
                guard let res = response.value as? [String:Any] else {return}
                log.verbose("Response = \(res)")
                guard let apiStatus = res["api_status"]  as? Any else {return}
                if apiStatus is Int{
                    log.verbose("apiStatus Int = \(apiStatus)")
                    let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                    let result = try! JSONDecoder().decode(DeleteStoryModel.DeleteStorySuccessModel.self, from: data)
                    log.debug("Success = \(result.message ?? "")")
                    completionBlock(result,nil,nil,nil)
                }else{
                    let apiStatusString = apiStatus as? String
                    if apiStatusString == "400" {
                        log.verbose("apiStatus String = \(apiStatus)")
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteStoryModel.DeleteStoryErrorModel.self, from: data)
                        log.error("AuthError = \(result.errors!.errorText)")
                        completionBlock(nil,result,nil,nil)
                    }else if apiStatusString == "404" {
                        let data = try! JSONSerialization.data(withJSONObject: response.value, options: [])
                        let result = try! JSONDecoder().decode(DeleteStoryModel.ServerKeyErrorModel.self, from: data)
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
