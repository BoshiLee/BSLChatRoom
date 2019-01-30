//
//  BSLChatRoomInteractor.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/25.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import Foundation

class BSLChatRoomCoordinator {
    
    var senderId: String
    
    init(senderId: String) {
        self.senderId = senderId
    }
    
    fileprivate var groupMessages: [[BSLMessage]] = [] {
        didSet {
            groupMessages.sort { ($0[0].timeStamp) < ($1[0].timeStamp) }
        }
    }
    func appendNewMessages(_ messages: [BSLMessage]) -> [[BSLBubbleViewModel]] {
        self.groupingMessages(messages)
        
        return groupMessages.map { messages in
            return messages.map {
                BSLBubbleViewModel(message: $0, isOutGoing: $0.avatar.account == self.senderId)
            }
        }
    }
    
    func fetchIndexPaths(fromMessages: [BSLMessage]) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        
        return indexPaths
    }
    
    fileprivate func groupingMessages(_ messages: [BSLMessage]) {
        guard !messages.isEmpty else { return }
        for (_, message) in messages.enumerated() {
            self.append(message: message)
        }
    }
    
    
    fileprivate func append(message: BSLMessage) {
        for (i, currentGroup) in self.groupMessages.enumerated() where self.canAppend(currentGroup, newMessage: message) {
            groupMessages[i].append(message)
            return
        }
        groupMessages.append([message])
    }
    
    fileprivate func canAppend(_ currentGroup: [BSLMessage], newMessage: BSLMessage) -> Bool {
        if let firstTime = currentGroup.first?.timeStamp,
            newMessage.timeStamp.isDate(inSameDayAs: firstTime)
        {
            return true
        } else {
            return false
        }
    }
    
    func createHeader(atSection section: Int) -> BSLSectionViewModel? {
        guard self.groupMessages.indices.contains(section),
            let timeStamp = self.groupMessages[section].first?.timeStamp
        else { return nil }
        return BSLSectionViewModel(timeStamp: timeStamp)
    }
    
}
