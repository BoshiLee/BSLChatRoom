//
//  BSLChatRoomViewModel.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLChatRoomPresentable: AnyObject {
    func didAppendMessages(indeices: [IndexPath])
}

class BSLChatRoomViewModel: NSObject {
    
    // MARK: - Properties
    fileprivate weak var presenter: BSLChatRoomPresentable!
    fileprivate var coordinator: BSLChatRoomCoordinator?
    fileprivate lazy var bubbleVMs = [[BSLBubbleViewModel]]()
    var sender: BSLAvatar?
    
    // MARK: - initial
    init(presenter: BSLChatRoomPresentable) {
        self.presenter = presenter
    }

    
    func appendMessage(_ newMessages: [BSLMessage]) {
        guard self.coordinator != nil else {
            fatalError("ChatRoom Sender is nil, please give it value befor append new message.")
        }
        self.bubbleVMs = self.coordinator!.appendNewMessages(newMessages)
    }
    
    
    func setSender(_ sender: BSLAvatar) {
        self.sender = sender
        self.coordinator = BSLChatRoomCoordinator(senderId: sender.account)
    }
}

// MARK: - Table view data source
extension BSLChatRoomViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 18.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let vm = self.coordinator?.createHeader(atSection: section) else { return nil }
        let sectionView = vm.sectionInstance(headerFooter: BSLSectionView.self, tableView: tableView)
        sectionView.configure(with: vm)
        return sectionView
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.bubbleVMs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bubbleVMs[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bubbleVM = self.bubbleVMs[indexPath.section][indexPath.row]
        let cell = bubbleVM.cellInstance(tableView: tableView, atIndexPath: indexPath)
        cell.configure(withViewModel: bubbleVM)
        return cell as! UITableViewCell
    }


}
