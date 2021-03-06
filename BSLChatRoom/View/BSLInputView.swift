//
//  BSLInputView.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/27.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLInputViewDelegate: AnyObject {
    func didTapAddPhotoButton()
    func didTapSendMessageButton(_ message: String)
}

class BSLInputView: BaseXibView {
    
    weak var delegate: BSLInputViewDelegate?
    
    @IBOutlet weak var sendMesaageButton: UIButton!
    
    @IBOutlet weak var messageBox: UIView! {
        didSet {
            self.messageBox.layer.cornerRadius = 21.0
            self.messageBox.layer.borderWidth = 1.0
            self.messageBox.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 0.1497555598)

        }
    }
    @IBOutlet weak var messageTextView: UITextView!
    
}

extension BSLInputView {
    
    @IBAction func addPhoto(_ sender: UIButton) {
        self.delegate?.didTapAddPhotoButton()
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        self.delegate?.didTapSendMessageButton(self.messageTextView.text)
    }
}
