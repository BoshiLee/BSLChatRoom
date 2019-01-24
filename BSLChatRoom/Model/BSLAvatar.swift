//
//  BSLAvatar.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

struct BSLAvatar: Equatable {
    let image: UIImage
    let account: String
    let nickName: String
    
    init(image: UIImage = #imageLiteral(resourceName: "avatarDefault"), account: String, nickName: String) {
        self.image = image
        self.account = account
        self.nickName = nickName
    }
}

extension BSLAvatar {
    
    public static func == (lhs: BSLAvatar, rhs: BSLAvatar) -> Bool {
        return lhs.account == rhs.account && lhs.nickName == rhs.nickName
    }
}
