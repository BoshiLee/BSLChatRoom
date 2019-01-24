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
    
    fileprivate weak var presenter: BSLChatRoomPresentable!
    
    // MARK: - Properties
    fileprivate lazy var messages = [BSLMessage]()
    
    init(presenter: BSLChatRoomPresentable) {
        self.presenter = presenter
    }

    
    func appendMessage(_ newMessages: [BSLMessage], toSection section: Int) {
        var newIndices = [IndexPath]()
        for i in self.messages.endIndex ..< newMessages.count {
            newIndices.append(IndexPath(row: i, section: section))
        }
        self.messages = newMessages
        self.presenter.didAppendMessages(indeices: newIndices)
    }
    
}

// MARK: - Table view data source
extension BSLChatRoomViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVMs = self.messages.compactMap { BSLBubbleViewModel(message: $0, readTime: $0.timeStamp.toDateString(formate: .HHmm)) }
        let cell = cellVMs[indexPath.row].cellInstance(cell: BSLBubble.self, tableView: tableView, atIndexPath: indexPath)
        cell.configure(withViewModel: cellVMs[indexPath.row])
        return cell
    }


}
