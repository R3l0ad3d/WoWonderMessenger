//
//  MediaViewController.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 29/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AVKit

class MediaViewController: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var player = AVPlayer()
    var messageArray: [MessageModel] = []
    var media: [MessageMedia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for index in 0..<messageArray.count {
            let obj = messageArray[index]
            
            if obj.media != "" {
                let Varmedia = MessageMedia(media: obj.media, type: obj.type)
                self.media.append(Varmedia)
                self.collectionView.reloadData()
            } else {
            }
        }
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
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

extension MediaViewController {
    
    func setupView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(MediaCollectionViewCell.self)
    }
}

// MARK: - ACTIONS

extension MediaViewController {
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - COLLECTION VIEW DELEGATE

extension MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MediaCollectionViewCell.self, for: indexPath)
        let object = self.media[indexPath.row]
        
//        cell.object = object
                
        let url = URL(string: object.media ?? "")
        let extenion =  url?.pathExtension
        if (extenion == "jpg") || (extenion == "png") || (extenion == "JPG") || (extenion == "PNG"){
            cell.mediaImageView.isHidden = false
            cell.mediaImageView.kf.indicatorType = .activity
            cell.mediaImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
            cell.viewImage.isHidden = true
            cell.imageName.isHidden = true
            
        } else if (extenion == "pdf") {
            cell.viewImage.isHidden = false
            cell.imageName.isHidden = false
            cell.imageName.isHidden = false
            cell.imageName.image = UIImage(named: "ic_media_Doc")
            
        } else if (extenion == "mp4"){
            let videoURL = URL(string: object.media ?? "")
            if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
                cell.mediaImageView.image = thumbnailImage
                cell.viewImage.isHidden = false
                cell.imageName.isHidden = false
                cell.imageName.image = UIImage(named: "ic_media_play")
            }
            let playerController = AVPlayerViewController()
            player.pause()
            
        } else if extenion == "wav" {
            cell.viewImage.isHidden = false
            cell.imageName.isHidden = false
            cell.imageName.image = UIImage(named: "ic_audio_media")
            
        } else {}

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let object = self.media[indexPath.row]
            self.handleMediaClick(with: object, indexpathForCell: indexPath)
        }        
    }
    
    private func handleMediaClick(with object: MessageMedia, indexpathForCell: IndexPath) {
        guard let type = object.type else { return }
        switch type {
        case "left_audio", "right_adioes":
            self.clickAudio(indexpathForCell: indexpathForCell)
            
        case "left_video", "right_video":
            self.clickVidowButton(indexpathForCell: indexpathForCell)
            
        case "left_image", "right_image":
            self.handleImageClick(indexpathForCell: indexpathForCell)
            
        case "left_file", "right_file":
            self.clickFile(indexpathForCell: indexpathForCell)
            
        default:
            break
        }
    }
    
    private func handleImageClick(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
        vc.imageURL = object.media ?? ""
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - clickVidowButton
    func clickVidowButton(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        let player = AVPlayer(url: URL(string: object.media ?? "")!)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK: - clickFile
    @objc func clickFile(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        if let url = URL(string: object.media ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: - clickFile
    @objc func clickAudio(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        if let url = URL(string: object.media ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsInRow: CGFloat = 3
        let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let leftRightPadding: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let spaceBetweenCells: CGFloat = flowLayout.minimumInteritemSpacing * cellsInRow
        
        let cellWidth = (collectionView.width - leftRightPadding - spaceBetweenCells) / cellsInRow
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

// MARK: - CUSTOM FUNCTIONS

extension MediaViewController {
    
}
