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
    let timeString: String
    
    init(message: BSLMessage, readTime: String) {
        self.avatar = message.avatar
        self.type = message.type
        self.timeString = readTime
        self.isSentByMe = self.isUserSentsThisMessage(message: message)
    }
    
    fileprivate func isUserSentsThisMessage(message: BSLMessage) -> Bool {
        guard let userAvatar = BSLBubbleConfigure.userAvatar else { return false }
        return message.avatar == userAvatar
    }
}
