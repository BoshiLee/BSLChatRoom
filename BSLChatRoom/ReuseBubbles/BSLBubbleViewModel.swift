//
//  BSLBubbleViewModel.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLBubbleViewModel: TableCellViewModelProtocol {
    
    let avatar: BSLAvatar
    var isOutGoing: Bool = false
    let type: BSLMessageType
    var timeString: String
    
    init(message: BSLMessage, isOutGoing: Bool) {
        self.avatar = message.avatar
        self.type = message.type
        self.timeString = message.timeStamp.toDateString(formate: .HHmm)
        self.isOutGoing = isOutGoing
        if isOutGoing {
            self.timeString = self.timeString + (message.isRead ? "已讀" : "")
        }
    }
    
    func cellInstance(tableView: UITableView, atIndexPath indexPath: IndexPath) -> BSLBubbleProtocol {
        let cell: BSLBubbleProtocol
        switch self.type {
        case .message:
            tableView.register(BSLMessageBubble.self)
            cell = tableView.dequeue(BSLMessageBubble.self, indexPath: indexPath)
        case .image:
            tableView.register(BSLImageBubble.self)
            cell = tableView.dequeue(BSLImageBubble.self, indexPath: indexPath)
        }
        return cell
    }
}
