//
//  PhotoPickerHelper.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/5/7.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit
protocol ImagePickerDelegates: AlertShowable {
    var imagePicker: ImagePicker { get set }
    func didChoosedImage(_ image: UIImage)
}

extension ImagePickerDelegates where Self: UIViewController {
    
    func presentEditPhotoActionSheet(title: String, allowsEditing: Bool = false) {
        let openPhotoLibary = UIAlertAction(title: "相簿", style: .default) { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.present(weakSelf.imagePicker.photoLibaryPicker(allowsEditing: allowsEditing), animated: true, completion: nil)
        }
        
        let openCamera = UIAlertAction(title: "相機", style: .default) { [weak self] _ in
            guard let weakSelf = self else { return }
            guard let camera = weakSelf.imagePicker.cameraPicker(allowsEditing: allowsEditing) else { return }
            weakSelf.present(camera, animated: true, completion: nil)
        }
        self.actionSheet(title, message: "請選擇一種方式來新增...", actions: [openPhotoLibary, openCamera])
    }
    
    func presentOpenPhotoLibraryActionSheet(allowsEditing: Bool = false) {
        let openPhotoLibary = UIAlertAction(title: "相簿", style: .default) { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.present(weakSelf.imagePicker.photoLibaryPicker(allowsEditing: allowsEditing), animated: true, completion: nil)
        }
        self.actionSheet("請選擇一張遊戲截圖", message: "", actions: [openPhotoLibary])
    }

}


final class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak private var delegate: ImagePickerDelegates!
    
    init(delegate: ImagePickerDelegates) {
        self.delegate = delegate
        super.init()
    }
    
    public func photoLibaryPicker(allowsEditing: Bool = false) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = allowsEditing
        picker.sourceType = .photoLibrary
        
        return picker
    }
    
    public func cameraPicker(allowsEditing: Bool = false) -> UIImagePickerController? {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return nil }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = allowsEditing
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        return picker
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage: UIImage
        if picker.allowsEditing {
            chosenImage = info[.editedImage] as! UIImage
        } else {
            chosenImage = info[.originalImage] as! UIImage
        }
        self.delegate.didChoosedImage(chosenImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
