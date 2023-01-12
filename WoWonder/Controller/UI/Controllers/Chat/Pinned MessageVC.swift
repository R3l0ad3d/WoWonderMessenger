//
//  Pinned MessageVC.swift
//  WoWonder
//
//  Created by Fs on 03/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Kingfisher
import Async

class PinnedMessageVC: BaseVC {
    
    @IBOutlet weak var pinTablevIew: UITableView!
    
    var chatModel: Chats?
    var DocUrl = ""
    var messagesArray = [MessageModel]()
    var messagesPinNewArray: [MessagePin] = []
    var isFistTry = true
    var issetledIndex = 0
    private var player = AVPlayer()
    var audioDuration = ""
    private var isColor = ""
    var profileImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpscreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        self.isColor = objColor as? String ?? ""
        
        self.navigationController?.navigationBar.isHidden = true
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
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpscreenUI() {
        
        let leftTextXIB = UINib(nibName: "LeftTextTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftTextXIB, forCellReuseIdentifier: "LeftTextTableViewCell")
        
        let rightTextXIB = UINib(nibName: "RightTextTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightTextXIB, forCellReuseIdentifier: "RightTextTableViewCell")
        
        let rightImageXIB = UINib(nibName: "RightImageTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightImageXIB, forCellReuseIdentifier: "RightImageTableViewCell")
        
        let leftImageXIB = UINib(nibName: "LeftImageTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftImageXIB, forCellReuseIdentifier: "LeftImageTableViewCell")
        
        let leftDocXIB = UINib(nibName: "LeftDocumentTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftDocXIB, forCellReuseIdentifier: "LeftDocumentTableViewCell")
        
        let rightDocXIB = UINib(nibName: "RightDocumentTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightDocXIB, forCellReuseIdentifier: "RightDocumentTableViewCell")
        
        let leftVidoeXIB = UINib(nibName: "LeftVidoeTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftVidoeXIB, forCellReuseIdentifier: "LeftVidoeTableViewCell")
        
        let rightVidoeXIB = UINib(nibName: "RightVidoeTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightVidoeXIB, forCellReuseIdentifier: "RightVidoeTableViewCell")
        
        let rightGiftXIB = UINib(nibName: "RightGiftTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightGiftXIB, forCellReuseIdentifier: "RightGiftTableViewCell")
        
        let leftGiftXIB = UINib(nibName: "LeftGiftTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftGiftXIB, forCellReuseIdentifier: "LeftGiftTableViewCell")
        
        let LeftLocationXIB = UINib(nibName: "LeftLocationTableViewCell", bundle: nil)
        self.pinTablevIew.register(LeftLocationXIB, forCellReuseIdentifier: "LeftLocationTableViewCell")
        
        let RightLocationXIB = UINib(nibName: "RightLocationTableViewCell", bundle: nil)
        self.pinTablevIew.register(RightLocationXIB, forCellReuseIdentifier: "RightLocationTableViewCell")
        
        let leftAudioXIB = UINib(nibName: "LeftAudioTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftAudioXIB, forCellReuseIdentifier: "LeftAudioTableViewCell")
        
        let rightAudioXIB = UINib(nibName: "RightAudioTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightAudioXIB, forCellReuseIdentifier: "RightAudioTableViewCell")
        
        let messageDateXIB = UINib(nibName: "MessageDateTableViewCell", bundle: nil)
        self.pinTablevIew.register(messageDateXIB, forCellReuseIdentifier: "MessageDateTableViewCell")
        
        let leftContact = UINib(nibName: "LeftContactTableViewCell", bundle: nil)
        self.pinTablevIew.register(leftContact, forCellReuseIdentifier: "LeftContactTableViewCell")
        
        let rightContact = UINib(nibName: "RightContactTableViewCell", bundle: nil)
        self.pinTablevIew.register(rightContact, forCellReuseIdentifier: "RightContactTableViewCell")
        
        self.getPinData()
    }
    
    func getPinData() {
        for index in 0..<messagesArray.count {
            let objPin = messagesArray[index]
            if objPin._pin == "no" {
                print("Type ==> \(objPin._pin)")

            } else {
                print("Type ==> \(objPin.text?.htmlAttributedString ?? "" )")
                self.messagesPinNewArray.append(MessagePin(pin: objPin.pin ?? "",
                                                           mediaURl: objPin.media ?? "",
                                                           type: objPin._type ,
                                                           time: objPin.time,
                                                           isfavourite: objPin.fav,
                                                           _media_file_name: objPin.mediaFileName ?? "",
                                                           text: objPin._text,
                                                           stickers: objPin.stickers))
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

extension PinnedMessageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messagesPinNewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objChatList = messagesPinNewArray[indexPath.row]
        
        guard let type = objChatList.type else { return UITableViewCell() }
        
        switch type {
        case "left_text":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftTextTableViewCell", for: indexPath) as? LeftTextTableViewCell
            self.setLeftTextData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_text":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as? RightTextTableViewCell
            self.setRightTextData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_image":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightImageTableViewCell", for: indexPath) as? RightImageTableViewCell
            self.setRightImageData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_image":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftImageTableViewCell", for: indexPath) as? LeftImageTableViewCell
            self.setLeftImageData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_video":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftVidoeTableViewCell", for: indexPath) as? LeftVidoeTableViewCell
            self.setLeftVidoeData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_video":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightVidoeTableViewCell", for: indexPath) as? RightVidoeTableViewCell
            self.setRightVidoeData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_gif":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightGiftTableViewCell", for: indexPath) as? RightGiftTableViewCell
            self.setRightGiftData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_gif":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftGiftTableViewCell", for: indexPath) as? LeftGiftTableViewCell
            self.setLeftGiftData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_contact":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftContactTableViewCell", for: indexPath) as? LeftContactTableViewCell
            self.setLeftContactCell(cell: cell, indexpathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_contact":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightContactTableViewCell", for: indexPath) as? RightContactTableViewCell
            self.setRightContactCell(cell: cell, indexpathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "right_file":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightDocumentTableViewCell", for: indexPath) as? RightDocumentTableViewCell
            self.setRightDocumnetData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_file":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftDocumentTableViewCell", for: indexPath) as? LeftDocumentTableViewCell
            self.setLeftDocumnetData(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case "left_audio":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "LeftAudioTableViewCell", for: indexPath) as? LeftAudioTableViewCell
            return cell ?? UITableViewCell()
            
        case "right_audio":
            let cell = pinTablevIew.dequeueReusableCell(withIdentifier: "RightAudioTableViewCell", for: indexPath) as? RightAudioTableViewCell
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
        let objChatList = messagesArray[indexPathForCell.row]
        let url = URL(string: objChatList.messageUser?.avatar ?? "")
        cell?.userProfileImageView.kf.indicatorType = .activity
        cell?.userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList._text, key: objChatList._time) ?? objChatList._text)"
        cell?.masageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList._time))
    }
    
    private func setRightTextData(cell: RightTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList._text, key: objChatList._time) ?? objChatList._text)"
        cell?.messaageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList._time))
        
        if isColor != "" {
            cell?.messgaeView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messgaeView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        }
    }
    
