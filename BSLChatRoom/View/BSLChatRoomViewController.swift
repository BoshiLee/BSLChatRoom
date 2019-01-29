//
//  BSLChatRoomViewController.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/21.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLChatRoomViewController: UIViewController {
    
    var tableView: UITableView!
    var bslInputView: BSLInputView!
    let originalInputViewHeight: CGFloat = 58.0
    var inputViewHeight: NSLayoutConstraint!
    var inputViewBottom: NSLayoutConstraint!
    
    fileprivate lazy var viewModel = BSLChatRoomViewModel(presenter: self)
    
    let fakeUserA = BSLAvatar(account: "boshi", nickName: "lee")
    let fakeUserB = BSLAvatar(account: "ray", nickName: "Ray")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.initInputView()
        self.initTableView()
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        BSLBubbleConfigure.userAvatar = self.fakeUserA
        let message = [BSLMessage(guid: UUID().uuidString, avatar: fakeUserA, type: .message(content: "A"), timeStamp: 1547804623000, isRead: true),
            BSLMessage(guid: UUID().uuidString, avatar: fakeUserA, type: .message(content: "B"), timeStamp: 1547804624000, isRead: true),
            BSLMessage(guid: UUID().uuidString, avatar: fakeUserA, type: .message(content: "F"), timeStamp: 1547458411000, isRead: true),
            BSLMessage(guid: UUID().uuidString, avatar: fakeUserB, type: .message(content: "C"), timeStamp: 1547953411000, isRead: true),
            BSLMessage(guid: UUID().uuidString, avatar: fakeUserB, type: .message(content: "D"), timeStamp: 1547153411000, isRead: true)
            
        ]
        self.viewModel.appendMessage(message)
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
