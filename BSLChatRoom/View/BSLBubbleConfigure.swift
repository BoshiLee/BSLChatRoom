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
    static var avatarImageWidth: CGFloat = 32.0
    static var userAvatar: BSLAvatar?
}

extension UIColor {
    static var outGoingBubbleColor: UIColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
    static var outGoingTextColor: UIColor = .white
    static var inCommingBubbleColor: UIColor = .white
    static var inCommingTextColor: UIColor = #colorLiteral(red: 0.1019607843, green: 0.1254901961, blue: 0.1568627451, alpha: 1)
    static var sectionTextColor: UIColor = #colorLiteral(red: 0.2549019608, green: 0.3098039216, blue: 0.3803921569, alpha: 1)
    static var chatRoomBackgroundColor: UIColor = UIColor(white: 1.0, alpha: 1)
}
