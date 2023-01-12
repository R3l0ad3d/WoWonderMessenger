

import UIKit
import Async
import WowonderMessengerSDK
import AVFoundation
import AVKit
import Kingfisher

class MessageInfoViewController: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    var index:Int? = 0
    var recipientID: String? = ""
    var object: Messages!
    private var player = AVPlayer()
    private var playerItem:AVPlayerItem!
    private var playerController = AVPlayerViewController()
    var chatColor:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.tableView.separatorStyle = .none
        tableView.register( ChatSender_TableCell.nib, forCellReuseIdentifier: ChatSender_TableCell.identifier)
        tableView.register( ChatReceiver_TableCell.nib, forCellReuseIdentifier: ChatReceiver_TableCell.identifier)
        tableView.register(ChatSenderImage_TableCell.nib, forCellReuseIdentifier: ChatSenderImage_TableCell.identifier)
        tableView.register( ChatReceiverImage_TableCell.nib, forCellReuseIdentifier: ChatReceiverImage_TableCell.identifier)
        tableView.register( ChatSenderContact_TableCell.nib, forCellReuseIdentifier: ChatSenderContact_TableCell.identifier)
        tableView.register( ChatReceiverContact_TableCell.nib, forCellReuseIdentifier: ChatReceiverContact_TableCell.identifier)
        tableView.register( ChatSenderSticker_TableCell.nib, forCellReuseIdentifier: ChatSenderSticker_TableCell.identifier)
        tableView.register( ChatReceiverStricker_TableCell.nib, forCellReuseIdentifier: ChatReceiverStricker_TableCell.identifier)
        
        tableView.register( ChatSenderAudio_TableCell.nib, forCellReuseIdentifier: ChatSenderAudio_TableCell.identifier)
        
        tableView.register( ChatReceiverAudio_TableCell.nib, forCellReuseIdentifier: ChatReceiverAudio_TableCell.identifier)
        
        tableView.register( ChatSenderDocument_TableCell.nib, forCellReuseIdentifier: ChatSenderDocument_TableCell.identifier)
        tableView.register( ChatReceiverDocument_TableCell.nib, forCellReuseIdentifier: ChatReceiverDocument_TableCell.identifier)
        tableView.register( ChatInfoTableItem.nib, forCellReuseIdentifier: ChatInfoTableItem.identifier)
        
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
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MessageInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            if object.media == "" {
                if object.type == "right_text" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier) as? ChatSender_TableCell
                    cell?.selectionStyle = .none
                    cell?.messageTxtView.text = "\(self.decryptionAESModeECB(messageData: object.text?.htmlAttributedString ?? "", key: object.time ?? "") ?? object.text ?? "")"
                    cell?.dateLabel.text = object.time_text?.htmlAttributedString ?? ""
                    //                    cell?.messageTxtView.isEditable = false
                    cell?.messageTxtView.backgroundColor = UIColor.hexStringToUIColor(hex:  self.chatColor ?? "")
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status: Bool = false
                    
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    
                    if status {
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    
                    cell?.dateLabel.isHidden = true
                    
                    return cell!
                    
                }else if object.type == "left_text" {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiver_TableCell.identifier) as? ChatReceiver_TableCell
                    
                    cell?.messageTxtView.text = "\(self.decryptionAESModeECB(messageData: object.text?.htmlAttributedString ?? "", key: object.time ?? "") ?? object.text ?? "")"
                    //                    cell?.messageTxtView.isEditable = false
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                } else if object.type == "right_contact" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderContact_TableCell.identifier) as? ChatSenderContact_TableCell
                    let data = object.text?.htmlAttributedString!.data(using: String.Encoding.utf8)
                    //                   -------- my Comted---- let result = try! JSONDecoder().decode(ContactModel.self, from: data!)
                    //                    log.verbose("Result Model = \(result)")
                    let dic = convertToDictionary(text: (object.text?.htmlAttributedString!)!)
                    //                    log.verbose("dictionary = \(dic)")
                    cell?.nameLabel.text = object.text?.htmlAttributedString
                    //                    cell?.contactLabel.text = "\(dic?["value"] ?? "")"
                    cell?.timeLabel.text = object.time_text
                    cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
                    cell?.backView.backgroundColor = UIColor.hexStringToUIColor(hex: "#a84849")
                    //                    log.verbose("object.text?.htmlAttributedString? = \(object.text?.htmlAttributedString)")
                    let newString = object.text?.htmlAttributedString!.replacingOccurrences(of: "\\\\", with: "")
                    //                    log.verbose("newString= \(newString)")
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverContact_TableCell.identifier) as? ChatReceiverContact_TableCell
                    let newString = object.text?.htmlAttributedString!.replacingOccurrences(of: "\\\\", with: "")
                    let data = object.text?.htmlAttributedString?.data(using: String.Encoding.utf8)
                    let result = try? JSONDecoder().decode(ContactModel.self, from: data ?? Data())
                    let dic = convertToDictionary(text: (object.text?.htmlAttributedString!)!)
                    
                    cell?.nameLabel.text = object.text?.htmlAttributedString
                    cell?.contactLabel.text = "\(dic?["value"] ?? "")"
                    cell?.timeLabel.text = object.time_text
                    cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
                    
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message {
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    
                    return cell!
                }
                
            }else{
                if object.type == "right_image" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
                    cell?.fileImage.isHidden = false
                    cell?.videoView.isHidden = true
                    cell?.playBtn.isHidden = true
                    let url = URL.init(string:object.media ?? "")
                    cell?.fileImage.kf.indicatorType = .activity
                    cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
                    
                    cell?.timeLabel.text = object.time_text ?? ""
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    
                    return cell!
                    
                    
                } else if object.type == "left_image" {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
                    cell?.fileImage.isHidden = false
                    cell?.videoView.isHidden = true
                    cell?.playBtn.isHidden = true
                    
                    let url = URL.init(string:object.media ?? "")
                    cell?.fileImage.kf.indicatorType = .activity
                    cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
                    
                    cell?.timeLabel.text = object.time_text ?? ""
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    
                    return cell!
                }else  if object.type == "right_video" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
                    cell?.fileImage.isHidden = true
                    cell?.videoView.isHidden = false
                    cell?.playBtn.isHidden = false
                    cell?.delegate = self
                    cell?.index  = indexPath.row
                    cell?.timeLabel.text = object.time_text ?? ""
                    
                    let videoURL = URL(string: object.media ?? "")
                    player = AVPlayer(url: videoURL! as URL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    self.addChild(playerController)
                    playerController.view.frame = self.view.frame
                    cell?.videoView.addSubview(playerController.view)
                    player.pause()
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                }else if object.type == "left_video" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
                    cell?.fileImage.isHidden = true
                    cell?.videoView.isHidden = false
                    cell?.playBtn.isHidden = false
                    cell?.delegate = self
                    cell?.index  = indexPath.row
                    let videoURL = URL(string: object.media ?? "")
                    player = AVPlayer(url: videoURL! as URL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    self.addChild(playerController)
                    playerController.view.frame = self.view.frame
                    cell?.videoView.addSubview(playerController.view)
                    player.pause()
                    cell?.timeLabel.text = object.time_text ?? ""
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                }else if object.type == "right_sticker" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderSticker_TableCel.identifier) as? ChatSenderSticker_TableCell
                    let url = URL.init(string:object.media ?? "")
                    cell?.stickerImage.kf.indicatorType = .activity
                    cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
                    
                    cell?.timeLabel.text = object.time_text ?? ""
                    
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                    
                } else if object.type == "left_sticker" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverStricker_TableCell.identifier) as? ChatReceiverStricker_TableCell
                    
                    let url = URL.init(string:object.media ?? "")
                    cell?.stickerImage.kf.indicatorType = .activity
                    cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
                    
                    cell?.timeLabel.text = object.time_text ?? ""
                    
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                }else if  object.type == "right_audio" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderAudio_TableCell.identifier) as? ChatSenderAudio_TableCell
                    cell?.delegate = self
                    cell?.index = indexPath.row
                    cell?.url = object.media ?? ""
                    //                    cell?.backView.backgroundColor = UIColor.hexStringToUIColor(hex: "#a84849")
                    cell?.timeLabel.text = object.time_text ?? ""
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    }else{
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                }else if object.type == "left_audio" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverAudio_TableCell.identifier) as? ChatReceiverAudio_TableCell
                    cell?.delegate = self
                    cell?.index = indexPath.row
                    cell?.url = object.media ?? ""
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status:Bool? = false
                    for item in message{
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status ?? false{
                        cell?.starBtn.isHidden = false
                        
                    } else {
                        cell?.starBtn.isHidden = true
                    }
                    
                    return cell!
                    
                }else if object.type == "right_file" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier) as? ChatSenderDocument_TableCell
                    cell?.fileNameLabel.text = object._media_file_name
                    cell?.timeLabel.text = object.time_text ?? ""
                    cell?.backView.backgroundColor = UIColor.hexStringToUIColor(hex:  "#a84849")
                    let favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status: Bool = false
                    
                    for item in message {
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else{
                            status = false
                        }
                    }
                    if status {
                        cell?.starBtn.isHidden = false
                        
                    }else {
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                    
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverDocument_TableCell.identifier) as? ChatReceiverDocument_TableCell
                    cell?.nameLabel.text = object._media_file_name
                    cell?.timeLabel.text = object.time_text ?? ""
                    let favoriteAll = UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                    let message = favoriteAll[self.recipientID ?? ""] ?? []
                    var status: Bool = false
                    
                    for item in message {
                        let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self, from: item)
                        if object._message_id == favoriteMessage?.id ?? "" {
                            status = true
                            break
                        }else {
                            status = false
                        }
                    }
                    
                    if status {
                        cell?.starBtn.isHidden = false
                        
                    }else {
                        cell?.starBtn.isHidden = true
                    }
                    return cell!
                }
            }
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatInfoTableItem.identifier) as? ChatInfoTableItem
            
            if object.seen == "0" {
                cell!.readLabel.text = "---"
            }else{
                let value = Double(object.seen!)
                cell!.readLabel.text = convertDate(dateValue: value ?? 0.0)
            }
            if object.time == "0" {
                cell!.deliverLabel.text = "---"
            }else{
                let value = Double(object.time!)
                cell!.deliverLabel.text = convertDate(dateValue: value!)
            }
            return cell!
            
        default:
            return UITableViewCell()
        }
    }
    
    func convertDate(dateValue: Double) -> String {
        let date = Date(timeIntervalSince1970: dateValue)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 400.0
            
        default:
            return UITableView.automaticDimension
            
        }
        return UITableView.automaticDimension
    }
}

extension MessageInfoViewController:PlayVideoDelegate {
    
    func playVideo(index: Int, status: Bool) {
        if status {
            log.verbose(" self.player.play()")
        } else {
            log.verbose("self.player.pause()")
        }
    }
}

extension MessageInfoViewController:PlayAudioDelegate{
    
    func playAudio(index: Int, status: Bool, url: URL, button: UIButton) {
        if status{
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!//since it sys
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
            log.verbose("destinationUrl is = \(destinationUrl)")
            
            self.playerItem = AVPlayerItem(url: destinationUrl)
            self.player = AVPlayer(playerItem: self.playerItem)
            let playerLayer = AVPlayerLayer(player: self.player)
            
            self.player.play()
            button.setImage(R.image.ic_pauseBtn(), for: .normal)
        }else{
            self.player.pause()
            button.setImage(R.image.ic_playBtn(), for: .normal)
        }
    }
}
