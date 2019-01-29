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
                       BSLMessage(guid: UUID().uuidString, avatar: fakeUserA, type: .message(content: "とおくをつなぐもの」。このタイトルから、あなたはどんな情景をイメージしただろうか？インターネットや携帯電話をベースに見知らぬ 誰かと繋がるためのサービスが次々と生み出され、その消費速度も どんどん速まっている昨今。百景の音楽が感じさせてくれるのは、 ある種そういうものとは対極的なところにある“人肌の温かさ”の"), timeStamp: 1547804624000, isRead: true),
            BSLMessage(guid: UUID().uuidString, avatar: fakeUserA, type: .message(content: "ようなものだと思っている。"), timeStamp: 1547458411000, isRead: true),
                BSLMessage(guid: UUID().uuidString, avatar: fakeUserB, type: .message(content: "ジャム・バンドやポスト・ロック勢とも違い、3人が“うたう”ように楽器を奏でることで生まれる、独特の日本的な温かみをもった叙情性。"), timeStamp: 1547953411000, isRead: true),
                BSLMessage(guid: UUID().uuidString, avatar: fakeUserB, type: .message(content: "インストゥルメンタルのロック・バンドは多くあれど、そういったものを醸し出すことのできるのは彼らだけだ。"), timeStamp: 1547153411000, isRead: true)
            
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
