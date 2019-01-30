//
//  BSLChatRoomDelegate.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/30.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLChatRoomDelegate: AnyObject {
    var sender: BSLAvatar? { get set }
    func didPressSend(withContent contentType: BSLOutGoingMessageType, senderAccount: String)
    
}
