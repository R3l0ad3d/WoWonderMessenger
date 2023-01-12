

import UIKit
import WowonderMessengerSDK
import AVFoundation
import AVKit
import Async
import Kingfisher

class FavoriteVC: BaseVC {
    
    //MARK: - All IBOutlet This ViewController
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrennTitleLabel: UILabel!
    
    //MARK: Variables
    var index: Int? = 0
    var recipientID: String? = ""
    var chatModel: Chats?
    var messagesArray: [MessageModel] = []
//        didSet {
//            self.chatModel?.addToMessages(NSSet(array: self.messagesArray))
//            self.chatModel?.save()
//            guard let lastMsg = self.messagesArray.last,
//                  let user = self.chatModel?.getFirstChatUser()?.user else {
//                return
//            }
//            user.save()
//        }
//    }
    var DocUrl = ""
    var isFistTry = true
    var issetledIndex = 0
    var audioDuration = ""
    var FavoriteMessageListArray: [MessagePin] = []
    private var player = AVPlayer()
    private var playerItem: AVPlayerItem!
    private var playerController = AVPlayerViewController()
    private var isColor = ""
    var profileImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ProductTableCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.setupUI()
        self.fecthFavoriteData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        self.isColor = objColor as? String ?? ""
    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        self.tableView.separatorStyle = .none
        
        let leftTextXIB = UINib(nibName: "LeftTextTableViewCell", bundle: nil)
        self.tableView.register(leftTextXIB, forCellReuseIdentifier: "LeftTextTableViewCell")
        
        let rightTextXIB = UINib(nibName: "RightTextTableViewCell", bundle: nil)
        self.tableView.register(rightTextXIB, forCellReuseIdentifier: "RightTextTableViewCell")
        
        let rightImageXIB = UINib(nibName: "RightImageTableViewCell", bundle: nil)
        self.tableView.register(rightImageXIB, forCellReuseIdentifier: "RightImageTableViewCell")
        
        let leftImageXIB = UINib(nibName: "LeftImageTableViewCell", bundle: nil)
        self.tableView.register(leftImageXIB, forCellReuseIdentifier: "LeftImageTableViewCell")
        
        let leftDocXIB = UINib(nibName: "LeftDocumentTableViewCell", bundle: nil)
        self.tableView.register(leftDocXIB, forCellReuseIdentifier: "LeftDocumentTableViewCell")
        
        let rightDocXIB = UINib(nibName: "RightDocumentTableViewCell", bundle: nil)
        self.tableView.register(rightDocXIB, forCellReuseIdentifier: "RightDocumentTableViewCell")
        
        let leftVidoeXIB = UINib(nibName: "LeftVidoeTableViewCell", bundle: nil)
        self.tableView.register(leftVidoeXIB, forCellReuseIdentifier: "LeftVidoeTableViewCell")
        
        let rightVidoeXIB = UINib(nibName: "RightVidoeTableViewCell", bundle: nil)
        self.tableView.register(rightVidoeXIB, forCellReuseIdentifier: "RightVidoeTableViewCell")
        
        let rightGiftXIB = UINib(nibName: "RightGiftTableViewCell", bundle: nil)
        self.tableView.register(rightGiftXIB, forCellReuseIdentifier: "RightGiftTableViewCell")
        
        let leftGiftXIB = UINib(nibName: "LeftGiftTableViewCell", bundle: nil)
        self.tableView.register(leftGiftXIB, forCellReuseIdentifier: "LeftGiftTableViewCell")
        
        let LeftLocationXIB = UINib(nibName: "LeftLocationTableViewCell", bundle: nil)
        self.tableView.register(LeftLocationXIB, forCellReuseIdentifier: "LeftLocationTableViewCell")
        
        let RightLocationXIB = UINib(nibName: "RightLocationTableViewCell", bundle: nil)
        self.tableView.register(RightLocationXIB, forCellReuseIdentifier: "RightLocationTableViewCell")
        
        let leftAudioXIB = UINib(nibName: "LeftAudioTableViewCell", bundle: nil)
        self.tableView.register(leftAudioXIB, forCellReuseIdentifier: "LeftAudioTableViewCell")
        
