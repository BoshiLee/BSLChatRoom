//
//  BSLBubbleLayoutable.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/30.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLBubbleLayoutable {
    var avatarView: BSLAvatarView? { get set }
    var timeLabel: UILabel { get set }
    func initailAvatarView()
}

extension BSLBubbleLayoutable where Self: BSLBubbleProtocol {
    
    var paddingSpace: CGFloat { return 8.0 }
    
    var shouldShowAvatarView: Bool {
        return (isOutGoing && BSLBubbleConfigure.shouldShowSelfAvatar) || (!isOutGoing && BSLBubbleConfigure.shouldShowOtherAvatar)
    }
    
    func topConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        content.translatesAutoresizingMaskIntoConstraints = false
        return content.topAnchor.constraint(equalTo: superView.topAnchor, constant: paddingSpace)
    }
    
    func bottomConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        return content.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -paddingSpace)
    }
    
    func contentXConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        if self.isOutGoing {
            return content.trailingAnchor.constraint(equalTo: self.avatarView != nil ?  self.avatarView!.leadingAnchor : superView.trailingAnchor, constant: -paddingSpace)
            
        } else {
            return content.leadingAnchor.constraint(equalTo: self.avatarView != nil ?self.avatarView!.trailingAnchor : superView.leadingAnchor, constant: paddingSpace)
        }
    }
    
    func layoutAvatarView(imageURL: URL) {
        guard self.shouldShowAvatarView else { return }
        self.initailAvatarView()
        self.avatarView?.imageView.load(url: imageURL)
        self.addSubview(avatarView!)
        self.avatarView?.translatesAutoresizingMaskIntoConstraints = false
        let top = self.avatarView!.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingSpace)
        let xAxis = isOutGoing ?
            self.avatarView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.paddingSpace / 2) :
            self.avatarView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.paddingSpace / 2)
        let width = self.avatarView!.widthAnchor.constraint(equalToConstant: BSLBubbleConfigure.avatarImageWidth)
        let height = self.avatarView!.heightAnchor.constraint(equalToConstant: BSLBubbleConfigure.avatarImageWidth)
        self.avatarView?.layer.cornerRadius = BSLBubbleConfigure.avatarImageWidth / 2
        self.avatarView?.imageView.layer.cornerRadius = BSLBubbleConfigure.avatarImageWidth * 0.9 / 2
        self.avatarView?.imageView.clipsToBounds = true
        NSLayoutConstraint.activate([top, xAxis, width, height])
    }
    
    func layoutTimeLable(_ timeString: String){
        self.addSubview(timeLabel)
        self.timeLabel.text = timeString
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.numberOfLines = 1
        self.timeLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.timeLabel.textColor = .lightGray
        let xConstraint = self.contentXConstraint(self.timeLabel, superView: self, paddingSpace: self.paddingSpace)
        let bottom = self.bottomConstraint(self.timeLabel, superView: self, paddingSpace: self.paddingSpace)
        NSLayoutConstraint.activate([xConstraint, bottom])
    }
    
}
