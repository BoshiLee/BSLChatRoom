//
//  BSLBubbleConfigure.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

struct BSLBubbleConfigure {
    static var shouldShowSelfAvatar: Bool = false
    static var shouldShowOtherAvatar: Bool = true
    static var avatarImageWidth: CGFloat = 50.0
    static var userAvatar: BSLAvatar?
    static var selfMessageColor: UIColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
    static var otherMessageColor: UIColor = .white
}
