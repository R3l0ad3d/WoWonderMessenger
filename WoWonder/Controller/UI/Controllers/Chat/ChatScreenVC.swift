//
//import UIKit
//import Async
//import SwiftEventBus
//import DropDown
//import AVFoundation
//import AVKit
//import GoogleMaps
//import ActionSheetPicker_3_0
//import WowonderMessengerSDK
//import ISEmojiView
//import MobileCoreServices
//
class ChatScreenVC: BaseVC {
}
//
//    @IBOutlet weak var emojiButton: UIButton!
//    @IBOutlet weak var cancelPressed: UIButton!
//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var replyUsernameLabel: UILabel!
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var sideView: UIView!
//    @IBOutlet weak var replyInView: UIView!
//    @IBOutlet weak var replyView: UIView!
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var topView: UIView!
//    @IBOutlet weak var statusBarView: UIView!
//    @IBOutlet weak var showAudioCancelBtn: UIButton!
//    @IBOutlet weak var showAudioPlayBtn: UIButton!
//    @IBOutlet weak var showAudioView: UIView!
//    @IBOutlet weak var microBtn: UIButton!
//    @IBOutlet weak var lastSeenLabel: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var sendBtn: UIButton!
//    @IBOutlet weak var messageTxtView: UITextView!
//    @IBOutlet weak var textViewHeightContraint: NSLayoutConstraint!
//    @IBOutlet weak var pinViewHightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var userPinMassageLabel: UILabel!
//    @IBOutlet weak var pinmassageLebal: UILabel!
//    @IBOutlet weak var pinSubRightView: UIView!
//    @IBOutlet weak var pinVIew: UIControl!
//    @IBOutlet weak var moreBtn: UIButton!
//    @IBOutlet weak var bottomView: UIView!
//    @IBOutlet weak var replyTextLabel: UILabel!
//
//    //MARK: For audio messages
//    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
//    var myaudioPlayer: AVAudioPlayer!
//    var numberOfRecorde = 0
//
//    var count = 0
//    var isFistTry = true
//    var audioDuration = ""
//    var DocUrl = ""
//    var objUrlProfile = ""
//    var issetledIndex = 0
//    var indexpathName = ""
//    var nameOfCell = ""
//    var isBack = IndexPath()
//    var ispin = ""
//    var isimageName = URL(string: "")
//    var isPintext = ""
//    var isfavorites = false
//    var textType = ""
//    var ispintime = ""
//    var toUserID = ""
//
//    //For template msg
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(TempMsgCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        return collectionView
//    }()
//
//    var chatModel: Chats?
//    private var firstMessage: Messages?
//
//    private lazy var coreDataFetcher: CoreDataFetcher<Messages> = {
//        return CoreDataFetcher<Messages>()
//    }()
//
//    var index: Int = 0
//    //    var userObject: GetUserListModel.Datum?
//    var searchUserObject: SearchModel.User?
//    var followingUserObject: FollowingModel.Following?
//    var recipientID: String = ""
//    var audioPlayer = AVAudioPlayer()
//    //    var chatColorHex = "#a84849"
//    var object_LatSeen = ""
//
//    private var messagesArray = [Messages]() {
//        didSet {
//            self.chatModel?.addToMessages(NSSet(array: self.messagesArray))
//            self.chatModel?.save()
//
//            guard let lastMsg = self.messagesArray.last,
//                  let user = self.chatModel?.getFirstChatUser()?.user else {
//                return
//            }
//            user.last_message = lastMsg
//            user.save()
//        }
//    }
//
//    private var updateTimer: Timer?
//    private var isFirstTime: Bool = true
//    private var isPagination: Bool = false
//    private var offset: Int = 50
//    private var limit: Int = 50
//
//    private var stopArray = [MessageModel]()
//    private var userChatCount: Int = 0
//    private var player = AVPlayer()
//    private var playerItem: AVPlayerItem!
//    private var playerController = AVPlayerViewController()
//    private let moreDropdown = DropDown()
//    private let imagePickerController = UIImagePickerController()
//    private let MKColorPicker = ColorPickerViewController()
//    private var sendMessageAudioPlayer: AVAudioPlayer?
//    private var receiveMessageAudioPlayer: AVAudioPlayer?
//    private var toneStatus: Bool = false
//    private var scrollStatus: Bool = true
//    private var isReplyStatus: Bool = false
//    private var messageCount: Int = 0
//    private var admin: String = ""
//    private var replyMessageID: String = ""
//    private var isColor = ""
//    private var typing = ""
//
//    private var isShowEmoji: Bool = false {
//        willSet {
//            let emojiImage = UIImage(systemName: "smiley")
//            let keyboardImage = UIImage(systemName: "keyboard")
//            self.emojiButton.setImage(newValue ? keyboardImage : emojiImage, for: .normal)
//
//            if newValue {
//                let keyboardSettings = KeyboardSettings(bottomType: .categories)
//                let emojiView = EmojiView(keyboardSettings: keyboardSettings)
//                emojiView.translatesAutoresizingMaskIntoConstraints = false
//                emojiView.delegate = self
//                self.messageTxtView.inputView = emojiView
//                self.messageTxtView.reloadInputViews()
//
//            } else {
//                self.resetKeyboardView()
//            }
//        }
//    }
//
//    private let chatColors = [
//        UIColor.hexStringToUIColor(hex: "#a84849"),
//        UIColor.hexStringToUIColor(hex: "#a84849"),
//        UIColor.hexStringToUIColor(hex: "#0ba05d"),
//        UIColor.hexStringToUIColor(hex: "#609b41"),
//        UIColor.hexStringToUIColor(hex: "#8ec96c"),
//        UIColor.hexStringToUIColor(hex: "#51bcbc"),
//        UIColor.hexStringToUIColor(hex: "#b582af"),
//        UIColor.hexStringToUIColor(hex: "#01a5a5"),
//        UIColor.hexStringToUIColor(hex: "#ed9e6a"),
//        UIColor.hexStringToUIColor(hex: "#aa2294"),
//        UIColor.hexStringToUIColor(hex: "#f33d4c"),
//        UIColor.hexStringToUIColor(hex: "#a085e2"),
//        UIColor.hexStringToUIColor(hex: "#ff72d2"),
//        UIColor.hexStringToUIColor(hex: "#056bba"),
//        UIColor.hexStringToUIColor(hex: "#f9c270"),
//        UIColor.hexStringToUIColor(hex: "#fc9cde"),
//        UIColor.hexStringToUIColor(hex: "#0e71ea"),
//        UIColor.hexStringToUIColor(hex: "#008484"),
//        UIColor.hexStringToUIColor(hex: "#c9605e"),
//        UIColor.hexStringToUIColor(hex: "#5462a5"),
//        UIColor.hexStringToUIColor(hex: "#2b87ce"),
//        UIColor.hexStringToUIColor(hex: "#f2812b"),
//        UIColor.hexStringToUIColor(hex: "#f9a722"),
//        UIColor.hexStringToUIColor(hex: "#56c4c5"),
//        UIColor.hexStringToUIColor(hex: "#70a0e0"),
//        UIColor.hexStringToUIColor(hex: "#a1ce79")
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.pinViewHightConstraint.constant = 0
//        self.topView.clipsToBounds = true
//        self.topView.layer.cornerRadius = 20
//        self.topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//
//        //Shadow in Top View
//        self.topView.layer.shadowColor = UIColor.darkGray.cgColor
//        self.topView.layer.masksToBounds = false
//        self.topView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.topView.layer.shadowRadius = 2
//        self.topView.layer.shadowOpacity = 0.5
//
//        self.setupUI()
//        self.textViewPlaceHolder()
//        self.customizeDropdown()
//        self.fetchData()
//        self.fetchUserProfile()
//
//        self.tableView.register(UINib(nibName: "ProductTableCell", bundle: nil),
//                                forCellReuseIdentifier: "ProductCell")
//        MKColorPicker.allColors = chatColors
//        MKColorPicker.selectedColor = { [weak self] color in
//            guard let self = self else { return }
//
//            log.verbose("selected Color = \(color.toHexString())")
//            UserDefaults.standard.setChatColorHex(value: color.toHexString(), ForKey: "ColorTheme")
//            let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
//            self.isColor = objColor as? String ?? ""
//            if self.isColor != "" {
//                self.setColorTheme()
//            }
//            self.tableView.reloadData()
//        }
//
//        let messageTextFrame = self.messageTxtView.frame.height / 3
//        self.messageTxtView.textContainerInset = UIEdgeInsets(top: messageTextFrame, left: 13, bottom: messageTextFrame, right: 13)
//        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
//            if hasPermission {
//                print("Accepted ")
//            }
//        }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
//        self.isColor = objColor as? String ?? ""
//        if isColor != "" {
//            self.setColorTheme()
//        }
//        // NEW CODE On color
//        self.navigationController?.isNavigationBarHidden = true
//        self.heightConstraint.constant = 0
//        self.cancelPressed.isHidden = true
//        self.replyUsernameLabel.text = self.usernameLabel.text
//        self.replyUsernameLabel.isHidden = true
//        self.replyTextLabel.isHidden = true
//        self.replyInView.isHidden = true
//        self.sideView.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.updateTimer?.invalidate()
//        SwiftEventBus.unregister(self)
//        self.navigationController?.isNavigationBarHidden = false
//    }
//
//    func setColorTheme() {
//        if self.isColor == "#aa2294" {
//            self.topView.backgroundColor = UIColor(hex: "aa2294")
//            self.statusBarView.backgroundColor = UIColor(hex: "aa2294")
//            self.sendBtn.backgroundColor = UIColor(hex: "aa2294")
//            self.microBtn.backgroundColor = UIColor(hex: "aa2294")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "aa2294")
//            self.pinmassageLebal.textColor = UIColor(hex: "aa2294")
//
//        } else if self.isColor == "#8ec96c" {
//            self.topView.backgroundColor = UIColor(hex: "8ec96c")
//            self.statusBarView.backgroundColor = UIColor(hex: "8ec96c")
//            self.sendBtn.backgroundColor = UIColor(hex: "8ec96c")
//            self.microBtn.backgroundColor = UIColor(hex: "8ec96c")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "8ec96c")
//            self.pinmassageLebal.textColor = UIColor(hex: "8ec96c")
//
//        } else if self.isColor == "#ed9e6a" {
//            self.topView.backgroundColor = UIColor(hex: "ed9e6a")
//            self.statusBarView.backgroundColor = UIColor(hex: "ed9e6a")
//            self.sendBtn.backgroundColor = UIColor(hex: "ed9e6a")
//            self.microBtn.backgroundColor = UIColor(hex: "ed9e6a")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "ed9e6a")
//            self.pinmassageLebal.textColor = UIColor(hex: "ed9e6a")
//
//        } else if self.isColor == "#ff72d2" {
//            self.topView.backgroundColor = UIColor(hex: "ff72d2")
//            self.statusBarView.backgroundColor = UIColor(hex: "ff72d2")
//            self.sendBtn.backgroundColor = UIColor(hex: "ff72d2")
//            self.microBtn.backgroundColor = UIColor(hex: "ff72d2")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "ff72d2")
//            self.pinmassageLebal.textColor = UIColor(hex: "ff72d2")
//
//        } else if self.isColor == "#a84849" {
//            self.topView.backgroundColor = UIColor(hex: "a84849")
//            self.statusBarView.backgroundColor = UIColor(hex: "a84849")
//            self.sendBtn.backgroundColor = UIColor(hex: "a84849")
//            self.microBtn.backgroundColor = UIColor(hex: "a84849")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "a84849")
//            self.pinmassageLebal.textColor = UIColor(hex: "a84849")
//
//        } else if self.isColor == "#aa2294" {
//            self.topView.backgroundColor = UIColor(hex: "aa2294")
//            self.statusBarView.backgroundColor = UIColor(hex: "aa2294")
//            self.sendBtn.backgroundColor = UIColor(hex: "aa2294")
//            self.microBtn.backgroundColor = UIColor(hex: "aa2294")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "aa2294")
//            self.pinmassageLebal.textColor = UIColor(hex: "aa2294")
//
//        } else if self.isColor == "#056bba" {
//            self.topView.backgroundColor = UIColor(hex: "056bba")
//            self.statusBarView.backgroundColor = UIColor(hex: "056bba")
//            self.sendBtn.backgroundColor = UIColor(hex: "056bba")
//            self.microBtn.backgroundColor = UIColor(hex: "056bba")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "056bba")
//            self.pinmassageLebal.textColor = UIColor(hex: "056bba")
//
//        } else if self.isColor == "#0ba05d" {
//            self.topView.backgroundColor = UIColor(hex: "0ba05d")
//            self.statusBarView.backgroundColor = UIColor(hex: "0ba05d")
//            self.sendBtn.backgroundColor = UIColor(hex: "0ba05d")
//            self.microBtn.backgroundColor = UIColor(hex: "0ba05d")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "0ba05d")
//            self.pinmassageLebal.textColor = UIColor(hex: "0ba05d")
//
//        } else if self.isColor == "#b582af" {
//            self.topView.backgroundColor = UIColor(hex: "b582af")
//            self.statusBarView.backgroundColor = UIColor(hex: "b582af")
//            self.sendBtn.backgroundColor = UIColor(hex: "b582af")
//            self.microBtn.backgroundColor = UIColor(hex: "b582af")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "b582af")
//            self.pinmassageLebal.textColor = UIColor(hex: "b582af")
//
//        } else if self.isColor == "#f33d4c" {
//            self.topView.backgroundColor = UIColor(hex: "f33d4c")
//            self.statusBarView.backgroundColor = UIColor(hex: "f33d4c")
//            self.sendBtn.backgroundColor = UIColor(hex: "f33d4c")
//            self.microBtn.backgroundColor = UIColor(hex: "f33d4c")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "f33d4c")
//            self.pinmassageLebal.textColor = UIColor(hex: "f33d4c")
//
//        } else if self.isColor == "#f9c270" {
//            self.topView.backgroundColor = UIColor(hex: "f9c270")
//            self.statusBarView.backgroundColor = UIColor(hex: "f9c270")
//            self.sendBtn.backgroundColor = UIColor(hex: "f9c270")
//            self.microBtn.backgroundColor = UIColor(hex: "f9c270")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "f9c270")
//            self.pinmassageLebal.textColor = UIColor(hex: "f9c270")
//
//        } else if self.isColor == "#609b41" {
//            self.topView.backgroundColor = UIColor(hex: "609b41")
//            self.statusBarView.backgroundColor = UIColor(hex: "609b41")
//            self.sendBtn.backgroundColor = UIColor(hex: "609b41")
//            self.microBtn.backgroundColor = UIColor(hex: "609b41")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "609b41")
//            self.pinmassageLebal.textColor = UIColor(hex: "609b41")
//
//        } else if self.isColor == "#01a5a5" {
//            self.topView.backgroundColor = UIColor(hex: "01a5a5")
//            self.statusBarView.backgroundColor = UIColor(hex: "01a5a5")
//            self.sendBtn.backgroundColor = UIColor(hex: "01a5a5")
//            self.microBtn.backgroundColor = UIColor(hex: "01a5a5")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "01a5a5")
//            self.pinmassageLebal.textColor = UIColor(hex: "01a5a5")
//
//        } else if self.isColor == "#a085e2" {
//            self.topView.backgroundColor = UIColor(hex: "a085e2")
//            self.statusBarView.backgroundColor = UIColor(hex: "a085e2")
//            self.sendBtn.backgroundColor = UIColor(hex: "a085e2")
//            self.microBtn.backgroundColor = UIColor(hex: "a085e2")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "a085e2")
//            self.pinmassageLebal.textColor = UIColor(hex: "a085e2")
//
//        } else if self.isColor == "#fc9cde" {
//            self.topView.backgroundColor = UIColor(hex: "fc9cde")
//            self.statusBarView.backgroundColor = UIColor(hex: "fc9cde")
//            self.sendBtn.backgroundColor = UIColor(hex: "fc9cde")
//            self.microBtn.backgroundColor = UIColor(hex: "fc9cde")
//            self.pinSubRightView.backgroundColor = UIColor(hex: "fc9cde")
//            self.pinmassageLebal.textColor = UIColor(hex: "fc9cde")
//        }
//    }
//
//    @objc override func keyboardWillShow(_ notification: Notification) {
//        let userInfo = (notification as NSNotification).userInfo!
//        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//        //Check the device height
//        self.bottomConstraint?.constant = (keyboardFrame!.height + (UIScreen.main.nativeBounds.height >= 2436 ? 80 : 100))
//        self.animatedKeyBoard(scrollToBottom: true)
//    }
//
//    @objc override func keyboardWillHide(_ notification: Notification) {
//        self.bottomConstraint?.constant = 100
//        self.animatedKeyBoard(scrollToBottom: false)
//    }
//}
//
//// MARK: - ACTIONS
//extension ChatScreenVC {
//
//    @IBAction func emojiAction(sender: UIButton) {
//        self.isShowEmoji = !self.isShowEmoji
//    }
//
//    @IBAction func showProfile(sender: UITapGestureRecognizer) {
//        self.navigateToUserProfile()
//    }
//
//    @IBAction func pinViewClick(_ sender: Any) {
//        self.view.endEditing(true)
//        let pinVC = PinnedMessageVC.initialize(from: .chat)
////        pinVC.messagesArray = self.messagesArray
//        //        pinVC.isfavorites = isfavorites
//        //        pinVC.textName = isPintext
//        //        pinVC.imageName = isimageName
//        //
//        //        pinVC.textType = textType
//        //        pinVC.ispintime = ispintime
//        self.navigationController?.pushViewController(pinVC, animated: true)
//    }
//
//    @IBAction func callPressed(_ sender: Any) {
//        let vc = R.storyboard.call.agoraCallVC()
//        vc?.callType = .audio
//        vc?.callDirection = .outgoing
//
//        if let chat = self.chatModel {
//            vc?.user = chat.getFirstChatUser()?.getUser()
//
//        }else if searchUserObject != nil {
//            vc?.searchUserObject = searchUserObject
//
//        }else {
//            vc?.followingUserObject = followingUserObject
//        }
//
//        vc?.delegate = self
//        self.present(vc!, animated: true, completion: nil)
//    }
//
//    @IBAction func videoCallPressed(_ sender: Any) {
//        //        let vc = R.storyboard.call.agoraCallNotificationPopupVC()
//        ////        vc?.callingType = "calling Video..."
//        ////        vc?.callingStatus = "video"
//        //        vc?.callType = .video
//        //        vc?.delegate = self
//        //
//        //        if let chat = self.chatModel {
//        //            vc?.chatModel = chat.getChatUser()?.getUser()
//        //
//        //        }else if searchUserObject != nil {
//        //            vc?.searchUserObject =  searchUserObject
//        //
//        //        }else {
//        //            vc?.followingUserObject =  followingUserObject
//        //        }
//        //        self.present(vc!, animated: true, completion: nil)
//    }
//
//    @IBAction func pickColorPressed(_ sender: UIButton) {
//
//        if let popoverController = MKColorPicker.popoverPresentationController {
//            popoverController.delegate = MKColorPicker
//            popoverController.permittedArrowDirections = .any
//            popoverController.sourceView = sender
//            popoverController.sourceRect = sender.bounds
//        }
//
//        self.present(MKColorPicker, animated: true, completion: nil)
//    }
//
//    @IBAction func selectVideoPressed(_ sender: Any) {
//        openVideoGallery()
//    }
//
//    @IBAction func contactPressed(_ sender: Any) {
//        let vc = R.storyboard.dashboard.inviteFriendsVC()
//        vc?.status = true
//        vc?.delegate = self
//        self.present(vc!, animated: true, completion: nil)
//    }
//
//    @IBAction func selectPhotoPressed(_ sender: Any) {
//        ActionSheetStringPicker.show(withTitle: "Upload", rows: ["camera", "gallery"], initialSelection: 0, doneBlock: { [weak self] (picker, index, values) in
//            guard let self = self else { return }
//
//            if index == 0 {
//                self.imagePickerController.delegate = self
//                self.imagePickerController.allowsEditing = true
//                self.imagePickerController.sourceType = .camera
//                self.present(self.imagePickerController, animated: true, completion: nil)
//            }else {
//                self.imagePickerController.delegate = self
//                self.imagePickerController.allowsEditing = true
//                self.imagePickerController.sourceType = .photoLibrary
//                self.present(self.imagePickerController, animated: true, completion: nil)
//            }
//            return
//
//        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
//    }
//
//    @IBAction func microPressed(_ sender: Any) {
//    }
//
//
//    @IBAction func selectFilePressed(_ sender: Any) {
//        let alert = UIAlertController(title:NSLocalizedString("Select what you want", comment: "Select what you want"), message: "", preferredStyle: .actionSheet)
//
//        let gallery = UIAlertAction(title: NSLocalizedString("Image Gallery", comment: "Image Gallery"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("Image Gallery")
//            self.imagePickerController.delegate = self
//            self.imagePickerController.allowsEditing = true
//            self.imagePickerController.sourceType = .photoLibrary
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//
//        let camera = UIAlertAction(title: NSLocalizedString("Take a picture from the camera", comment: "Take a picture from the camera"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("Take a picture from the camera")
//            self.imagePickerController.delegate = self
//            self.imagePickerController.allowsEditing = true
//            self.imagePickerController.sourceType = .camera
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//
//        let video = UIAlertAction(title: NSLocalizedString("Video Gallery", comment: "Video Gallery"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("Video Gallery")
//            self.openVideoGallery()
//        }
//
//        let location = UIAlertAction(title: NSLocalizedString("Location", comment: "Location"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("Location")
//            let vc = R.storyboard.chat.locationVC()
//            vc?.delegate = self
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//
//        let contact = UIAlertAction(title: NSLocalizedString("Contact", comment: "Contact"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            let vc = R.storyboard.dashboard.inviteFriendsVC()
//            vc?.status = true
//            vc?.delegate = self
//            self.present(vc!, animated: true, completion: nil)
//        }
//
//        let file = UIAlertAction(title: NSLocalizedString("File", comment: "File"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("File")
//            let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
//            documentPicker.delegate = self
//            self.present(documentPicker, animated: true, completion: nil)
//        }
//
//        let gif = UIAlertAction(title: NSLocalizedString("Gif", comment: "Gif"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//
//            //            log.verbose("Gif")
//            let vc = R.storyboard.chat.gifVC()
//            vc?.delegate = self
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//
//        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
//        alert.addAction(gallery)
//        alert.addAction(camera)
//        alert.addAction(video)
//        alert.addAction(location)
//        alert.addAction(file)
//        alert.addAction(gif)
//        alert.addAction(contact)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    @IBAction func sendPressed(_ sender: UIButton) {
//
//        if self.messageTxtView.text == "" {
//            self.setSendBytton()
//        } else {
//            if !messageTxtView.text!.isEmpty {
//                //                SocketMangaer.sharedInstance.doneTypingstutesDelegate = self
//                self.messageTxtView.text.removeAll()
//            }
//        }
//    }
//
//    @IBAction func morePressed(_ sender: Any) {
//        self.moreDropdown.show()
//    }
//
//    @IBAction func backPressed(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func cancelReplyPressed(_ sender: Any) {
//        self.heightConstraint.constant = 0
//        self.cancelPressed.isHidden = true
//        self.replyUsernameLabel.isHidden = true
//        self.replyTextLabel.isHidden = true
//        self.replyInView.isHidden = true
//        self.sideView.isHidden = true
//        self.replyMessageID = ""
//        self.isReplyStatus = false
//        self.animateRepltyView()
//    }
//}
//
//// MARK: - EMOJI DELEGATE
//extension ChatScreenVC: EmojiViewDelegate {
//
//    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
//        self.messageTxtView.insertText(emoji)
//    }
//
//    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
//        self.resetKeyboardView()
//    }
//
//    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
//        self.messageTxtView.deleteBackward()
//    }
//
//    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
//        self.messageTxtView.resignFirstResponder()
//    }
//}
//
//// MARK: - IMAGE PICKER DELEGATE
//extension ChatScreenVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true)
//
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            let imageData = image.jpegData(compressionQuality: 0.1)
//            self.sendSelectedData(audioData: nil,
//                             imageData: imageData,
//                             videoData: nil,
//                             imageMimeType: imageData?.mimeType,
//                             VideoMimeType: nil,
//                             audioMimeType: nil,
//                             Type: "image",
//                             fileData: nil,
//                             fileExtension: nil,
//                             FileMimeType: nil)
//        }
//
//        if let fileURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
//            let videoData = try? Data(contentsOf: fileURL)
//            sendSelectedData(audioData: nil,
//                             imageData: nil,
//                             videoData: videoData,
//                             imageMimeType: nil,
//                             VideoMimeType: videoData?.mimeType,
//                             audioMimeType: nil,
//                             Type: "video",
//                             fileData: nil,
//                             fileExtension: nil,
//                             FileMimeType: nil)
//        }
//    }
//}
//
//// MARK: - SELECT CONTACT DEELGATE
//extension ChatScreenVC: SelectContactDetailDelegate {
//    func selectContact(caontectName:String, ContactNumber:String) {
//        var extendedParam = ["key":caontectName,"value": ContactNumber] as? [String:String]
//
//        if let theJSONData = try?  JSONSerialization.data(withJSONObject:extendedParam ?? [:], options: []) {
//            let theJSONText = String(data: theJSONData,encoding: String.Encoding.utf8)
//            log.verbose("JSON string = \(theJSONText ?? "")")
////            self.sendContact(jsonPayload: theJSONText)
//        }
//    }
//
//}
//
//// MARK: - DOCUMENT PICKER DELEGATE
//extension ChatScreenVC: UIDocumentPickerDelegate {
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        let fileData = try? Data(contentsOf: url)
//        let fileExtension = String(url.lastPathComponent.split(separator: ".").last!)
//        self.sendSelectedData(audioData: nil,
//                              imageData: nil,
//                              videoData: nil,
//                              imageMimeType: nil,
//                              VideoMimeType: nil,
//                              audioMimeType: nil,
//                              Type: "file",
//                              fileData: fileData,
//                              fileExtension: fileExtension,
//                              FileMimeType: fileData?.mimeType)
//        controller.dismiss(animated: true)
//    }
//}
//
//// MARK: - TEXT VIEW DELEGATE
//
//extension ChatScreenVC: UITextViewDelegate {
//
//    func textViewDidChange(_ textView: UITextView) {
//        self.setSendBytton()
//    }
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == .lightGray {
//            textView.text = nil
//            self.messageTxtView.text = ""
//            textView.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = NSLocalizedString("Your message here...", comment: "Your message here...")
//            textView.textColor = UIColor.lightGray
//        }
//    }
//}
//
//// MARK: - TABLE VIEW DELEGATE
//
//extension ChatScreenVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let reply = UIContextualAction(style: .normal, title: "") { [weak self] (action, sourceView, completionHandler) in
//            guard let _ = self else { return }
//            completionHandler(true)
//        }
//        reply.image = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20)).image { _ in
//            UIImage(named: "reply")?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
//        }
//        reply.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
//        let swipeActionConfig = UISwipeActionsConfiguration(actions: [reply])
//        swipeActionConfig.performsFirstActionWithFullSwipe = true
//
//        let cellClass = self.tableView.cellForRow(at: indexPath)
//        let message = self.messagesArray[indexPath.row]
//
//        if let chatCell = cellClass as? ChatSender_TableCell {
//            self.replyUsernameLabel.text = "You"
//            self.replyTextLabel.text = chatCell.messageTxtView.text
//
//            self.swipeToReply(index: indexPath)
//            self.isReplyStatus = true
//            self.replyMessageID = message._message_id
//            return swipeActionConfig
//
//        } else if let revchatCell = cellClass as? ChatReceiver_TableCell {
//            self.replyUsernameLabel.text = self.usernameLabel.text
//            self.replyTextLabel.text = revchatCell.messageTxtView.text
//            self.swipeToReply(index: indexPath)
//            self.isReplyStatus = true
//            self.replyMessageID = message._message_id
//            return swipeActionConfig
//
//        } else if let cell = cellClass as? ReplyChatSenderTableItem {
//            self.replyUsernameLabel.text = "You"
//            self.replyTextLabel.text = cell.messageTextLabel.text ?? ""
//            self.swipeToReply(index: indexPath)
//            self.isReplyStatus = true
//            self.replyMessageID = message._message_id
//            return swipeActionConfig
//
//        } else if let revchatCell = cellClass as? replyReceiverTableItem {
//            self.replyUsernameLabel.text = self.usernameLabel.text
//            self.replyTextLabel.text = revchatCell.messageTextLabel.text
//            self.swipeToReply(index: indexPath)
//            self.isReplyStatus = true
//            self.replyMessageID = message._message_id
//            return swipeActionConfig
//        }
//        return nil
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.messagesArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if self.messagesArray.count == 0 {
//            return UITableViewCell()
//        }
//
//        let object = self.messagesArray[indexPath.row]
//        print("object.user")
//        guard let type = object._typeObject else { return UITableViewCell() }
//
//        if !object._reply_id.isEmpty, let replyMessage = object.getMessageByReplyID() {
//
//            switch type {
//            case .leftText:
//
//                let lat = Double(object.lat ?? "0.0") ?? 0.0
//                let long = Double(object.lng ?? "0.0") ?? 0.0
//
//                if lat > 0.0 || long > 0.0 {
//                    //for maps for sender
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewReceiveCell") as? MapViewReceiveCell
//                    cell?.selectionStyle = .none
//                    cell?.mapMainVew.isMyLocationEnabled = true
//                    cell?.Timelabel.text = object._time_text
//                    cell?.starButton.isHidden = !object.is_favourite
//                    cell?.lat = lat
//                    cell?.long = long
//                    cell?.callDelegateMethod()
//                    return cell ?? UITableViewCell()
//
//                } else {
//                    //show text on right
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyReceiverTableItem.identifier) as? replyReceiverTableItem
//                    cell?.selectionStyle = .none
//                    let paragraph = NSMutableParagraphStyle()
//                    paragraph.tabStops = [
//                        NSTextTab(textAlignment: .right, location: 0, options: [:]),
//                    ]
//
//                    let str = "\(self.decryptionAESModeECB(messageData: object._text , key: object._time) ?? object._text)"
//
//                    if replyMessage.from_id == AppInstance.instance._userId {
//                        cell?.usernameLabel.text = "You"
//                    }else{
//                        cell?.usernameLabel.text = self.usernameLabel.text ?? ""
//                    }
//
//                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: replyMessage._text, key: replyMessage._time) ?? replyMessage._text)"
//                    let attributed = NSAttributedString(
//                        string: str,
//                        attributes: [NSAttributedString.Key.paragraphStyle: paragraph,
//                                     NSAttributedString.Key.foregroundColor: UIColor.black,
//                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
//                    )
//
//                    cell?.messageTextLabel.attributedText = attributed
//                    cell?.messageTextLabel.isEditable = false
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//                }
//
//            case .rightText:
//
//                let lat = Double(object.lat ?? "0.0") ?? 0.0
//                let long = Double(object.lng ?? "0.0") ?? 0.0
//
//                if lat > 0.0 || long > 0.0 {
//                    //for maps for sender
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as? MapViewCell
//                    cell?.mapMainVew.isMyLocationEnabled = true
//                    cell?.Timelabel.text = object._time_text
//                    cell?.starButton.isHidden = !object.is_favourite
//                    cell?.lat = lat
//                    cell?.long = long
//                    cell?.callDelegateMethod()
//
//
//                    if self.isColor == "#aa2294" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//
//                    return cell ?? UITableViewCell()
//                } else {
//                    //show text on right
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyChatSenderTableItem.identifier) as? ReplyChatSenderTableItem
//                    cell?.selectionStyle = .none
//                    let paragraph = NSMutableParagraphStyle()
//                    paragraph.tabStops = [
//                        NSTextTab(textAlignment: .right, location: 0, options: [:]),
//                    ]
//                    let str = "\(self.decryptionAESModeECB(messageData: object._text.htmlAttributedString ?? "", key: object._time) ?? object._text)"
//
//                    if object._seen != "0" {
//                        //                        str += "\n\(NSLocalizedString("seen", comment: "seen"))"
//                    }
//
//                    if replyMessage._from_id == AppInstance.instance._userId {
//                        cell?.usernameLabel.text = "You"
//                    }else {
//                        cell?.usernameLabel.text = self.usernameLabel.text ?? ""
//                    }
//
//                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: replyMessage._text.htmlAttributedString ?? "", key: replyMessage._time) ?? replyMessage._text)"
//
//                    let attributed = NSAttributedString(
//                        string: str,
//                        attributes: [
//                            NSAttributedString.Key.paragraphStyle: paragraph,
//                            NSAttributedString.Key.foregroundColor: UIColor.white,
//                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
//                        ]
//                    )
//
//                    cell?.messageTextLabel.attributedText = attributed
//                    cell?.messageTextLabel.isEditable = false
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "fc9cde")
//
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                        cell?.inSideView.backgroundColor = UIColor(hex: "aa2294")
//
//                    }
//                    cell?.starBtn.isHidden = !replyMessage.is_favourite
//                    return cell!
//                }
//
//            default:
//                break
//            }
//
//        } else {
//            if object._media.isEmpty {
//
//                switch type {
//                case .leftGif:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverStricker_TableCell.identifier) as? ChatReceiverStricker_TableCell
//                    cell?.selectionStyle = .none
//                    let url = URL(string:object.stickers ?? "")
//                    cell?.stickerImage.kf.indicatorType = .activity
//                    cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//                    let time = setLocalDate(timeStamp: object.time)
//                    cell?.timeLabel.text = time
//                    cell?.timeLabel.text = object.time
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    cell?.backVIewControl.tag = indexPath.row
//                    cell?.backVIewControl.addTarget(self, action: #selector(clickGiftView), for: .touchUpInside)
//                    return cell ?? UITableViewCell()
//
//                case .leftProduct:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableCell
//                    cell.selectionStyle = .none
//                    cell.productName.text = object.product?._name
//                    cell.price.text = "\("$ ")\(object.product?.price ?? "")"
//                    cell.dateLabel.text = object._time_text
//                    cell.productCategory.text = "Autos & Vechicles"
//                    let imageURL = object.product?.getImages()[0]._url ?? ""
//                    let url = URL(string: imageURL)
//                    cell.productImage.kf.indicatorType = .activity
//                    cell.productImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//                    cell.starBtn.isHidden = !object.is_favourite
//                    return cell
//
//                case .leftText:
//
//                    let lat = Double(object._lat) ?? 0.0
//                    let long = Double(object._lng) ?? 0.0
//
//                    if lat > 0.0 || long > 0.0 {
//                        //for map on left
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewReceiveCell") as? MapViewReceiveCell
//                        cell?.selectionStyle = .none
//                        cell?.lat = lat
//                        cell?.long = long
//                        cell?.mapMainVew.isMyLocationEnabled = true
//                        cell?.Timelabel.text = object._time_text
//                        cell?.starButton.isHidden = !object.is_favourite
//                        cell?.callDelegateMethod()
//                        return cell ?? UITableViewCell()
//
//                    } else {
//                        //show text on Left
//                        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiver_TableCell.identifier) as? ChatReceiver_TableCell
//                        cell?.selectionStyle = .none
//                        cell?.messageTxtView.text = (self.decryptionAESModeECB(messageData: "\(object._text.htmlAttributedString ?? "")", key: object._time)) ?? object._text + "\n\n\(setLocalDate(timeStamp: object._time))"
//                        //                        cell?.messageTxtView.isEditable = false
//                        if self.issetledIndex == indexPath.row {
//                            cell?.dateLabel.isHidden = false
//                            cell?.dateLabel.text = object._time_text
//                        } else {
//                            cell?.dateLabel.isHidden = true
//                        }
//
//                        cell?.starBtn.isHidden = !object.is_favourite
//                        return cell!
//                    }
//
//                case .rightText:
//
//                    let lat = Double(object.lat ?? "0.0") ?? 0.0
//                    let long = Double(object.lng ?? "0.0") ?? 0.0
//
//                    if lat > 0.0 || long > 0.0 {
//                        //for maps for sender
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as? MapViewCell
//                        cell?.selectionStyle = .none
//
//                        //                        let url = URL(string:"https://i.imgflip.com/40sgnq.png")
//                        //                        cell?.stickerImage.sd_setImage(with: url , placeholderImage:nil)
//                        //                        cell?.stickerImage.contentMode = .scaleAspectFill
//
//                        let time = setLocalDate(timeStamp: object.time)
//
//                        if object.seen != "0" {
//                        }
//                        cell?.mapMainVew.isMyLocationEnabled = true
//                        cell?.Timelabel.text = object._time_text
//                        cell?.starButton.isHidden = !object.is_favourite
//                        cell?.lat = lat
//                        cell?.long = long
//                        cell?.callDelegateMethod()
//
//                        if self.isColor == "#aa2294" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//
//                        } else if self.isColor == "#8ec96c" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "8ec96c")
//
//                        } else if self.isColor == "#ed9e6a" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                        } else if self.isColor == "#ff72d2" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "ff72d2")
//
//                        } else if self.isColor == "#a84849" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "a84849")
//
//                        } else if self.isColor == "#aa2294" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//
//                        } else if self.isColor == "#056bba" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "056bba")
//
//                        } else if self.isColor == "#0ba05d" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "0ba05d")
//
//                        } else if self.isColor == "#b582af" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "b582af")
//
//                        } else if self.isColor == "#f33d4c" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "f33d4c")
//
//                        } else if self.isColor == "#f9c270" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "f9c270")
//
//                        } else if self.isColor == "#609b41" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "609b41")
//
//                        } else if self.isColor == "#01a5a5" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "01a5a5")
//
//                        } else if self.isColor == "#a085e2" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "a085e2")
//
//                        } else if self.isColor == "#fc9cde" {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "fc9cde")
//                        } else {
//                            cell?.mapViewCellView.backgroundColor = UIColor(hex: "aa2294")
//                        }
//                        return cell ?? UITableViewCell()
//                    } else {
//                        //show text on right
//                        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier) as? ChatSender_TableCell
//                        cell?.selectionStyle = .none
//                        let paragraph = NSMutableParagraphStyle()
//                        paragraph.tabStops = [
//                            NSTextTab(textAlignment: .right, location: 0, options: [:]),
//                        ]
//                        var str = "\(self.decryptionAESModeECB(messageData: object._text.htmlAttributedString ?? "", key: object._time) ?? object._text)"
//                        if object.seen != "0" {
//                        }
//
//                        let attributed = NSAttributedString(
//                            string: str,
//                            attributes: [
//                                NSAttributedString.Key.paragraphStyle: paragraph,
//                                NSAttributedString.Key.foregroundColor: UIColor.white,
//                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
//                            ]
//                        )
//
//                        cell?.messageTxtView.attributedText = attributed
//                        cell?.dateLabel.text = object.time_text
//                        cell?.starBtn.isHidden = !object.is_favourite
//
//                        if self.issetledIndex == indexPath.row {
//                            cell?.dateLabel.isHidden = false
//                        } else {
//                            cell?.dateLabel.isHidden = true
//                        }
//
//                        if self.isColor == "#aa2294" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "aa2294")
//                            cell?.dateLabel.textColor = UIColor(hex: "aa2294")
//
//                        } else if self.isColor == "#8ec96c" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "8ec96c")
//                            cell?.dateLabel.textColor = UIColor(hex: "aa2294")
//
//                        } else if self.isColor == "#ed9e6a" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "ed9e6a")
//                            cell?.dateLabel.textColor = UIColor(hex: "ed9e6a")
//
//                        } else if self.isColor == "#ff72d2" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "ff72d2")
//                            cell?.dateLabel.textColor = UIColor(hex: "ff72d2")
//
//                        } else if self.isColor == "#a84849" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "a84849")
//                            cell?.dateLabel.textColor = UIColor(hex: "a84849")
//
//                        } else if self.isColor == "#aa2294" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "aa2294")
//                            cell?.dateLabel.textColor = UIColor(hex: "aa2294")
//
//                        } else if self.isColor == "#056bba" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "056bba")
//                            cell?.dateLabel.textColor = UIColor(hex: "056bba")
//
//                        } else if self.isColor == "#0ba05d" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "0ba05d")
//                            cell?.dateLabel.textColor = UIColor(hex: "0ba05d")
//
//                        } else if self.isColor == "#b582af" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "b582af")
//                            cell?.dateLabel.textColor = UIColor(hex: "b582af")
//
//                        } else if self.isColor == "#f33d4c" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "f33d4c")
//                            cell?.dateLabel.textColor = UIColor(hex: "f33d4c")
//
//                        } else if self.isColor == "#f9c270" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "f9c270")
//                            cell?.dateLabel.textColor = UIColor(hex: "f9c270")
//
//                        } else if self.isColor == "#609b41" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "609b41")
//                            cell?.dateLabel.textColor = UIColor(hex: "609b41")
//
//                        } else if self.isColor == "#01a5a5" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "01a5a5")
//                            cell?.dateLabel.textColor = UIColor(hex: "01a5a5")
//
//                        } else if self.isColor == "#a085e2" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "a085e2")
//                            cell?.dateLabel.textColor = UIColor(hex: "a085e2")
//
//                        } else if self.isColor == "#fc9cde" {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "fc9cde")
//                            cell?.dateLabel.textColor = UIColor(hex: "fc9cde")
//                        } else {
//                            cell?.messageTxtView.backgroundColor = UIColor(hex: "aa2294")
//                            cell?.dateLabel.textColor = UIColor(hex: "aa2294")
//                        }
//                        cell?.starBtn.isHidden = !object.is_favourite
//                        return cell!
//                    }
//
//                case .rightContact:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderContact_TableCell.identifier) as? ChatSenderContact_TableCell
//                    cell?.selectionStyle = .none
//
//                    let dic =  convertToDictionary(text: (object.text?.htmlAttributedString!)!)
//                    cell?.nameLabel.text = "\(dic?["key"] ?? "")"
//                    cell?.contactLabel.text  =  "\(dic?["value"] ?? "")"
//
//                    cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//
//                case .rightGif:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderSticker_TableCel.identifier) as? ChatSenderSticker_TableCell
//                    cell?.selectionStyle = .none
//                    let url = URL(string: object._stickers)
//                    cell?.stickerImage.kf.indicatorType = .activity
//                    cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//                    var time = setLocalDate(timeStamp: object._time)
//                    if object.seen != "0" {
//                        time += "  \(NSLocalizedString("seen", comment: "seen"))"
//                    }
//                    cell?.timeLabel.text = time
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.backView.tag = indexPath.row
//                    cell?.backView.addTarget(self, action: #selector(clickGiftView), for: .touchUpInside)
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//
//                default:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverContact_TableCell.identifier) as? ChatReceiverContact_TableCell
//                    cell?.selectionStyle = .none
//
//                    let dic = convertToDictionary(text: (object._text.htmlAttributedString!))
//                    cell?.nameLabel.text = object._text.htmlAttributedString
//                    cell?.contactLabel.text  =  "Contact"
//                    cell?.timeLabel.text = object._time_text
//                    cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//                }
//
//            } else {
//                switch type {
//                case .leftAudio:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverAudio_TableCell.identifier) as? ChatReceiverAudio_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.delegate = self
//                    cell?.index = indexPath.row
//                    cell?.url = object._media
//                    cell?.durationLabel.text = NSLocalizedString("Loading...", comment: "Loading...")
//
//                    if isFistTry == true {
//                        Async.background({
//                            let audioURL = URL(string: object._media)
//                            self.player = AVPlayer(url: audioURL! as URL)
//                            let currentItem = self.player.currentItem
//                            let duration = currentItem!.asset.duration
//                            self.isFistTry = false
//                            Async.main({
//                                self.audioDuration = duration.durationText
//                                cell?.durationLabel.text = duration.durationText
//                            })
//                        })
//                    }else {
//                        cell?.durationLabel.text = audioDuration
//                    }
//
//                    cell?.timeLabel.text = self.setLocalDate(timeStamp: object.time)
//
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//
//                case .rightAudio:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderAudio_TableCell.identifier) as? ChatSenderAudio_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.delegate = self
//                    cell?.index = indexPath.row
//                    cell?.url = object._media
//                    var time = setLocalDate(timeStamp: object.time)
//                    if object.seen != "0" {
//                        time += "  \(NSLocalizedString("seen", comment: "seen"))"
//                    }
//                    cell?.timeLabel.text = time
//                    cell?.durationLabel.text = NSLocalizedString("Loading...", comment: "Loading...")
//                    Async.background({
//                        let audioURL = URL(string: object._media)
//                        self.player = AVPlayer(url: audioURL! as URL)
//                        cell?.timeLabel.text = self.setLocalDate(timeStamp: object._time)
//                        let currentItem = self.player.currentItem
//                        let duration = currentItem!.asset.duration
//                        Async.main({
//                            cell?.durationLabel.text = duration.durationText
//                        })
//                    })
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//
//
//                case .leftVideo:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.fileImage.isHidden = true
//                    cell?.videoView.isHidden = false
//                    cell?.playBtn.isHidden = false
//                    cell?.delegate = self
//                    cell?.index = indexPath.row
//                    let videoURL = URL(string: object._media)
//                    player = AVPlayer(url: videoURL! as URL)
//                    let playerController = AVPlayerViewController()
//                    playerController.player = player
//                    self.addChild(playerController)
//                    playerController.view.frame = self.view.frame
//                    cell?.videoView.addSubview(playerController.view)
//
//                    player.pause()
//                    cell?.timeLabel.text = setLocalDate(timeStamp: object._time)
//
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    cell?.playBtn.tag = indexPath.row
//                    cell?.playBtn.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
//                    return cell!
//
//                case .rightVideo:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
//                    var time = setLocalDate(timeStamp: object.time)
//                    if object.seen != "0" {
//                        time += "  \(NSLocalizedString("seen", comment: "seen"))"
//                    }
//                    cell?.selectionStyle = .none
//                    cell?.fileImage.isHidden = true
//                    cell?.videoView.isHidden = false
//                    cell?.playBtn.isHidden = false
//                    cell?.delegate = self
//                    cell?.index  = indexPath.row
//                    let videoURL = URL(string: object._media)
//                    player = AVPlayer(url: videoURL! as URL)
//                    let playerController = AVPlayerViewController()
//                    playerController.player = player
//                    self.addChild(playerController)
//                    playerController.view.frame = self.view.frame
//                    cell?.videoView.addSubview(playerController.view)
//                    player.pause()
//                    cell?.timeLabel.text = time
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.starBtn.isHidden = !object.is_favourite
//
//                    //                    if object._pin == "" {
//                    //                        self.pinViewHightConstraint.constant = 0
//                    //                    } else {
//                    //                        self.pinViewHightConstraint.constant = 70
//                    //                        self.userPinMassageLabel.text = "Last Pinned Message: Vidoe"
//                    //                    }
//                    cell?.playBtn.tag = indexPath.row
//                    cell?.playBtn.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
//                    return cell ?? UITableViewCell()
//
//                case .leftImage:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.fileImage.isHidden = false
//                    cell?.videoView.isHidden = true
//                    cell?.playBtn.isHidden = true
//
//                    let url = URL(string: object._media)
//                    cell?.fileImage.kf.indicatorType = .activity
//                    cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//
//                    cell?.timeLabel.text = setLocalDate(timeStamp: object._time)
//                    cell?.backGroundView.tag = indexPath.row
//                    cell?.backGroundView.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    //                    if object._pin == "" {
//                    //                        self.pinViewHightConstraint.constant = 0
//                    //                    } else {
//                    //                        self.pinViewHightConstraint.constant = 70
//                    //                        self.userPinMassageLabel.text = "Last Pinned Message:"
//                    //                    }
//                    return cell!
//
//                case .rightImage:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.fileImage.isHidden = false
//                    cell?.fileImage.isHidden = false
//                    cell?.videoView.isHidden = true
//                    cell?.playBtn.isHidden = true
//
//                    let url = URL(string:object._media)
//                    cell?.fileImage.kf.indicatorType = .activity
//                    cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//
//                    var time = setLocalDate(timeStamp: object._time)
//                    if object.seen != "0" {
//                        time += "  \(NSLocalizedString("seen", comment: "seen"))"
//                    }
//                    cell?.timeLabel.text = time
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.backView.tag = indexPath.row
//                    cell?.backView.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    //                    if object._pin == "" {
//                    //                        self.pinViewHightConstraint.constant = 0
//                    //                    } else {
//                    //                        self.pinViewHightConstraint.constant = 70
//                    //                        self.userPinMassageLabel.text = "Last Pinned Message:\(object._text.htmlAttributedString ?? "")"
//                    //                    }
//                    return cell!
//
//                case .rightFile:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier) as? ChatSenderDocument_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.fileNameLabel.text = object._media_file_name
//                    var time = setLocalDate(timeStamp: object._time)
//                    if object.seen != "0" {
//                        time += "  \(NSLocalizedString("seen", comment: "seen"))"
//                    }
//                    cell?.timeLabel.text = time
//                    if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#8ec96c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "8ec96c")
//
//                    } else if self.isColor == "#ed9e6a" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ed9e6a")
//
//                    } else if self.isColor == "#ff72d2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "ff72d2")
//
//                    } else if self.isColor == "#a84849" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a84849")
//
//                    } else if self.isColor == "#aa2294" {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//
//                    } else if self.isColor == "#056bba" {
//                        cell?.backView.backgroundColor = UIColor(hex: "056bba")
//
//                    } else if self.isColor == "#0ba05d" {
//                        cell?.backView.backgroundColor = UIColor(hex: "0ba05d")
//
//                    } else if self.isColor == "#b582af" {
//                        cell?.backView.backgroundColor = UIColor(hex: "b582af")
//
//                    } else if self.isColor == "#f33d4c" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f33d4c")
//
//                    } else if self.isColor == "#f9c270" {
//                        cell?.backView.backgroundColor = UIColor(hex: "f9c270")
//
//                    } else if self.isColor == "#609b41" {
//                        cell?.backView.backgroundColor = UIColor(hex: "609b41")
//
//                    } else if self.isColor == "#01a5a5" {
//                        cell?.backView.backgroundColor = UIColor(hex: "01a5a5")
//
//                    } else if self.isColor == "#a085e2" {
//                        cell?.backView.backgroundColor = UIColor(hex: "a085e2")
//
//                    } else if self.isColor == "#fc9cde" {
//                        cell?.backView.backgroundColor = UIColor(hex: "fc9cde")
//                    } else {
//                        cell?.backView.backgroundColor = UIColor(hex: "aa2294")
//                    }
//                    cell?.backView.tag = indexPath.row
//                    cell?.backView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    return cell!
//
//                default:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverDocument_TableCell.identifier) as? ChatReceiverDocument_TableCell
//                    cell?.selectionStyle = .none
//                    cell?.nameLabel.text = object._media_file_name
//                    let time = setLocalDate(timeStamp: object.time)
//                    cell?.timeLabel.text = time
//
//                    cell?.starBtn.isHidden = !object.is_favourite
//                    //                    if object._pin == "" {
//                    //                        self.pinViewHightConstraint.constant = 0
//                    //                    } else {
//                    //                        self.pinViewHightConstraint.constant = 70
//                    //                        self.userPinMassageLabel.text = "Last Pinned Message:\(object._text.htmlAttributedString ?? "")"
//                    //                    }
//                    return cell!
//                }
//            }
//        }
//        return UITableViewCell()
//    }
//
//
//    //MARK: - clickVidowButton
//    @objc func clickVidowButton(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let player = AVPlayer(url: URL(string: object.media ?? "")!)
//        let vc = AVPlayerViewController()
//        vc.player = player
//        self.present(vc, animated: true) {
//            vc.player?.play()
//        }
//    }
//
//    //MARK: - clickImageClick
//    @objc func clickImageClick(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
//        vc.imageURL = object.media ?? ""
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true, completion: nil)
//    }
//
//    //MARK: - clickFile
//    @objc func clickFile(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        var documentInteractionController: UIDocumentInteractionController?
//        self.DocUrl = object.media ?? ""
//        documentInteractionController = UIDocumentInteractionController()
//        let fileURL = URL(string: object.media ?? "")
//        documentInteractionController?.url = fileURL
//        documentInteractionController?.delegate = self
//        documentInteractionController?.presentPreview(animated: true)
//    }
//
//    //MARK: - clickGiftView
//    @objc func clickGiftView(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let url = URL(string: object.stickers ?? "")
//        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
//        vc.imageURL = object.stickers ?? ""
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true, completion: nil)
//    }
//
//    //MARK: - longPressed
//    @objc func longPressed(sender: UILongPressGestureRecognizer) {
//        let p = sender.location(in: self.tableView)
//        let indexPath = self.tableView.indexPathForRow(at: p)
//        let navigaction = ChatBottomSiteViewController.initialize(from: .chat)
//        if #available(iOS 15.0, *) {
//            if let chatBottom = navigaction.sheetPresentationController {
//                chatBottom.detents = [.medium(),.large()]
//                chatBottom.prefersScrollingExpandsWhenScrolledToEdge = false
//                chatBottom.prefersGrabberVisible = true
//            }
//        } else {
//        }
//        navigaction.delegate = self
//        navigaction.isBack = indexPath ?? IndexPath()
//        present(navigaction, animated: true, completion: nil)
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let object = self.messagesArray[indexPath.row]
//        print("Data KOna Che jo va de to jarak ==> \(object)")
//    }
//
//    func navigactionOnStoryboard(indexpath: Int, nameCell: String, isback: IndexPath) {
//        let object = self.messagesArray[isback.row]
//        if nameCell == "0" {
//            let vc = R.storyboard.favorite.chatInfoVC()
//            vc?.object = object
//            vc?.recipientID = self.recipientID
//            self.navigationController?.pushViewController(vc!, animated: true)
//
//        } else if nameCell == "1" {
//            self.deleteMsssage(messageID: object._message_id, indexPath: isback.row)
//
//        } else if nameCell == "2" {
//            let cellClass = self.tableView.cellForRow(at: isback)
//            let message = self.messagesArray[isback.row]
//
//            if let chatCell = cellClass as? ChatSender_TableCell {
//                self.replyUsernameLabel.text = "You"
//                self.replyTextLabel.text = chatCell.messageTxtView.text
//                self.isReplyStatus = true
//                self.replyMessageID = message._message_id
//                self.swipeToReply(index: isback)
//
//            } else if let revchatCell = cellClass as? ChatReceiver_TableCell {
//                self.replyUsernameLabel.text = self.usernameLabel.text
//                self.replyTextLabel.text = revchatCell.messageTxtView.text
//                self.isReplyStatus = true
//                self.replyMessageID = message._message_id
//                self.swipeToReply(index: isback)
//
//            } else if let cell = cellClass as? ReplyChatSenderTableItem {
//                self.replyUsernameLabel.text = "You"
//                self.replyTextLabel.text = cell.messageTextLabel.text ?? ""
//                self.isReplyStatus = true
//                self.replyMessageID = message._message_id
//                self.swipeToReply(index: isback)
//
//            } else if let revchatCell = cellClass as? replyReceiverTableItem {
//                self.replyUsernameLabel.text = self.usernameLabel.text
//                self.replyTextLabel.text = revchatCell.messageTextLabel.text
//                self.isReplyStatus = true
//                self.replyMessageID = message._message_id
//                self.swipeToReply(index: isback)
//            }
//
//        } else if nameCell == "3" {
//            let vc = R.storyboard.favorite.getFriendVC()
//            vc?.messageString = object._text
//            self.navigationController?.pushViewController(vc!, animated: true)
//
//        } else if nameCell == "4" {
//            if object._pin == "" {
//
//                if userPinMassageLabel.text == "" {
//                } else {
//                    object.pin = ""
//                    object.save()
//                }
//
//                let text = "\(self.decryptionAESModeECB(messageData: "\(object._text.htmlAttributedString ?? "")", key: object._time) ?? "")"
//                object.pin = text
//                self.isfavorites = object.is_favourite
//                if object._type == "right_text" || object._type == "left_text" {
//                    self.userPinMassageLabel.text = "Last Pin Message: Text"
//
//                } else if object._type == "right_image" || object._type == "left_image" {
//                    let url = URL(string: object.media ?? "")
//                    let extenion =  url?.pathExtension
//                    self.userPinMassageLabel.text = "Last Pin Message: Image.\(extenion ?? "")"
//
//                } else if object._type == "right_Adioes" || object._type == "left_audio" {
//                    self.userPinMassageLabel.text = "Last Pin Message: Adioes"
//
//                } else if object._type == "right_video" || object._type == "left_video" {
//                    self.userPinMassageLabel.text = "Last Pin Message: Video"
//
//
//                } else if object._type == "right_file" || object._type == "left_file" {
//                    let url = URL(string: object.media ?? "")
//                    let extenion =  url?.pathExtension
//                    self.userPinMassageLabel.text = "Last Pin Message: File.\(extenion ?? "")"
//
//                } else if object._type == "right_contact" || object._type == "left_contact" {
//                    self.userPinMassageLabel.text = "Last Pin Message: Contact"
//                }
//
//                let imageUrl = URL(string: object._media)
//                self.isimageName = imageUrl
//                self.textType = object.type ?? ""
//                self.ispintime = object.time_text ?? ""
//                self.isPintext = object._text
//                self.pinViewHightConstraint.constant = 70
//                //                self.userPinMassageLabel.text = text
//                object.save()
//            } else {
//                self.pinViewHightConstraint.constant = 0
//                object.pin = ""
//                object.save()
//            }
//        } else if nameCell == "5" {
//            if object.is_favourite {
//                object.is_favourite = false
//                object.save()
//                self.tableView.reloadData()
//            } else {
//                object.is_favourite = true
//                object.save()
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        guard !self.isFirstTime else { return }
//        guard let chat = self.chatModel else { return }
//
//        let position = scrollView.contentOffset.y
//        guard position < 70 && !self.isPagination else { return }
//        self.isPagination = true
//
//        self.offset += self.limit
//        let localMessages = Messages.getLastMessagesByChatID(chat.my_id, limit: self.offset)
//
//        if self.messagesArray.count != localMessages.count {
//            self.messagesArray = localMessages
//            self.onPaginationFinished()
//
//        } else {
//            guard let firstMsg = self.messagesArray.first else { return }
//            self.sendAPIRequestMessages(limit: 35, beforeMsgId: firstMsg._message_id) { [weak self] (list) in
//                guard let self = self,
//                      !list.isEmpty else {
//                    return
//                }
//                Messages.saveMessages(chatID: chat.my_id, list)
//                self.messagesArray = Messages.getLastMessagesByChatID(chat.my_id, limit: self.offset, ascending: false).reversed()
//
//                self.onPaginationFinished()
//            }
//        }
//    }
//}
//
//// MARK: - PLAY VIDEO DELEGATE
//
//extension ChatScreenVC: PlayVideoDelegate {
//
//    func playVideo(index: Int, status: Bool) {
//        if status {
//            log.verbose(" self.player.play()")
//        }else {
//            log.verbose("self.player.pause()")
//        }
//    }
//}
//
//// MARK: - PLAY AUDIO DELEGATE
//
//extension ChatScreenVC: PlayAudioDelegate {
//
//    func playAudio(index: Int, status: Bool, url: URL, button: UIButton) {
//        if status {
//            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!//since it sys
//            let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
//
//            self.playerItem = AVPlayerItem(url: destinationUrl)
//            self.player = AVPlayer(playerItem: self.playerItem)
//            self.player.play()
//            button.setImage(R.image.ic_pauseBtn(), for: .normal)
//        } else {
//            self.player.pause()
//            button.setImage(R.image.ic_playBtn(), for: .normal)
//        }
//    }
//}
//
//// MARK: - CALL RECEIVE DELEGATE
//
//extension ChatScreenVC: CallReceiveDelegate {
//
//    func receiveCall(callId: Int, RoomId: String, callingType: String, username: String, profileImage: String,accessToken: String?) {
//        //Check weather the to use agora or twilio
//        if ControlSettings.agoraCall == true && ControlSettings.twilloCall == false {
//            //Agora video call
//            if callingType == "video" {
//                let vc  = R.storyboard.call.videoCallVC()
//                vc?.callId = callId
//                vc?.roomID = RoomId
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
//            //Agora Audio calll
//            else {
//                let vc = R.storyboard.call.agoraCallVC()
//                vc?.callId = callId
//                vc?.roomID = RoomId
//                vc?.usernameString = username
//                vc?.profileImageUrlString = profileImage
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
//        }
//        //Twilio Call
//        else {
//            if callingType == "video" {
//                //Twilio video call
//                if self.navigationController?.viewControllers.last is TwilloVideoCallVC {
//                    //                    log.verbose("Video call controller is already presented")
//                }else {
//                    let vc = R.storyboard.call.twilloVideoCallVC()
//                    vc?.accessToken = accessToken ?? ""
//                    vc?.roomId = RoomId
//                    self.navigationController?.pushViewController(vc!, animated: true)
//                }
//            }
//            //Twilio Audio call
//            else {
//                if self.navigationController?.viewControllers.last is TwilloAudioCallVC {
//                }else {
//                    let vc = R.storyboard.call.twilloAudioCallVC()
//                    vc?.accessToken = accessToken ?? ""
//                    vc?.roomId = RoomId
//                    vc?.profileImageUrlString = profileImage
//                    vc?.usernameString = username
//                    self.navigationController?.pushViewController(vc!, animated: true)
//                }
//            }
//        }
//    }
//}
//
//// MARK: - DID SELECT GIF
//extension  ChatScreenVC: didSelectGIFDelegate {
//
//    func didSelectGIF(GIFUrl: String, id: String) {
//        self.sendGIF(url: GIFUrl)
//    }
//
//    private func sendGIF(url:String) {
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        //        let messageText = messageTxtView.text ?? ""
//        let recipientId = self.recipientID
//        let sessionID = AppInstance.instance._sessionId
//
//        Async.background({
//            ChatManager.instance.sendGIF(message_hash_id: messageHashId, receipent_id: recipientId, URl:url , session_Token: sessionID) { (success, sessionError, serverError, error) in
//                if success != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.resignFirstResponder()
//
//                            if self.messagesArray.count == 0 {
//                                //                                log.verbose("Will not scroll more")
//                            }else {
//                                if self.toneStatus {
//                                    self.playSendMessageSound()
//                                } else {
//                                }
//                                self.messageTxtView.text.removeAll()
//
//                                self.tableView.scrollToLastRow(animated: true)
//                            }
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                        }
//                    })
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                        }
//                    })
//                }
//            }
//        })
//    }
//}
//
//// MARK: - COLLECTION DELEGATE
//
//extension ChatScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.tempMsg.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TempMsgCollectionViewCell
//        cell.layer.cornerRadius = 18
//        cell.borderColorV = .darkGray
//        cell.msgLabel.text = self.tempMsg[indexPath.item]
//        cell.borderWidthV = 1
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label = UILabel(frame: CGRect.zero)
//        if UIDevice().userInterfaceIdiom == .phone {
//            if UIScreen.main.nativeBounds.height <= 1334 {
//                label.font = UIFont.systemFont(ofSize: 14)
//            }
//        }
//        label.text = self.tempMsg[indexPath.item]
//        label.sizeToFit()
//        return CGSize(width: label.frame.width + 20, height: self.collectionView.frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.sendMessage(messageText: self.tempMsg[indexPath.item], lat: 0, long: 0, socketCheck: ControlSettings.socketChat)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
//    }
//}
//
//// MARK: - SEND LOCATION PROTOCOL
//
//extension ChatScreenVC: sendLocationProtocol {
//
//    func sendLocation(lat: Double, long: Double) {
//        self.sendMessage(messageText: "", lat: lat, long: long, socketCheck: ControlSettings.socketChat)
//    }
//}
//
//// MARK: - CUSTOM FUNCTIONS
//
//extension ChatScreenVC {
//
//    @objc
//    private func update() {
//        self.fetchData()
//    }
//
//    private func onPaginationFinished() {
//        self.tableView.reloadData()
//        self.isPagination = false
//    }
//
//    private func resetKeyboardView() {
//        self.messageTxtView.inputView = nil
//        self.messageTxtView.keyboardType = .default
//        self.messageTxtView.reloadInputViews()
//    }
//
//    private func swipeToReply(index: IndexPath) {
//        self.heightConstraint.constant = 100
//        self.cancelPressed.isHidden = false
//        self.replyUsernameLabel.isHidden = false
//        self.replyTextLabel.isHidden = false
//        self.replyInView.isHidden = false
//        self.sideView.isHidden = false
//        self.messageTxtView.becomeFirstResponder()
//        self.animateRepltyView()
//    }
//
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//
//    private func convertDate(Unix: Double) -> Date {
//        let timestamp = Unix
//        let dateFromTimeStamp = Date(timeIntervalSinceNow: timestamp / 1000)
//        return dateFromTimeStamp
//    }
//
//    private func sendSelectedData(audioData: Data?, imageData: Data?, videoData: Data?, imageMimeType: String?, VideoMimeType: String?, audioMimeType: String?, Type: String?, fileData: Data?, fileExtension: String?, FileMimeType: String?) {
//
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        let sessionId = AppInstance.instance._sessionId
//        let dataType = Type ?? ""
//
//        if dataType == "image" {
//            Async.background({
//                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: nil, image_data: imageData, video_data: nil, imageMimeType: imageMimeType, videoMimeType: nil, audioMimeType: nil, text: "", file_data: nil, file_Extension: nil, fileMimeType: nil) { (success, sessionError, serverError, error) in
//
//                    if success != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.tableView.scrollToLastRow(animated: true)
//                            }
//                        })
//
//                    }else if sessionError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                            }
//                        })
//
//                    }else if serverError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                                //                                log.error("serverError = \(serverError?.errors?.errorText)")
//                            }
//                        })
//
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                                //                                log.error("error = \(error?.localizedDescription)")
//                            }
//                        })
//                    }
//                }
//            })
//        }
//        //To send an audio message
//        else if dataType == "audio" {
//            Async.background({
//                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: audioData, image_data: nil, video_data: nil, imageMimeType: nil, videoMimeType: nil,audioMimeType: audioMimeType, text: "", file_data: nil, file_Extension: "wav", fileMimeType: nil) { (success, sessionError, serverError, error) in
//
//                    if success != nil {
//                        //                        log.verbose("audio message send successfully")
//                    }else {
//                        //                        log.verbose("faild to send an audio message")
//                    }
//                    //                    if success != nil{
//                    //                        Async.main({
//                    //                            self.dismissProgressDialog {
//                    //                                log.debug("userList = \(success?.messageData ?? [])")
//                    //                                let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                    //                                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                    //                            }
//                    //                        })
//                    //                    }else if sessionError != nil{
//                    //                        Async.main({
//                    //                            self.dismissProgressDialog {
//                    //                                self.view.makeToast(sessionError?.errors?.errorText)
//                    //                                log.error("sessionError = \(sessionError?.errors?.errorText)")
//                    //
//                    //
//                    //                            }
//                    //                        })
//                    //                    }else if serverError != nil{
//                    //                        Async.main({
//                    //                            self.dismissProgressDialog {
//                    //                                self.view.makeToast(serverError?.errors?.errorText)
//                    //                                log.error("serverError = \(serverError?.errors?.errorText)")
//                    //                            }
//                    //
//                    //                        })
//                    //
//                    //                    }else {
//                    //                        Async.main({
//                    //                            self.dismissProgressDialog {
//                    //                                self.view.makeToast(error?.localizedDescription)
//                    //                                log.error("error = \(error?.localizedDescription)")
//                    //                            }
//                    //                        })
//                    //                    }
//                }
//            })
//        }
//
//        else if dataType == "video" {
//
//            Async.background({
//                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: nil, image_data: nil, video_data: videoData, imageMimeType: nil, videoMimeType: VideoMimeType, audioMimeType: nil, text: "", file_data: nil, file_Extension: nil, fileMimeType: nil) { (success, sessionError, serverError, error) in
//                    if success != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.tableView.scrollToLastRow(animated: true)
//
//                            }
//                        })
//                    }else if sessionError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                            }
//                        })
//                    }else if serverError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                            }
//                        })
//
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                            }
//                        })
//                    }
//                }
//            })
//
//        }else {
//            Async.background({
//                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: nil, image_data: nil, video_data: nil, imageMimeType: nil, videoMimeType: nil,audioMimeType: nil, text: "", file_data: fileData, file_Extension: fileExtension, fileMimeType: FileMimeType) { (success, sessionError, serverError, error) in
//
//                    if success != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.tableView.scrollToLastRow(animated: true)
//                            }
//                        })
//
//                    }else if sessionError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                            }
//                        })
//                    }else if serverError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                            }
//                        })
//
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                            }
//                        })
//                    }
//                }
//            })
//        }
//    }
//
//    private func reportError(error: OSStatus) {
//        // Handle error
//    }
//
//    private func convertAudio(_ url: URL, outputURL: URL) {
//        var error : OSStatus = noErr
//        var destinationFile: ExtAudioFileRef? = nil
//        var sourceFile : ExtAudioFileRef? = nil
//
//        var srcFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
//        var dstFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
//
//        ExtAudioFileOpenURL(url as CFURL, &sourceFile)
//
//        var thePropertySize: UInt32 = UInt32(MemoryLayout.stride(ofValue: srcFormat))
//
//        ExtAudioFileGetProperty(sourceFile!,
//                                kExtAudioFileProperty_FileDataFormat,
//                                &thePropertySize, &srcFormat)
//
//        dstFormat.mSampleRate = 44100  //Set sample rate
//        dstFormat.mFormatID = kAudioFormatLinearPCM
//        dstFormat.mChannelsPerFrame = 1
//        dstFormat.mBitsPerChannel = 16
//        dstFormat.mBytesPerPacket = 2 * dstFormat.mChannelsPerFrame
//        dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame
//        dstFormat.mFramesPerPacket = 1
//        dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked |
//        kAudioFormatFlagIsSignedInteger
//
//        // Create destination file
//        error = ExtAudioFileCreateWithURL(
//            outputURL as CFURL,
//            kAudioFileWAVEType,
//            &dstFormat,
//            nil,
//            AudioFileFlags.eraseFile.rawValue,
//            &destinationFile)
//        print("Error 1 in convertAudio: \(error.description)")
//
//        error = ExtAudioFileSetProperty(sourceFile!,
//                                        kExtAudioFileProperty_ClientDataFormat,
//                                        thePropertySize,
//                                        &dstFormat)
//        print("Error 2 in convertAudio: \(error.description)")
//
//        error = ExtAudioFileSetProperty(destinationFile!,
//                                        kExtAudioFileProperty_ClientDataFormat,
//                                        thePropertySize,
//                                        &dstFormat)
//        print("Error 3 in convertAudio: \(error.description)")
//
//        let bufferByteSize : UInt32 = 32768
//        var srcBuffer = [UInt8](repeating: 0, count: 32768)
//        var sourceFrameOffset : ULONG = 0
//
//        while(true){
//            var fillBufList = AudioBufferList(
//                mNumberBuffers: 1,
//                mBuffers: AudioBuffer(
//                    mNumberChannels: 2,
//                    mDataByteSize: UInt32(srcBuffer.count),
//                    mData: &srcBuffer
//                )
//            )
//            var numFrames : UInt32 = 0
//
//            if(dstFormat.mBytesPerFrame > 0){
//                numFrames = bufferByteSize / dstFormat.mBytesPerFrame
//            }
//
//            error = ExtAudioFileRead(sourceFile!, &numFrames, &fillBufList)
//            print("Error 4 in convertAudio: \(error.description)")
//
//            if(numFrames == 0){
//                error = noErr;
//                break;
//            }
//
//            sourceFrameOffset += numFrames
//            error = ExtAudioFileWrite(destinationFile!, numFrames, &fillBufList)
//            print("Error 5 in convertAudio: \(error.description)")
//        }
//
//        error = ExtAudioFileDispose(destinationFile!)
//        print("Error 6 in convertAudio: \(error.description)")
//        error = ExtAudioFileDispose(sourceFile!)
//        print("Error 7 in convertAudio: \(error.description)")
//    }
//
//    private func fetchUserProfile() {
//        let status = AppInstance.instance.getUserSession()
//
//        if status {
//            let sessionId = AppInstance.instance._sessionId
//
//            Async.background({
//                GetUserDataManager.instance.getUserData(user_id: self.recipientID, session_Token: sessionId, fetch_type: API.Params.User_data) { (success, sessionError, serverError, error) in
//                    if success != nil{
//                        Async.main({
//                            self.admin = success?.userData?.admin ?? ""
//                        })
//                    }else if sessionError != nil{
//                        Async.main({
//                        })
//                    }else if serverError != nil{
//                        Async.main({
//                        })
//
//                    }else {
//                        Async.main({
//                        })
//                    }
//                }
//            })
//
//        }else {
//            log.error(InterNetError)
//        }
//    }
//
//    fileprivate func setTemplateMessage() {
//        self.view.addSubview(self.collectionView)
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: -15).isActive = true
//        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
//        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
//        self.collectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
//
//    private func fetchData() {
//        guard let localChat = self.chatModel else { return }
//        let localMessages = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit, ascending: false)
//
//        if !localMessages.isEmpty {
//            if self.messagesArray.isEmpty {
//                self.collectionView.removeFromSuperview()
//                self.messagesArray = localMessages.reversed()
//                self.tableView.reloadData()
//                self.tableView.scrollToLastRow(animated: false)
//                self.isFirstTime = false
//
//            } else {
//                if let message = self.messagesArray.last {
//                    self.sendAPIRequestMessages(limit: 35, afterMsgId: message._message_id) { [weak self] (list) in
//                        guard let self = self else { return }
//                        guard !list.isEmpty else { return }
//
//                        Messages.saveMessages(chatID: localChat.my_id, list)
//                        let array = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit, ascending: false)
//                        self.messagesArray = array.reversed()
//                        self.tableView.reloadData()
//                        self.tableView.scrollToLastRow(animated: false)
//                        self.isFirstTime = false
//                    }
//                }
//            }
//
//        } else {
//            self.sendAPIRequestMessages(limit: self.limit) { [weak self] (list) in
//                guard let self = self else { return }
//
//                Messages.saveMessages(chatID: localChat.my_id, list)
//                self.messagesArray = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit)
//                self.tableView.reloadData()
//
//                if self.scrollStatus {
//                    if self.messagesArray.count == 0 {
//                        self.setTemplateMessage()
//
//                    }else {
//                        self.collectionView.removeFromSuperview()
//                        self.scrollStatus = false
//                        self.tableView.scrollToLastRow(animated: false)
//                        self.isFirstTime = false
//                    }
//
//                }else {
//                    guard self.messagesArray.count > self.messageCount else { return }
//                    if self.toneStatus {
//                        self.playReceiveMessageSound()
//                    }else {
//                    }
//                    self.tableView.scrollToLastRow(animated: false)
//                    self.isFirstTime = false
//                }
//            }
//        }
//    }
//
//    private func sendAPIRequestMessages(limit: Int,
//                                        afterMsgId: String? = nil,
//                                        beforeMsgId: String? = nil,
//                                        messageId: String? = nil, _ completion: @escaping ([MessageModel]) -> Void) {
//
//        let userId = AppInstance.instance._userId
//        let sessionID = AppInstance.instance._sessionId
//
//        Async.background({
//            ChatManager.instance.getUserMessages(user_id: userId,
//                                                 session_Token: sessionID,
//                                                 receipent_id: self.recipientID,
//                                                 limit: limit,
//                                                 afterMsgId: afterMsgId,
//                                                 beforeMsgId: beforeMsgId,
//                                                 messageId: messageId) { (result) in
//
//                switch result {
//                case .success(let model):
//                    Async.main({
//                        completion(model.messages ?? [])
//                    })
//                    break
//
//                case .failure(let error):
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error.localizedDescription)
//                        }
//                    })
//                    break
//                }
//            }
//        })
//    }
//
//    //MARK: - sendMessage Call
//    private func sendMessage(messageText: String, lat: Double, long: Double, socketCheck: Bool) {
//        guard let chat = self.chatModel else { return }
//
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        let messageText = messageText
//        let recipientId = self.recipientID
//        let sessionID = AppInstance.instance._sessionId
//
//        if !socketCheck {
//            let replyID = self.replyMessageID
//            let chatID = chat.my_id
//
//            let localMessage = Messages(chat_id: chatID,
//                                        message: MessageModel(type: .rightText,
//                                                              hash_id: "\(messageHashId)",
//                                                              text: messageText,
//                                                              receipent_id: recipientId,
//                                                              reply_id: replyID))
//            localMessage.save()
//            self.messagesArray.append(localMessage)
//            self.tableView.reloadData()
//            self.tableView.scrollToLastRow(animated: true)
//
//            Async.background({
//                ChatManager.instance.sendMessage(localMessage, session_token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
//                    if success != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.resignFirstResponder()
//
//                                guard self.messagesArray.count != 0 else { return }
//                                if self.toneStatus {
//                                    self.playSendMessageSound()
//                                } else {
//                                }
//
//                                if self.isReplyStatus {
//                                    self.heightConstraint.constant = 0
//                                    self.cancelPressed.isHidden = true
//                                    self.replyUsernameLabel.isHidden = true
//                                    self.replyTextLabel.isHidden = true
//                                    self.replyMessageID = ""
//                                    self.isReplyStatus = false
//                                    self.replyInView.isHidden = true
//                                    self.sideView.isHidden = true
//                                }
//                                guard let sendMessage = success?.messages?.first(where: { $0._messageHashID == "\(messageHashId)" }) else {
//                                    return
//                                }
//                                localMessage.updateMessage(message: sendMessage)
//                            }
//                        })
//
//                    } else if sessionError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                            }
//                        })
//
//                    } else if serverError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                            }
//                        })
//
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                            }
//                        })
//                    }
//                })
//            })
//
//        } else {
//        }
//    }
//
////    private func sendContact(jsonPayload: String?) {
////
////        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
////
////        let jsonPayloadString = jsonPayload ??  ""
////        let recipientId = self.recipientID
////        let sessionID = AppInstance.instance._sessionId
////
////        Async.background({
////            ChatManager.instance.sendContact(message_hash_id: messageHashId, receipent_id: recipientId, jsonPayload: jsonPayloadString, session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
////                if success != nil {
////                    Async.main({
////                        self.dismissProgressDialog {
////                            //                            log.debug("userList = \(success?.messageData ?? [])")
////                            let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
////                            self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
////                        }
////                    })
////
////                }else if sessionError != nil {
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(sessionError?.errors?.errorText)
////                        }
////                    })
////                }else if serverError != nil {
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(serverError?.errors?.errorText)
////                        }
////                    })
////
////                }else {
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(error?.localizedDescription)
////                            //                            log.error("error = \(error?.localizedDescription)")
////                        }
////                    })
////                }
////            })
////        })
////    }
//
//    private func playSendMessageSound() {
//        guard let url = Bundle.main.url(forResource: "Popup_SendMesseges", withExtension: "mp3") else { return }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let aPlayer = sendMessageAudioPlayer else { return }
//            aPlayer.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    private func playReceiveMessageSound() {
//        guard let url = Bundle.main.url(forResource: "Popup_GetMesseges", withExtension: "mp3") else { return }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let aPlayer = receiveMessageAudioPlayer else { return }
//            aPlayer.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    private func deleteChat() {
//        //
//        let sessionID = AppInstance.instance._sessionId
//
//        Async.background({
//            BotttomSiteUserList.instance.deleteChat(user_id: self.recipientID, session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            if ControlSettings.socketChat{
//                                self.messagesArray.removeAll()
//                                self.tableView.reloadData()
//                            }
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                        }
//                    })
//                }
//            })
//        })
//    }
//
//    private func blockUser() {
//
//        if self.admin == "1" {
//            let alert = UIAlertController(title: "",
//                                          message: NSLocalizedString("You cannot block this user because it is administrator", comment: "You cannot block this user because it is administrator"),
//                                          preferredStyle: .alert)
//            let okay = UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"),
//                                     style: .default,
//                                     handler: nil)
//            alert.addAction(okay)
//            self.present(alert, animated: true, completion:nil)
//
//        }else {
//            //
//            let sessionToken = AppInstance.instance._sessionId
//
//            Async.background({
//                BlockUsersManager.instanc.blockUnblockUser(session_Token: sessionToken, blockTo_userId: self.recipientID, block_Action: "block", completionBlock: { (success, sessionError, serverError, error) in
//                    if success != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(NSLocalizedString("User has been unblocked!!", comment: "User has been unblocked!!"))
//                                self.navigationController?.popViewController(animated: true)
//                            }
//                        })
//
//                    }else if sessionError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                            }
//                        })
//
//                    } else if serverError != nil {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                            }
//                        })
//
//                    } else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                            }
//                        })
//                    }
//                })
//            })
//        }
//    }
//
//    private func changeChatColor(colorHexString: String) {
//
//        let sessionToken = AppInstance.instance._sessionId
//        Async.background({
//            ColorManager.instanc.changeChatColor(session_Token: sessionToken, receipentId: self.recipientID, colorHexString: colorHexString, completionBlock: { (success, sessionError, serverError, error) in
//
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                        }
//                    })
//                }
//            })
//        })
//    }
//
//    private func deleteMsssage(messageID: String, indexPath: Int) {
//
//        let sessionID = AppInstance.instance._sessionId
//
//        Async.background({
//            ChatManager.instance.deleteChatMessage(messageId: messageID , session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            //                            log.debug("userList = \(success?.message ?? "")")
//                            self.messagesArray.remove(at: indexPath)
//                            var favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
//                            var message = favoriteAll[self.recipientID] ?? []
//
//                            for (item,value) in message.enumerated() {
//                                let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: value)
//                                if favoriteMessage?.id == messageID{
//                                    message.remove(at: item)
//                                    break
//                                }
//                            }
//                            favoriteAll[self.recipientID] = message
//                            UserDefaults.standard.setFavorite(value: favoriteAll , ForKey: Local.FAVORITE.favorite)
//                            self.tableView.reloadData()
//                        }
//                    })
//
//                } else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                        }
//                    })
//
//                } else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                        }
//                    })
//
//                } else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                        }
//                    })
//                }
//            })
//        })
//    }
//
//    private func customizeDropdown() {
//        moreDropdown.dataSource = [NSLocalizedString("View Profile", comment: "View Profile"),
//                                   NSLocalizedString("Block User", comment: "Block User"),
//                                   NSLocalizedString("Change Chat Theme", comment: "Change Chat Theme"),
//                                   NSLocalizedString("Clear Chat", comment: "Clear Chat"),
//                                   NSLocalizedString("Started Messages", comment: "Started Messages")]
//        moreDropdown.backgroundColor = UIColor.hexStringToUIColor(hex: "454345")
//        moreDropdown.textColor = UIColor.white
//        moreDropdown.anchorView = self.moreBtn
//        moreDropdown.width = 200
//        moreDropdown.direction = .any
//        moreDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
//            if index == 0 {
//                self.navigateToUserProfile()
//
//            }else if index == 1 {
//                self.blockUser()
//
//            }else if index == 2 {
//                if let popoverController = MKColorPicker.popoverPresentationController {
//                    popoverController.delegate = MKColorPicker
//                    popoverController.permittedArrowDirections = .any
//                    popoverController.sourceView = moreBtn
//                    popoverController.sourceRect = moreBtn.bounds
//                }
//                self.present(MKColorPicker, animated: true, completion: nil)
//
//            }else if index == 3 {
//                self.deleteChat()
//
//            }else if index == 4 {
//                let vc = R.storyboard.favorite.favoriteVC()
//                vc?.recipientID = self.recipientID
////                vc?.messagesArray = self.messagesArray
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
//        }
//    }
//
//    private func setupUI() {
//
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
//        self.tableView.addGestureRecognizer(longPressRecognizer)
//
//        let XIB = UINib(nibName: "MapViewCell", bundle: nil)
//        self.tableView.register(XIB, forCellReuseIdentifier: "MapViewCell")
//
//        let ReceiveMapXIB = UINib(nibName: "MapViewReceiveCell", bundle: nil)
//        self.tableView.register(ReceiveMapXIB, forCellReuseIdentifier: "MapViewReceiveCell")
//
//        var setTimer = ""
//        setTimer = setTimestamp(epochTime: self.chatModel?.getChatUsers().first?.user?._last_seen ?? searchUserObject?.lastseen ?? followingUserObject?.lastseen ?? "0")
//
//        self.setupTapOnUsernameToViewProfile()
//        self.toneStatus = UserDefaults.standard.getConversationTone(Key: Local.CONVERSATION_TONE.ConversationTone)
//
//
//        //MARK:  microBtn
//        self.microBtn.isHidden = false
//        self.showAudioView.isHidden = true
//        self.messageTxtView.delegate = self
//        self.usernameLabel.text = chatModel?.name ?? searchUserObject?.name ?? followingUserObject?.name ?? ""
//
//        let url = URL(string: chatModel?.getChatUsers().first?.user?._avatar_url ?? searchUserObject?.avatar ?? followingUserObject?.avatar ?? "")
//
//        self.objUrlProfile = URL(string: "\(url)") as? String ?? ""
//        self.profileImage.kf.indicatorType = .activity
//        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//
//        self.usernameLabel.text = chatModel?.name ?? searchUserObject?.name ?? followingUserObject?.name ?? ""
//
//        if object_LatSeen == "off" {
//            self.lastSeenLabel.isHidden = true
//        } else  {
//            self.lastSeenLabel.isHidden = false
//            self.lastSeenLabel.text = setTimer
//        }
//
//        self.showAudioPlayBtn.cornerRadiusV = self.showAudioPlayBtn.frame.height / 2
//        self.tableView.separatorStyle = .none
//        tableView.register( R.nib.chatSenderTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier)
//        tableView.register( R.nib.chatReceiverTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiver_TableCell.identifier)
//        tableView.register( R.nib.chatSenderImageTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier)
//        tableView.register( R.nib.chatReceiverImageTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier)
//        tableView.register( R.nib.chatSenderContactTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSenderContact_TableCell.identifier)
//        tableView.register( R.nib.chatReceiverContactTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiverContact_TableCell.identifier)
//        tableView.register( R.nib.chatSenderStickerTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSenderSticker_TableCel.identifier)
//        tableView.register( R.nib.chatReceiverStrickerTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiverStricker_TableCell.identifier)
//        tableView.register( R.nib.chatSenderAudioTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSenderAudio_TableCell.identifier)
//        tableView.register( R.nib.chatReceiverAudioTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiverAudio_TableCell.identifier)
//        tableView.register( R.nib.chatSenderDocumentTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier)
//        tableView.register( R.nib.chatReceiverDocumentTableCell(),
//                            forCellReuseIdentifier: R.reuseIdentifier.chatReceiverDocument_TableCell.identifier)
//        tableView.register( R.nib.replyChatSenderTableItem(),
//                            forCellReuseIdentifier: R.reuseIdentifier.replyChatSenderTableItem.identifier)
//        tableView.register( R.nib.replyReceiverTableItem(),
//                            forCellReuseIdentifier: R.reuseIdentifier.replyReceiverTableItem.identifier)
//
//
//    }
//
//    private func adjustHeight() {
//        let size = self.messageTxtView.sizeThatFits(CGSize(width: self.messageTxtView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
//        textViewHeightContraint.constant = size.height
//        self.viewDidLayoutSubviews()
//        self.messageTxtView.setContentOffset(.zero, animated: false)
//    }
//
//    private func textViewPlaceHolder() {
//        messageTxtView.delegate = self
//        messageTxtView.text = NSLocalizedString("Your message here...", comment: "Your message here...")
//        messageTxtView.textColor = UIColor.lightGray
//    }
//
//    private func openVideoGallery() {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
//        picker.mediaTypes = ["public.movie"]
//
//        picker.allowsEditing = false
//        present(picker, animated: true, completion: nil)
//    }
//
//    fileprivate func animateRepltyView() {
//        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.layoutSubviews, animations: {
//            self.view.layoutSubviews()
//        }, completion: nil)
//    }
//
//    private func setupTapOnUsernameToViewProfile() {
//        //For profile
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatScreenVC.showProfile))
//        usernameLabel.isUserInteractionEnabled = true
//        lastSeenLabel.isUserInteractionEnabled = true
//        lastSeenLabel.addGestureRecognizer(tap)
//        usernameLabel.addGestureRecognizer(tap)
//    }
//
//    private func navigateToUserProfile() {
//        let vc = R.storyboard.dashboard.userProfileVC()
//        vc?.isFollowing = 0
//        vc?.chat = self.chatModel
//        vc?.getUserData(user_ID: chatModel?.getChatUsers().first?.user?.user_id ?? "")
//        vc?.isfind = false
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
//
//    fileprivate func animatedKeyBoard(scrollToBottom: Bool) {
//        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            if scrollToBottom {
//                self.view.layoutIfNeeded()
//            }
//        }, completion: { (completed) in
//            if scrollToBottom {
//                guard !self.messagesArray.isEmpty else { return }
//                self.tableView.scrollToLastRow(animated: true)
//            }
//        })
//    }
//
//    func getHoursMinutesSecondsFrom(seconds: Double) -> (hours: Int, minutes: Int, seconds: Int) {
//        let secs = Int(seconds)
//        let hours = secs / 3600
//        let minutes = (secs % 3600) / 60
//        let seconds = (secs % 3600) % 60
//        return (hours, minutes, seconds)
//    }
//
//    func formatTimeFor(seconds: Double) -> String {
//        let result = getHoursMinutesSecondsFrom(seconds: seconds)
//        let hoursString = "\(result.hours)"
//        var minutesString = "\(result.minutes)"
//        if minutesString.count == 1 {
//            minutesString = "0\(result.minutes)"
//        }
//        var secondsString = "\(result.seconds)"
//        if secondsString.count == 1 {
//            secondsString = "0\(result.seconds)"
//        }
//        var time = "\(hoursString):"
//        if result.hours >= 1 {
//            time.append("\(minutesString):\(secondsString)")
//        }
//        else {
//            time = "\(minutesString):\(secondsString)"
//        }
//        return time
//    }
//
//    private func setFavorite(receipentID: String, ID: String, object: Messages) {
//        object.is_favourite = true
//        object.save()
//        self.tableView.reloadData()
//    }
//}
//
//// MARK: - AVPLAYER EXTENSION
//
//extension AVPlayer {
//
//    func generateThumbnail(time: CMTime) -> UIImage? {
//        guard let asset = currentItem?.asset else { return nil }
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//
//        do {
//            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//            return UIImage(cgImage: cgImage)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        return nil
//    }
//}
//
//// MARK: - CMTIME EXTENSION
//
//extension CMTime {
//
//    var durationText: String {
//        let totalSeconds = CMTimeGetSeconds(self)
//        let hours:Int = Int(totalSeconds / 3600)
//        let minutes:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
//        let seconds:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
//
//        if hours > 0 {
//            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
//        } else {
//            return String(format: "%02i:%02i", minutes, seconds)
//        }
//    }
//}
//
//extension ChatScreenVC: UIDocumentInteractionControllerDelegate {
//
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return self
//    }
//
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
//        return self.view
//    }
//
//}
//
//extension ChatScreenVC: passiBottomArrayDelegate {
//    func passingdata(_ viewController: ChatBottomSiteViewController, indexpath: Int, nameof: String, isBack: IndexPath) {
//        self.navigactionOnStoryboard(indexpath: indexpath, nameCell: nameof, isback: isBack)
//    }
//}
//
////MARK: - ChatScreenVC
//extension ChatScreenVC {
//    func setSendBytton() {
//        if self.messageTxtView.text == "" {
//            self.sendBtn.isHidden = true
//            self.microBtn.isHidden = false
//            //            SocketMangaer.sharedInstance.delegate = self
//            //            SocketMangaer.sharedInstance.sendTypingStatusSocketCall(recipentID: self.recipientID,
//            //                                                    userID: AppInstance.instance._sessionId) {
//            //            }
//        } else {
//            self.sendBtn.isHidden = false
//            self.microBtn.isHidden = true
//            //            SocketMangaer.sharedInstance.delegate = self
//            //            SocketMangaer.sharedInstance.sendTypingStatusSocketCall(recipentID: self.recipientID,
//            //                                                    userID: AppInstance.instance._sessionId) {
//            //            }
//        }
//    }
//}
//
////MARK: - ChatScreenVC
//extension ChatScreenVC: GMSMapViewDelegate, CLLocationManagerDelegate {
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print(position)
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        print(gesture)
//    }
//
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        print(position)
//    }
//}
//
//extension ChatScreenVC: SetTypingstutesDelegate {
//    func setTypingstutes(typing: String) {
//        if typing == "" {
//            self.lastSeenLabel.text = ""
//            self.lastSeenLabel.isHidden = true
//        } else {
//            self.lastSeenLabel.text = "typing..."
//            self.lastSeenLabel.isHidden = false
//        }
//    }
//}
//
//extension ChatScreenVC: DoneTypingstutesDelegate {
//    func doneTypingstutes(typing: String) {
//        print("Thai gyu bhai")
//    }
//}
//
//extension ChatScreenVC: SendMassageDelegate {
//    func sendMessages(avatar: String,
//                      color: String,
//                      id: String,
//                      isMedia: String,
//                      isRecord: String,
//                      message_html: String,
//                      message: String,
//                      message_id: String,
//                      receiver: String,
//                      sender: String,
//                      time: String,
//                      username: String) {
//        print("color => \(color)")
//        print("avatar => \(avatar)")
//        print("message => \(message)")
//        print("sender => \(sender)")
//    }
//
//
//}
//
