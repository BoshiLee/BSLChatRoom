//
//  BSLChatRoomViewController.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/21.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLChatRoomViewController: UIViewController {
    
    weak var chatRoomDelegate: BSLChatRoomDelegate!
    
    lazy var imagePicker: ImagePicker = ImagePicker(delegate: self)
    
    var tableView: UITableView!
    var bslInputView: BSLInputView!
    var inputViewHeight: NSLayoutConstraint!
    var inputViewBottom: NSLayoutConstraint!
    var tableViewBottom: NSLayoutConstraint!
    
    // MARK: - Keyboard Shows properties
    lazy var currentKeyboardHeight: CGFloat = 0.0
    lazy var kbShowingDuration: Double = 0.0
    lazy var kbShowingCurve: UInt = 0
    
    fileprivate lazy var viewModel = BSLChatRoomViewModel(presenter: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.addKeyBoardObserver()
        self.addAccessoryViews()
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.tableView.reloadData()
    }
    
    func setSender(_ sender: BSLAvatar) {
        self.viewModel.setSender(sender)
    }
}

extension BSLChatRoomViewController: BSLChatRoomPresentable {
    func hideKeyboard() {
        self.dismissKeyboard()
    }
    
    func didAppendMessages(indeices: [IndexPath]) {
        if #available(iOS 11.0, *) {
            self.tableView.performBatchUpdates({ [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.tableView.insertRows(at: indeices, with: .automatic)
                }, completion: nil)
        } else {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indeices, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
}

extension BSLChatRoomViewController: BSLInputViewDelegate, ImagePickerDelegates {
    
    func didChoosedImage(_ image: UIImage) {
        guard let sender = self.chatRoomDelegate.sender else { return }
        self.chatRoomDelegate.didPressSend(withContent: .image(content: image), senderAccount: sender.account)
    }
    
    
    func didTapAddPhotoButton() {
        self.presentEditPhotoActionSheet(title: "傳送照片")
    }
    
    func didTapSendMessageButton(_ message: String) {
        guard let sender = self.chatRoomDelegate.sender else { return }
        self.chatRoomDelegate.didPressSend(withContent: .message(content: message), senderAccount: sender.account)
    }
    
    
}
