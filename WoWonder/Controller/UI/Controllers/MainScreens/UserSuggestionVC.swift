

import UIKit
import Async
import WowonderMessengerSDK
import Kingfisher

class UserSuggestionVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var uperLabel: UILabel!
    @IBOutlet weak var showStack: UIStackView!
    @IBOutlet weak var noUserimage: UIImageView!
    
    private  var refreshControl = UIRefreshControl()
    private let color = UIColor.hexStringToUIColor(hex: "A84849")
    private var userArray = [UserSuggestionModel.Suggestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    private func setupUI(){
        self.noUserimage.tintColor = .mainColor
        self.title = NSLocalizedString("Suggested Users", comment: "")
        self.uperLabel.text = NSLocalizedString("There are no suggested Users Available", comment: "")
        self.noUserimage.isHidden = true
        self.showStack.isHidden = true
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.register( UINib(nibName: R.reuseIdentifier.userSuggestionCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.userSuggestionCollectionCell.identifier)
        let Done = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done"), style: .done, target: self, action: Selector("Done"))
        self.navigationItem.rightBarButtonItem = Done
    }
    
    @objc func refresh(sender:AnyObject) {
        self.userArray.removeAll()
        self.collectionView.reloadData()
        self.fetchData()
    }
    
    @objc func Done() {
        let vc = R.storyboard.dashboard.mainNavigationViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    private func fetchData() {
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            UserSuggestionManager.instance.fetchUserSuggestion(session_Token: sessionToken, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.apiStatus ?? nil)")
                            if (success?.suggestions?.isEmpty)!{
                                
                                self.noUserimage.isHidden = false
                                self.showStack.isHidden = false
                                self.refreshControl.endRefreshing()
                            }else {
                                self.noUserimage.isHidden = true
                                self.showStack.isHidden = true
                                self.userArray = (success?.suggestions) ?? []
                                
                                self.collectionView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText)")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                }
            })
        })
    }
}

extension UserSuggestionVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.userSuggestionCollectionCell.identifier, for: indexPath) as? UserSuggestionCollectionCell
        cell?.setupCell()
        let object = self.userArray[indexPath.row]
        cell?.delegate = self
        cell?.indexPath = indexPath.row
        cell?.userId  = object.userID ?? ""
        cell?.nameLabel.text = object.name ?? ""
        cell?.usernameLabel.text = object.username ?? ""
//        let datefromtTime = convertDate(Unix: Double(object.lastseen ?? "0.0") as! Double)
//        cell?.timeLabel.text = timeAgoSinceDate(datefromtTime)
        let url = URL(string:object.avatar ?? "")
        
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
       
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 60) / 3
        return CGSize(width: width, height: width)
    }
}

extension UserSuggestionVC: FollowUnFollowDelegate {
    
    func followUnfollow(user_id: String, index: Int, cellBtn: UIButton) {
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            FollowingManager.instance.followUnfollow(user_id: user_id, session_Token: sessionToken, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.followStatus ?? "")")
                            self.view.makeToast(success?.followStatus ?? "")
                            if success?.followStatus  ?? "" == "followed"{
                                cellBtn.backgroundColor = self.color
                                cellBtn.setTitleColor(UIColor.white, for: .normal)
                                cellBtn.setTitle(NSLocalizedString("following", comment: "following"), for: .normal)
//                                self.view.makeToast(success?.followStatus ?? "")
                                
                            }else{
                                cellBtn.backgroundColor = UIColor.white
                                cellBtn.borderColorV = self.color
                                cellBtn.borderWidthV = 2
                                cellBtn.setTitleColor(self.color, for: .normal)
                                cellBtn.setTitle(NSLocalizedString("follow", comment: "follow"), for: .normal)
//                                self.view.makeToast(success?.followStatus ?? "")
                            }
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText)")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                }
            })
        })
    }
}
