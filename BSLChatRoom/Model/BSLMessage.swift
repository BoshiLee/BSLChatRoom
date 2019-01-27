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
    var isRead: Bool
    let guid: String
    
    init(guid: String, avatar: BSLAvatar, type: BSLBubbleType, timeStamp: Int64, isRead: Bool) {
        self.guid = guid
        self.avatar = avatar
        self.type = type
        self.isRead = isRead
        self.timeStamp = timeStamp
    }
}

extension BSLMessage: Equatable {
    
    static func == (lhs: BSLMessage, rhs: BSLMessage) -> Bool {
        return lhs.avatar == rhs.avatar && lhs.type == rhs.type && lhs.timeStamp == rhs.timeStamp
    }
}
