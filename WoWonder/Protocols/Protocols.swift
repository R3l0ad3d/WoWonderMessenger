
import Foundation
import UIKit

protocol GenderDelegate {
    func selectGender(text:String,Index:Int)
}

protocol FollowUnFollowDelegate {
    func followUnfollow(user_id:String,index:Int,cellBtn:UIButton)
}

protocol ImagePickerDelegate{
    func pickImage(image:UIImage? , videoData:Data?,videoURL:URL? ,Status:Bool?)
}

protocol PlayVideoDelegate {
    func playVideo(index:Int,status:Bool)
}

protocol PlayAudioDelegate {
    func playAudio(index:Int,status:Bool,url:URL,button:UIButton)
}

protocol SelectFileDelegate {
    func selectImage(status:Bool)
    func selecVideo(status:Bool)
}

protocol SelectContactDetailDelegate {
    func selectContact(caontectName:String, ContactNumber:String)
}

protocol SelectContactCallsDelegate {
    func selectCalls(index:Int,type:String)
}

protocol SelectRandomDelegate {
    func selectRandom(recipientID:String, searchObject:SearchModel.User)
}

protocol CallReceiveDelegate {
    func receiveCall(callId:Int,RoomId:String,callingType:String,username:String,profileImage:String,accessToken:String?)
}

protocol SelectLanguageDelegate {
    func selectLanguage(index:Int,Button:UIButton)
}

protocol SearchDelegate{
    func locationSearch(location: String, countryId: String)
    func filterSearch(gender: String, countryId: String, ageTo: String, ageFrom: String, verified: String, status: String, profilePic: String,filterByAge:String)
}

protocol FollowRequestDelegate{
    func follow_request(index: Int)
}

protocol didSelectGIFDelegate {
    func didSelectGIF(GIFUrl:String,id: String)
}

protocol sendLocationProtocol {
    func sendLocation(lat: Double, long: Double)
}

