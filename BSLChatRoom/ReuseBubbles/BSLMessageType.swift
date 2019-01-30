//
//  BSLBubbleType.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

enum BSLMessageType: Equatable {
    case message(content: String)
    case image(content: URL)
}

enum BSLOutGoingMessageType: Equatable {
    case message(content: String)
    case image(content: UIImage)
}
