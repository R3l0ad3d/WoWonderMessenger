

import UIKit
import XLPagerTabStrip
import SwiftEventBus
import WowonderMessengerSDK
import Async
import GoogleMobileAds
import FBAudienceNetwork


class GroupVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var downTextLabel: UILabel!
    @IBOutlet weak var noMessagesLabel: UILabel!
    @IBOutlet weak var showStack: UIStackView!
    @IBOutlet weak var noGroupChatImage: UIImageView!
    
    @IBOutlet weak var noimageImagevIew: UIImageView!
    @IBOutlet weak var vidoeCallImage: UIImageView!
    @IBOutlet weak var crtareGroopImagevIEw: UIImageView!
    @IBOutlet weak var tittleNameLabel: UILabel!
    //Varblie's
    private var refreshControl = UIRefreshControl()
    private var fetchSatus:Bool? = true
    private var groupChatRequestArray = [GroupRequestModel.GroupChatRequest]()
    private var groupsArray = [FetchGroupModel.Datum]()
    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd!
    
    //Facebook Ads
    var fullScreenAd: FBInterstitialAd!
    var bannerAdView: FBAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fetchData()
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_DIS_CONNECTED) { result in
            log.verbose("Internet dis connected!")
        }
    }
    deinit {
        SwiftEventBus.unregister(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func createNewVideoButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func serchButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.dashboard.searchRandomVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func createGroupButton(_ sender: UIControl) {
        self.view.endEditing(true)
        AppInstance.instance.addCount =  AppInstance.instance.addCount! + 1
        let vc = CreateGroupViewController.initialize(from: .group)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addGroupPressed(_ sender: Any) {
        self.view.endEditing(true)
        AppInstance.instance.addCount =  AppInstance.instance.addCount! + 1
        let vc = CreateGroupVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func CreateAd() -> GADInterstitialAd {
        
        GADInterstitialAd.load(withAdUnitID:ControlSettings.interestialAddUnitId,
                               request: GADRequest(),
                               completionHandler: { (ad, error) in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
        })
        return  self.interstitial
    }
    
    func setupUI(){
        self.noGroupChatImage.tintColor = .mainColor
        self.tableView.isHidden = true
        self.noMessagesLabel.text = NSLocalizedString("No more Groups", comment: "")
        self.downTextLabel.text = NSLocalizedString("Start new conversations by going to contact", comment: "")
        self.noGroupChatImage.isHidden = true
        self.showStack.isHidden = true
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        self.tableView.separatorStyle = .none
        //        tableView.register( R.nib.groupTableCell(), forCellReuseIdentifier: R.reuseIdentifier.group_TableCell.identifier)
        //        tableView.register( R.nib.groupRequestTableCell(), forCellReuseIdentifier: R.reuseIdentifier.groupRequest_TableCell.identifier)
        let UserListChatXIB = UINib(nibName: "UserListChatCell", bundle: nil)
        self.tableView.register(UserListChatXIB, forCellReuseIdentifier: "UserListChatCell")
        
        self.noGroupChatImage.tintColor = UIColor.mainColor
        self.tittleNameLabel.textColor = UIColor.mainColor
        self.vidoeCallImage.tintColor = UIColor.mainColor
        self.crtareGroopImagevIEw.tintColor =  UIColor.mainColor
    }
    
    @objc func refresh(sender:AnyObject) {
        fetchSatus = true
        self.groupsArray.removeAll()
        self.tableView.reloadData()
        self.fetchData()
    }
    
    private func fetchData(){
        if fetchSatus!{
            fetchSatus = false
            //            //
        }else{
            log.verbose("will not show Hud more...")
        }
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.fetchGroups(session_Token: sessionToken, type: "get_list", limit: 10
                                                  , completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.data ?? nil)")
                            if (success?.data?.isEmpty)!{
                                
                                self.noGroupChatImage.isHidden = false
                                self.showStack.isHidden = false
                                self.tableView.isHidden = true
                                self.refreshControl.endRefreshing()
                            } else {
                                self.noGroupChatImage.isHidden = true
                                self.showStack.isHidden = true
                                self.tableView.isHidden = false
                                self.groupsArray = (success?.data) ?? []
                                
                                self.tableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                            self.fetchGroupRequest()
                        }
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            })
        })
        
    }
    
    private func fetchGroupRequest(){
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupRequestManager.instance.fetchGroupRequest(session_Token: sessionToken, fetchType: "group_chat_requests", offset: 1, setOnline: 1) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(String(describing: success?.groupChatRequests))")
                            self.groupChatRequestArray = success?.groupChatRequests ?? []
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            }
        })
        
    }
    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    func convertDate(Unix:Double) -> Date{
        let timestamp = Unix
        
        var dateFromTimeStamp = Date(timeIntervalSinceNow: timestamp as! TimeInterval / 1000)
        return dateFromTimeStamp
        
    }
    
}
extension GroupVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupsArray.count
    }
    
    //--------- NEW CODE --------- //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListChatCell") as? UserListChatCell
        self.setGroupListData(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func setGroupListData(cell: UserListChatCell?, indexPath: IndexPath) {
        let objGroups = groupsArray[indexPath.row]
        cell?.timelabel.isHidden = true
        cell?.isLastSeenImage.isHidden = true
        cell?.userNameLabel.text = objGroups.groupName
        cell?.userimageView.kf.indicatorType = .activity
        let URL = URL(string: objGroups.avatar ?? "")
        cell?.userimageView.kf.setImage(with: URL, placeholder: UIImage(named: ""))
        let datefromtTime = setTimestamp(epochTime: (objGroups.time ?? ""))
        cell?.lastMassageLabel.text = "\(datefromtTime)"
        cell?.pinmasage.isHidden = true
        cell?.muteImageVIew.isHidden = true
        cell?.isLastSeenImage.isHidden = true
        cell?.stutesView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension GroupVC :FBInterstitialAdDelegate{
    
    func loadFullViewAdd(){
        fullScreenAd = FBInterstitialAd(placementID: ControlSettings.facebookPlacementID)
        fullScreenAd.delegate = self
        fullScreenAd.load()
    }
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        interstitialAd.show(fromRootViewController: self)
        print("AddLoaded")
        
    }
    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
    }
}

extension GroupVC:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("GROUPS", comment: "GROUPS"))
    }
}
