
import UIKit
import Toast_Swift
import JGProgressHUD
import SwiftEventBus
import ContactsUI
import Async
import OneSignal
import WowonderMessengerSDK
import BSImagePicker
import Photos
import GoogleMobileAds
import CommonCrypto
import SwiftUI

class BaseVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let tempMsg = ["Hi","Hello", "Hello there can we talk?","How you doing", "You there?"]
    var hud: JGProgressHUD?
    
    private var noInternetVC: NoInternetDialogVC!
    var userId: String? = nil
    var sessionId: String? = nil
    var contactNameArray = [String]()
    var contactNumberArray = [String]()
    var deviceID: String? = ""
    var oneSignalID: String? = ""
    
    //For imagePicker
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    let imagePicker = ImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneSignalID = OneSignal.getDeviceState().userId
        print("Current playerId \(oneSignalID)")
        UserDefaults.standard.setDeviceId(value: oneSignalID ?? "",ForKey: Local.DEVICE_ID.DeviceId)
        self.dismissKeyboard()
        
        oneSignalID = UserDefaults.standard.getDeviceId(Key: "deviceID")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        
        //        self.deviceID = UserDefaults.standard.getDeviceId(Key: Local.DEVICE_ID.DeviceId)
        //        noInternetVC = R.storyboard.main.noInternetDialogVC()
        //
        //        //Internet connectivity event subscription
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_CONNECTED) { result in
            //            self.CheckForUserCAll()
            //            log.verbose("Internet connected!")
            //            self.noInternetVC.dismiss(animated: true, completion: nil)
        }
        
        //Internet connectivity event subscription
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_DIS_CONNECTED) { result in
            //            log.verbose("Internet dis connected!")
            //                self.present(self.noInternetVC, animated: true, completion: nil)
        }
        
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_CONNECT_SOCKET_CALL) { result in
            
            
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        //..
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        //..
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if !Connectivity.isConnectedToNetwork() {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        ////                self.present(self.noInternetVC, animated: true, completion: nil)
        //            })
        //        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}

// MARK: - CUSTOM FUNCTIONS

extension BaseVC {
    
    func decryptionAESModeECB(messageData: String, key: String) -> String? {
        
        let dataKey = Data(messageData.utf8)
        guard let messageString = String(data: dataKey, encoding: .utf8) else { return nil }
        guard let data = Data(base64Encoded: messageString, options: .ignoreUnknownCharacters) else { return nil }
        guard let keyData = key.data(using: String.Encoding.utf8) else { return nil }
        guard let cryptData = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) else { return nil }
        
        let keyLength               = size_t(kCCKeySizeAES128)
        let operation:  CCOperation = UInt32(kCCDecrypt)
        let algoritm:   CCAlgorithm = UInt32(kCCAlgorithmAES)
        let options:    CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let iv:         String      = ""
        
        var numBytesEncrypted: size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  iv,
                                  (data as NSData).bytes, data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        if cryptStatus < 0 {
            return nil
            
        }else {
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                var str = String(decoding : cryptData as Data, as: UTF8.self)
                
                if str.isEmpty {
                    return messageData
                }else {
                    str = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    return str
                }
                
            } else {
                return messageData
            }
        }
    }
    
    func getUserSession() {
        //        log.verbose("getUserSession = \(UserDefaults.standard.getUserSessions(Key: Local.USER_SESSION.User_Session))")
        let localUserSessionData = UserDefaults.standard.getUserSessions(Key: Local.USER_SESSION.User_Session)
        
        self.userId = localUserSessionData[Local.USER_SESSION.User_id] as! String
        self.sessionId = localUserSessionData[Local.USER_SESSION.Access_token] as! String
    }
    
    func showProgressDialog(text: String) {
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = text
        hud?.show(in: self.view)
    }
    
    func dismissProgressDialog(completionBlock: @escaping () ->()) {
        hud?.dismiss()
        completionBlock()
    }
    
    func fetchContacts() {
        
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
        ] as [Any]
        
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber,
                       let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        self.contactNameArray.append(contact.givenName)
                        self.contactNumberArray.append(number.stringValue)
                        //                        print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
                    }
                }
            }
            //            print(contacts)
        } catch {
            //            print("unable to fetch contacts")
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset,
                             targetSize: PHImageManagerMaximumSize,
                             contentMode: .aspectFit,
                             options: option,
                             resultHandler: {(result, info)->Void in
            image = result ?? UIImage()
        })
        return image
    }
    
    func setLocalDate(timeStamp: String?) -> String {
        guard let time = timeStamp else { return "" }
        let localTime = Double(time) //else { return ""}
        let date = Date(timeIntervalSince1970: localTime ?? 0.0)
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "HH:mm"
        let dateString = format.string(from: date)
        return dateString
    }
    
    private func CheckForUserCAll() {
        
        Async.background({
            GetUserListManager.instance.getUserList(user_id: AppInstance.instance._userId,
                                                    session_Token: AppInstance.instance._sessionId) { (result) in
                
                switch result {
                case .success(let model):
                    Async.main({
                        self.dismissProgressDialog {
                            //                            guard let data = model.data else { return }
                            //                            guard let status = model.apiStatus else { return }
                            //                            guard let videoCall = model.videoCall else { return }
                            //                            guard let audioCall = model.audioCall else { return }
                            guard let agoraCall = model.agoraCall else { return }
                            
                            //                            guard let status = success?["api_status"] as? Int else { return }
                            //                            guard let videoCall = success?["video_call"] as? Bool else { return }
                            //                            log.debug("userList = \(agoraCall ?? false)")
                            
                            let alert = UIAlertController(title: NSLocalizedString("Calling", comment: "Calling"), message: NSLocalizedString("someone is calling you", comment: "someone is calling you"), preferredStyle: .alert)
                            
                            if agoraCall == true {
                                let answer = UIAlertAction(title: NSLocalizedString("Answer", comment: "Answer"), style: .default, handler: { (action) in
                                    //                                    log.verbose("Answer Call")
                                    let vc = VideoCallVIewController.instantiate()
                                    self.navigationController?.pushViewController(vc, animated: true)
                                })
                                let decline = UIAlertAction(title: NSLocalizedString("Decline", comment: "Decline"), style: .default, handler: { (action) in
                                    //                                    log.verbose("Call decline")
                                    //                                    log.verbose("Room name = \(roomName)")
                                    //                                    log.verbose("CallID = \(callId)")
                                })
                                alert.addAction(answer)
                                alert.addAction(decline)
                                self.present(alert, animated: true, completion: nil)
                            }else {
                                alert.dismiss(animated: true, completion: nil)
                                //                                log.verbose("There is no call to answer..")
                            }
                        }
                    })
                    break
                    
                case .failure(_):
                    Async.main({
                        self.dismissProgressDialog {
                            //                            self.view.makeToast(error?.localizedDescription)
                            //                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                    break
                }
            }
        })
    }
}

extension BaseVC {
    
    func dataatual(_ tipo:Int) -> String {
            let date = Date()
            let formatter = DateFormatter()
            if tipo == 1{
                formatter.dateFormat = "dd/MM/yyyy"
            } else if tipo == 2{
                formatter.dateFormat = "HH:mm"
            } else {
                formatter.dateFormat = "dd/MM/yyyy"
            }

            return formatter.string(from: date)
        }
    
    
    //MARK: - setTimestamp
    func setTimestamp(epochTime: String) -> String {
        let currentDate = Date()
        let epochDate = Date(timeIntervalSince1970: TimeInterval(epochTime) ?? 0.0)
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: currentDate)
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinutes = calendar.component(.minute, from: currentDate)
        let currentSeconds = calendar.component(.second, from: currentDate)
        let epochDay = calendar.component(.day, from: epochDate)
        let epochMonth = calendar.component(.month, from: epochDate)
        let epochYear = calendar.component(.year, from: epochDate)
        let epochHour = calendar.component(.hour, from: epochDate)
        let epochMinutes = calendar.component(.minute, from: epochDate)
        let epochSeconds = calendar.component(.second, from: epochDate)
        
        if (currentDay - epochDay < 30) {
            if (currentDay == epochDay) {
                if (currentHour - epochHour == 0) {
                    if (currentMinutes - epochMinutes == 0) {
                        if (currentSeconds - epochSeconds <= 1) {
                            return String(currentSeconds - epochSeconds) + " second ago"
                        } else {
                            return String(currentSeconds - epochSeconds) + " seconds ago"
                        }
                        
                    } else if (currentMinutes - epochMinutes <= 1) {
                        return String(currentMinutes - epochMinutes) + " minute ago"
                    } else {
                        return String(currentMinutes - epochMinutes) + " minutes ago"
                    }
                } else if (currentHour - epochHour <= 1) {
                    return String(currentHour - epochHour) + " hour ago"
                } else {
                    return String(currentHour - epochHour) + " hours ago"
                }
            } else if (currentDay - epochDay <= 1) {
                return String(currentDay - epochDay) + " day ago"
            } else {
                return String(currentDay - epochDay) + " days ago"
            }
        } else {
            return String(epochDay) + " " + getMonthNameFromInt(month: epochMonth) + " " + String(epochYear)
        }
    }
    
    //MARK: - getMonthNameFromInt
    func getMonthNameFromInt(month: Int) -> String {
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
    
    //MARK: - convertToDictionary
    func convertStringToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: String.Encoding(rawValue: NSUTF8StringEncoding)) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

// MARK: - Extension to show alert
extension UIViewController{
    
    //MARK: - showBasicAlert
    func showBasicAlert(title : String?, message : String) {
        // Show alert
        let alertController: UIAlertController = UIAlertController(title: title == nil ? "Title" : title!, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: { action in
            alertController .dismiss(animated: true, completion: nil)
        })
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