    private func setRightImageData(cell: RightImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let Url = URL(string: objChatList.media ?? "")
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList._time))
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
        
        if isColor != "" {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    
    //MARK: - LeftImageData Set
    private func setLeftImageData(cell: LeftImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        let Url = URL(string: profileImage)
        let url = URL(string: objChatList.mediaURl ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: Url, placeholder: UIImage(named: ""))
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
    }
    
    //MARK: - Right Document
    private func setRightDocumnetData(cell: RightDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        cell?.docNameLabel.text = objChatList.mediaURl
        let url = URL(string: objChatList.mediaURl ?? "")
        let extenion =  url?.pathExtension
        cell?.docTypeLabel.text = "  .\(extenion ?? "")"
        
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
        
        if isColor != "" {
            cell?.messageMainView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageMainView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    
    //MARK: - Left Document
    private func setLeftDocumnetData(cell: LeftDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        
        let url = URL(string: profileImage)
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        cell?.docNameLabel.text = objChatList._media_file_name
        let urlDoc = URL(string: objChatList.mediaURl ?? "")
        let extenion =  urlDoc?.pathExtension
        cell?.docTypeLabel.text = "  .\(extenion ?? "")"
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
    }
    
    //MARK: - LeftVidoe
    private func setLeftVidoeData(cell: LeftVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        
        let url = URL(string: profileImage)
        cell?.ProfileImageVIew.kf.indicatorType = .activity
        cell?.ProfileImageVIew.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        let videoURL = URL(string: objChatList.mediaURl ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
    }
    
    //MARK: - Right Vidoes
    private func setRightVidoeData(cell: RightVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        let videoURL = URL(string: objChatList.mediaURl ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
        
        if isColor != "" {
            cell?.mesaageView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.mesaageView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    
    //MARK: - Right Gift
    private func setRightGiftData(cell: RightGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
        
        if isColor != "" {
            cell?.messageView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    //MARK: - Left Gift
    private func setLeftGiftData(cell: LeftGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesPinNewArray[indexPathForCell.row]
        let Url = URL(string: profileImage)
        cell?.profileImge.kf.indicatorType = .activity
        cell?.profileImge.kf.setImage(with: Url, placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
    }
    
    //MARK: - Left Contact
    private func setLeftContactCell(cell: LeftContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.messagesPinNewArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.text?.htmlAttributedString!)!)
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key != nil {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
    }
    
    //MARK: - Right Contact
    private func setRightContactCell(cell: RightContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.messagesPinNewArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.text?.htmlAttributedString!)!)
        cell?.userNameLabel.text = "\(dic?["key"] ?? "")"
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key != "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        
        if isColor != "" {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    
    //MARK: - clickVidowButton
    @objc func clickVidowButton(_ sender: UIControl) {
        let object = self.messagesPinNewArray[sender.tag]
        let player = AVPlayer(url: URL(string: object.mediaURl ?? "")!)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK: - clickImageClick
    @objc func clickImageClick(_ sender: UIControl) {
        let object = self.messagesPinNewArray[sender.tag]
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

extension PinnedMessageVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
}