        let rightAudioXIB = UINib(nibName: "RightAudioTableViewCell", bundle: nil)
        self.tableView.register(rightAudioXIB, forCellReuseIdentifier: "RightAudioTableViewCell")
        
        let messageDateXIB = UINib(nibName: "MessageDateTableViewCell", bundle: nil)
        self.tableView.register(messageDateXIB, forCellReuseIdentifier: "MessageDateTableViewCell")
        
        let leftContact = UINib(nibName: "LeftContactTableViewCell", bundle: nil)
        self.tableView.register(leftContact, forCellReuseIdentifier: "LeftContactTableViewCell")
        
        let rightContact = UINib(nibName: "RightContactTableViewCell", bundle: nil)
        self.tableView.register(rightContact, forCellReuseIdentifier: "RightContactTableViewCell")
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func fecthFavoriteData() {
        for index in 0..<messagesArray.count {
            let objPin = messagesArray[index]
            
            if objPin.fav == "true" {
                self.FavoriteMessageListArray.append(MessagePin(pin: objPin.pin ?? "",
                                                                mediaURl: objPin.media ?? "",
                                                                type: objPin._type,
                                                                time: objPin.timeText,
                                                                isfavourite: objPin.fav,
                                                                _media_file_name: objPin.mediaFileName ?? "",
                                                                text: objPin.text,
                                                                stickers: objPin.stickers))
                self.tableView.isHidden = FavoriteMessageListArray.isEmpty
                self.noDataImage.isHidden = !FavoriteMessageListArray.isEmpty
                self.noDataLabel.isHidden = !FavoriteMessageListArray.isEmpty
                self.tableView.reloadData()
            } else  {
                self.tableView.isHidden = FavoriteMessageListArray.isEmpty
                self.noDataImage.isHidden = !FavoriteMessageListArray.isEmpty
                self.noDataLabel.isHidden = !FavoriteMessageListArray.isEmpty
            }
            
        }
    }
    
    //MARK: - getThumbnailImage
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

//MARK: - UITableViewDelegate & DataSource
extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.FavoriteMessageListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objChatList = FavoriteMessageListArray[indexPath.row]
        
