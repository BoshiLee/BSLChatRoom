//
//  AlertHepler.swift
//  Bump
//
//  Created by Boshi Li on 29/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

// MARK: - 需要Alert的VC，遵從此Protocol
protocol AlertShowable: AnyObject { }

extension AlertShowable where Self: UIViewController {
    
    func creatAleartAction(title: String, style: UIAlertAction.Style, actionHandler: (()->())?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: { (_) in
            actionHandler?()
        })
    }
    
    func alert(title: String?, message: String, style: UIAlertController.Style, actions: UIAlertAction?...) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions where action != nil {
            alertController.addAction(action!)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func confirmAlert(title: String?, message: String, handler: (() -> Void)?) {
        let action = UIAlertAction(title: "確定", style: .default) { (_) in
            handler?()
        }
        self.alert(title: title, message: message, style: .alert, actions: action)
    }
        
    func showAlertWithTextField(title: String, message: String, actionATitle: String, actionAHandler: ((_ input: String)->())?, actionBTitle: String, placeHolder: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var inputText = ""
        var alertTextField = UITextField()
        
        let actionA = UIAlertAction(title: actionATitle, style: .default, handler: {
            action in
            
            inputText = alertTextField.text!
            
            if let actionAHandler = actionAHandler { actionAHandler(inputText) }
        })
        
        let actionB = UIAlertAction(title: actionBTitle, style: .default, handler: nil)
        
        alertController.addTextField()
        alertController.addAction(actionB)
        alertController.addAction(actionA)
        
        present(alertController, animated: true, completion: nil)
        
        if let textField = alertController.textFields?.first{
            
            alertTextField = textField
            alertTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.gray])
        }
    }
    
    func openSetting(_ title: String?, message: String) {
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "設定", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func actionSheet(_ title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        let cancelAction = UIAlertAction(title: "返回", style: .cancel, handler: { _ in
            //
        })
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


