//
//  BSLAvatarView.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLAvatarView: BaseXibView {

    var placeHolderImage: UIImage = #imageLiteral(resourceName: "avatarDefault")
    
    @IBOutlet weak var imageView: WebImageView! {
        didSet {
            imageView.configuration.placeholderImage = self.placeHolderImage
        }
    }
        
}