        guard let type = objChatList.type else { return UITableViewCell() }
        switch type {
        case "left_text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftTextTableViewCell", for: indexPath) as? LeftTextTableViewCell
            self.setLeftTextData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as? RightTextTableViewCell
            self.setRightTextData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_image":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightImageTableViewCell", for: indexPath) as? RightImageTableViewCell
            self.setRightImageData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_image":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftImageTableViewCell", for: indexPath) as? LeftImageTableViewCell
            self.setLeftImageData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_video":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftVidoeTableViewCell", for: indexPath) as? LeftVidoeTableViewCell
            self.setLeftVidoeData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_video":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightVidoeTableViewCell", for: indexPath) as? RightVidoeTableViewCell
            self.setRightVidoeData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_gif":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightGiftTableViewCell", for: indexPath) as? RightGiftTableViewCell
            self.setRightGiftData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_gif":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftGiftTableViewCell", for: indexPath) as? LeftGiftTableViewCell
            self.setLeftGiftData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_contact":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftContactTableViewCell", for: indexPath) as? LeftContactTableViewCell
            self.setLeftContactCell(cell: cell, indexpathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_contact":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightContactTableViewCell", for: indexPath) as? RightContactTableViewCell
            self.setRightContactCell(cell: cell, indexpathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_file":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightDocumentTableViewCell", for: indexPath) as? RightDocumentTableViewCell
            self.setRightDocumnetData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_file":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftDocumentTableViewCell", for: indexPath) as? LeftDocumentTableViewCell
            self.setLeftDocumnetData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_audio":
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftAudioTableViewCell", for: indexPath) as? LeftAudioTableViewCell
            return cell ?? UITableViewCell()
            
        case "right_audio":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightAudioTableViewCell", for: indexPath) as? RightAudioTableViewCell
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: - setLeftTextData
    private func setLeftTextData(cell: LeftTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        let url = URL(string: profileImage )
        cell?.userProfileImageView.kf.indicatorType = .activity
        cell?.userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.text ?? "", key: objChatList.time ?? "") ?? objChatList.text ?? "")"
        
        cell?.masageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.starImageVIew.isHidden = true
    }
    
    private func setRightTextData(cell: RightTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        let messageString = "\(profileImage)"
        cell?.messaageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.starImageVIew.isHidden = true
    }
    
    private func setRightImageData(cell: RightImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        
        let Url = URL(string: objChatList.mediaURl ?? "")
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.starImageVIew.isHidden = true
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
    }
    
    //MARK: - LeftImageData Set
    private func setLeftImageData(cell: LeftImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        let Url = URL(string: profileImage)
        let url = URL(string: objChatList.mediaURl ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: Url, placeholder: UIImage(named: ""))
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.starImageVIew.isHidden = true
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
    }
    
    //MARK: - Right Document
    private func setRightDocumnetData(cell: RightDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.docNameLabel.text = objChatList.mediaURl
        let url = URL(string: objChatList.mediaURl ?? "")
        let extenion =  url?.pathExtension
        cell?.docTypeLabel.text = "  .\(extenion ?? "")"
        
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.starImageVIew.isHidden = true
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
    }
    
    //MARK: - Left Document
    private func setLeftDocumnetData(cell: LeftDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        
        let url = URL(string: profileImage)
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.docNameLabel.text = objChatList._media_file_name
        let urlDoc = URL(string: objChatList.mediaURl ?? "")
        let extenion =  urlDoc?.pathExtension
        cell?.docTypeLabel.text = "  .\(extenion ?? "")"
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.starImageVIew.isHidden = true
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
    }
    
    //MARK: - LeftVidoe
    private func setLeftVidoeData(cell: LeftVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        
        let url = URL(string: profileImage)
        cell?.ProfileImageVIew.kf.indicatorType = .activity
        cell?.ProfileImageVIew.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        let videoURL = URL(string: objChatList.mediaURl ?? "")
        cell?.starImageVIew.isHidden = ((objChatList.isfavourite) == nil)
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
    }
    
    //MARK: - Right Vidoes
    private func setRightVidoeData(cell: RightVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        let videoURL = URL(string: objChatList.mediaURl ?? "")
        cell?.starImageVIew.isHidden = ((objChatList.isfavourite) == nil)
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
    }
    
    //MARK: - Right Gift
    private func setRightGiftData(cell: RightGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
    }
    //MARK: - Left Gift
    private func setLeftGiftData(cell: LeftGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = FavoriteMessageListArray[indexPathForCell.row]
        let Url = URL(string: profileImage)
        cell?.profileImge.kf.indicatorType = .activity
        cell?.profileImge.kf.setImage(with: Url, placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = "\(objChatList.time ?? "")"
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
        cell?.starImageVIew.isHidden = ((objChatList.isfavourite) == nil)
    }
    
    //MARK: - Left Contact
    private func setLeftContactCell(cell: LeftContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.FavoriteMessageListArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.text?.htmlAttributedString!)!)
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key == "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        
        cell?.starImageVIew.isHidden = true
    }
    
    //MARK: - Right Contact
    private func setRightContactCell(cell: RightContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.FavoriteMessageListArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.text?.htmlAttributedString!)!)
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key == "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        cell?.starImageVIew.isHidden = true
    }
    
    //MARK: - clickVidowButton
    @objc func clickVidowButton(_ sender: UIControl) {
        let object = self.FavoriteMessageListArray[sender.tag]
        let player = AVPlayer(url: URL(string: object.mediaURl ?? "")!)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK: - clickImageClick
    @objc func clickImageClick(_ sender: UIControl) {
        let object = self.FavoriteMessageListArray[sender.tag]
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
        vc.imageURL = object.mediaURl ?? ""
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - clickFile
    @objc func clickFile(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        var documentInteractionController: UIDocumentInteractionController?
        self.DocUrl = object.media ?? ""
        documentInteractionController = UIDocumentInteractionController()
        let fileURL = URL(string: object.media ?? "")
        documentInteractionController?.url = fileURL
        documentInteractionController?.delegate = self
        documentInteractionController?.presentPreview(animated: true)
    }
}

extension FavoriteVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}
