//
//  BSLChatRoomViewController.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/21.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLChatRoomViewController: UITableViewController {
    
    fileprivate lazy var viewModel = BSLChatRoomViewModel(presenter: self)
    
    let fakeUserA = BSLAvatar(account: "boshi", nickName: "lee")
    let fakeUserB = BSLAvatar(account: "ray", nickName: "Ray")
    
    var fakeMessage: [BSLMessage] {
        return [
            BSLMessage(avatar: fakeUserA, type: .message(content: "From these, it seems that calling just removeFromSuperview is enough to remove a subview and I've been using it like that without problems. I also confirmed the behavior by logging the count of the arrangedSubviews array when removeFromSuperview is called. A lot of tutorials and comments here on  however, say to call both. Is there a reason for this? Or do people just do it because the documentation says so?"), timeStamp: 1547804623000),
            BSLMessage(avatar: fakeUserB, type: .message(content: "/* Removes a subview from the list of arranged subviews without removing it as a subview of the receiver.To remove the view as a subview, send it -removeFromSuperview as usual; the relevant UIStackView will remove it from its arrangedSubviews list"), timeStamp: 1547458411000),
            BSLMessage(avatar: fakeUserA, type: .message(content: "213"), timeStamp: 1547448411000),
            BSLMessage(avatar: fakeUserB, type: .image(content: #imageLiteral(resourceName: "no-image.png")), timeStamp: 1547458514000),
            BSLMessage(avatar: fakeUserA, type: .image(content: #imageLiteral(resourceName: "no-image.png")), timeStamp: 1547393168000)
        ]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.tableView.reloadData()
        BSLBubbleConfigure.userAvatar = self.fakeUserA
        self.appendMessage(self.fakeMessage)
    }
    
    func appendMessage(_ messages: [BSLMessage]) {
        self.viewModel.appendMessage(messages, toSection: 0)
    }

}

extension BSLChatRoomViewController: BSLChatRoomPresentable {
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
