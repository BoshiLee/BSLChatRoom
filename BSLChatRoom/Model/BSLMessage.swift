//
//  BSLMessage.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import Foundation

struct BSLMessage {
    let avatar: BSLAvatar
    let type: BSLBubbleType
    let timeStamp: Int64
    
    init(avatar: BSLAvatar, type: BSLBubbleType, timeStamp: Int64 = 0) {
        self.avatar = avatar
        self.type = type
        self.timeStamp = timeStamp
    }
}
