//
//  WallpaperViewController.swift
//  WoWonder
//
//  Created by UnikApp on 12/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Combine

class WallpaperViewController: UIViewController {
    
    @IBOutlet weak var seletdImageVIew: UIImageView!
    @IBOutlet weak var imageGallery: UIControl!
    @IBOutlet weak var seletdColorView: UIView!
    @IBOutlet weak var saveButton: UIView!
    
    private let imagePickerController = UIImagePickerController()
    let picker = UIColorPickerViewController()
    var cancellable: AnyCancellable?
    var isColor = ""
    var isimage = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.saveButton.backgroundColor = UIColor.mainColor
        
        let UserDefa = UserDefaults.standard
        let colorWallpaper = UserDefa.value(forKey: "colorWallpaper")
        let imgWallpaper = UserDefa.value(forKey: "imgWallpaper")
                       
        if colorWallpaper != nil {
            self.seletdColorView.backgroundColor = UIColor.hexStringToUIColor(hex: colorWallpaper as! String)
        } else if imgWallpaper != nil {
            self.seletdImageVIew.backgroundColor = UIColor.clear
            self.seletdImageVIew.image = UIImage(data: imgWallpaper as! Data)
        } else {
            
        }
    }
    
    
    
    @IBAction func imageGalleryClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.isColor = ""
        self.imageGallery.isHidden = false
        self.seletdColorView.isHidden = true
        self.seletdColorView.backgroundColor = .clear
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func colorChangeView(_ sender: UIControl) {
        self.view.endEditing(true)
        self.isimage = Data()
        self.seletdImageVIew.isHidden = true
        self.seletdColorView.isHidden = false
        self.seletdImageVIew.image = UIImage(named: "")
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.seletdColorView.backgroundColor!
        
        //  Subscribing selectedColor property changes.
        self.cancellable = picker.publisher(for: \.selectedColor)
            .sink { color in
                
                //  Changing view color on main thread.
                DispatchQueue.main.async {
                    self.seletdColorView.backgroundColor = color
                    
                    print("color ==>\(color.toHexString())")
                    self.isColor = color.toHexString()
                }
            }
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func defaultButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func bacButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        let userSave = UserDefaults.standard
        if isColor == "" {
            userSave.setValue(isimage, forKey: "imgWallpaper")
            userSave.removeObject(forKey: "colorWallpaper")
        } else {
            userSave.setValue(isColor, forKey: "colorWallpaper")
            userSave.removeObject(forKey: "imgWallpaper")
        }
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UIImagePickerController & UINavigationController Delegate Method's
extension WallpaperViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageData = image.jpegData(compressionQuality: 0.1)
        self.seletdImageVIew.image = UIImage(data: imageData ?? Data())
        self.isimage = imageData ?? Data()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIColorPicker Delegate Method's
extension WallpaperViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.seletdColorView.backgroundColor = viewController.selectedColor
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.seletdColorView.backgroundColor = viewController.selectedColor
    }
}
