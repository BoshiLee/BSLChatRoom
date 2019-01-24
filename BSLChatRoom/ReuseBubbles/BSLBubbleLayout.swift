//
//  BSLBubbleLayout.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/24.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension BSLBubble {
    
    func layoutAvatarView(avatarImage: UIImage) {
        guard (isSentByMe && BSLBubbleConfigure.shouldShowSelfAvatar) || (!isSentByMe && BSLBubbleConfigure.shouldShowOtherAvatar) else { return }
        self.avatarView = XibViewHelper<BSLAvatarView>.instantiateNib()
        self.avatarView?.imageView.image = avatarImage
        self.addSubview(avatarView!)
        self.avatarView?.translatesAutoresizingMaskIntoConstraints = false
        let top = self.avatarView!.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingSpace)
        let xAxis = isSentByMe ?
            self.avatarView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.paddingSpace / 2) :
            self.avatarView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.paddingSpace / 2)
        let width = self.avatarView!.widthAnchor.constraint(equalToConstant: BSLBubbleConfigure.avatarImageWidth)
        let height = self.avatarView!.heightAnchor.constraint(equalToConstant: BSLBubbleConfigure.avatarImageWidth)
        NSLayoutConstraint.activate([top, xAxis, width, height])
    }
    
    func handleBubbleLayout(type: BSLBubbleType, avatar: BSLAvatar) {
        self.layoutAvatarView(avatarImage: avatar.image)
        switch type {
        case .message(let content):
            self.layoutMessageBubble(content)
        case .image(let content):
            self.handleImageLayout(content)
        }
    }
    
    func layoutMessageLable(_ message:String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = message
        self.addSubview(label)
        var padding = self.isSentByMe ? 2*self.paddingSpace : self.paddingSpace
        var constraints = self.contentYConstraint(label, superView: self, paddingSpace: padding)
        let labelWidth = label.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.6)
        padding = padding + (self.avatarView != nil ? 16 : 0)
        let xAxis = self.contentXConstraint(label, superView: self, paddingSpace: padding)
        constraints.append(contentsOf: [labelWidth, xAxis])
        NSLayoutConstraint.activate(constraints)
        return label
    }
    
    func layoutMessageBubble(_ message: String) {
        let bubble = UIView()
        self.addSubview(bubble)
        bubble.layer.cornerRadius = 10
        let label = self.layoutMessageLable(message)
        bubble.backgroundColor = self.isSentByMe ? BSLBubbleConfigure.selfMessageColor : BSLBubbleConfigure.otherMessageColor
        
        var constraints = self.contentYConstraint(bubble, superView: label, paddingSpace: -paddingSpace)
        let tralling = bubble.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: paddingSpace)
        let leading = bubble.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -paddingSpace)
        constraints.append(contentsOf: [tralling, leading])
        NSLayoutConstraint.activate(constraints)
    }
    
    func handleImageLayout(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        self.addSubview(imageView)
        var constraints = self.contentYConstraint(imageView, superView: self, paddingSpace: self.paddingSpace)
        let width = imageView.widthAnchor.constraint(equalToConstant: 120.0)
        let height = imageView.heightAnchor.constraint(equalToConstant: 160.0)
        let xAxis = self.contentXConstraint(imageView, superView: self, paddingSpace: self.paddingSpace)
        constraints.append(contentsOf: [width, height, xAxis])
        NSLayoutConstraint.activate(constraints)
    }
    
    func contentXConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        if self.isSentByMe {
            return content.trailingAnchor.constraint(equalTo: self.avatarView != nil ?  self.avatarView!.leadingAnchor : superView.trailingAnchor, constant: -paddingSpace)
            
        } else {
            return content.leadingAnchor.constraint(equalTo: self.avatarView != nil ?self.avatarView!.trailingAnchor : superView.leadingAnchor, constant: paddingSpace)
        }
    }
    
    func contentYConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> [NSLayoutConstraint] {
        content.translatesAutoresizingMaskIntoConstraints = false
        let top = content.topAnchor.constraint(equalTo: superView.topAnchor, constant: paddingSpace)
        let bottom = content.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -paddingSpace)
        return [top, bottom]
    }


}
