//
//  BSLBubbleViewModel.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import Foundation

class BSLBubbleViewModel: TableCellViewModelProtocol {
    
    let avatar: BSLAvatar
    var isSentByMe: Bool = false
    let type: BSLBubbleType
    var timeString: String
    
    init(message: BSLMessage) {
        self.avatar = message.avatar
        self.type = message.type
        self.timeString = message.timeStamp.toDateString(formate: .HHmm)
        self.isSentByMe = self.isUserSentsThisMessage(message: message)
        if isSentByMe {
            self.timeString = self.timeString + (message.isRead ? "已讀" : "")
        }
    }
    
    fileprivate func isUserSentsThisMessage(message: BSLMessage) -> Bool {
        guard let userAvatar = BSLBubbleConfigure.userAvatar else { return false }
        return message.avatar == userAvatar
    }
}
