//
//  StoryViewController.swift
//  WoWonder
//
//  Created by UnikApp on 13/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async

class StoryViewController: BaseVC {
    
    @IBOutlet weak var titleNamelabel: UILabel!
    @IBOutlet weak var StoryTableview: UITableView!
    @IBOutlet weak var emtyListTabeleVIew: UIView!
    @IBOutlet weak var newStoryView: UIControl!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var camraImage: UIImageView!
    @IBOutlet weak var locationPin: UIImageView!
    var delegate:ImagePickerDelegate?
    private let imagePickerController = UIImagePickerController()
    private var storiesArray = [UserDataElement]()
    
    @IBOutlet weak var viewColorAddStoryVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let url = URL(string: AppInstance.instance.userProfile?.avatar ?? "")
        self.userImageView.kf.indicatorType = .activity
        self.userImageView.kf.setImage(with: url)
        
        StoryTableview.register( Stories_TableCell.nib, forCellReuseIdentifier: Stories_TableCell.identifier)
        self.titleNamelabel.textColor = UIColor.mainColor
//        self.locationPin.tintColor = UIColor.mainColor
        self.camraImage.tintColor = UIColor.mainColor
        self.viewColorAddStoryVIew.backgroundColor = UIColor.mainColor
        
        locationPin.image = UIImage(named: "ic_New_locationpin")?.withRenderingMode(.alwaysTemplate)
        locationPin.tintColor = UIColor.mainColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    
    @IBAction func newStoryViewClick(_ sender: Any) {
        let StoryBottomViewController = StoryBottomViewController.initialize(from: .story)
        StoryBottomViewController.modalPresentationStyle = .overCurrentContext
        StoryBottomViewController.delegate = self
        self.navigationController?.present(StoryBottomViewController, animated: true)
    }
    
    @IBAction func searchButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.dashboard.searchRandomVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func profileButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let VC = RequestViewController.initialize(from: .dashboard)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func locationButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let finedFrined = FindFriendsViewController.initialize(from: .dashboard)
        self.navigationController?.pushViewController(finedFrined, animated: true)
    }
    
    func openVideoGallery(){
        let picker = UIImagePickerController()
        self.delegate = self
        picker.delegate = self
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        picker.mediaTypes = ["public.movie"]
        
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    private func cameraGallery(){
        
        let alert = UIAlertController(title: "", message: NSLocalizedString("Select Source", comment: "Select Source"), preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera"), style: .default) { (action) in
            self.delegate = self
            self.imagePickerController.delegate = self
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: "Gallery"), style: .default) { (action) in
            self.delegate = self
            self.imagePickerController.delegate = self
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .destructive, handler: nil)
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fetchData() {
        
        Async.background({
            StoriesManager.instance.getStories(session_Token: AppInstance.instance.sessionId ?? "", limit: 10, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.storiesArray = (success?.stories) ?? []
                        if self.storiesArray.isEmpty {
                            self.emtyListTabeleVIew.isHidden = false
                        } else {
                            self.emtyListTabeleVIew.isHidden = true
                        }
                        self.StoryTableview.reloadData()
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.view.makeToast(sessionError?.errors?.errorText)
                        //                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                    })
                }else if serverError != nil{
                    Async.main({
                        self.view.makeToast(serverError?.errors?.errorText)
                        //                            log.error("serverError = \(serverError?.errors?.errorText)")
                    })
                    
                }else {
                    Async.main({
                        self.view.makeToast(error?.localizedDescription)
                        //                            log.error("error = \(error?.localizedDescription)")
                    })
                }
            })
        })
    }
}

// MARK: - StoryBottomdDelegate
extension StoryViewController: StoryBottomdDelegate {
    func nameClick(name: String) {
        if name == "Text" {
            let vc = R.storyboard.story.createStoryTextVC()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else if name == "Image" {
            self.cameraGallery()
            
        } else if name == "Video" {
            self.openVideoGallery()
            
        }
    }
}

// MARK: - IMAGE PICKER DELEGATE
extension StoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.delegate?.pickImage(image: image, videoData: nil, videoURL: nil, Status: true)
        }
        
        if let fileURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let videoData = try? Data(contentsOf: fileURL)
            //                print(videoData)
            self.delegate?.pickImage(image: nil, videoData: videoData, videoURL: fileURL, Status: false)
            self.dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - IMAGE PICKER DELEGATE
extension StoryViewController: ImagePickerDelegate {
    func pickImage(image: UIImage?, videoData: Data?, videoURL: URL?,Status: Bool?) {
        if Status!{
            let vc = R.storyboard.story.createStoryVC()
            vc?.status = Status ?? false
            vc!.pickedImage = image ?? nil
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = R.storyboard.story.createStoryVC()
            vc?.status = Status ?? false
            vc?.videoUrl = videoURL
            vc?.videoData = videoData
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

extension StoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.stories_TableCell.identifier) as? Stories_TableCell
        cell?.selectionStyle = .none
        
        let object = storiesArray[indexPath.row]
        cell?.usernameLabel.text = object.username ?? ""
        cell?.storyTextLabel.text = object.stories?.last?.timeText
        
        let url = URL.init(string:object.avatar ?? "")
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppInstance.instance.addCount = AppInstance.instance.addCount! + 1
        let vc = R.storyboard.story.contentVC()
        vc!.refreshStories = {
            //                                self.viewModel?.refreshStories.accept(true)
        }
        vc!.modalPresentationStyle = .overFullScreen
        vc!.pages = (self.storiesArray)
        vc!.currentIndex = indexPath.row
        self.present(vc!, animated: true, completion: nil)
        
        //                    let vc = R.storyboard.story.contentVC()
        //                    vc!.modalPresentationStyle = .overFullScreen
        //                    vc!.pages = self.storiesArray
        //                    vc!.currentIndex = indexPath.row
        //                    self.present(vc!, animated: true, completion: nil)
    }
}
