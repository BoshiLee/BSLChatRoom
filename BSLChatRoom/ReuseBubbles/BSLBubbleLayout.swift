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
        guard (isOutGoing && BSLBubbleConfigure.shouldShowSelfAvatar) || (!isOutGoing && BSLBubbleConfigure.shouldShowOtherAvatar) else { return }
        self.avatarView = XibViewHelper<BSLAvatarView>.instantiateNib()
        self.avatarView?.imageView.image = avatarImage
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
    
    func contentXConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        if self.isOutGoing {
            return content.trailingAnchor.constraint(equalTo: self.avatarView != nil ?  self.avatarView!.leadingAnchor : superView.trailingAnchor, constant: -paddingSpace)
            
        } else {
            return content.leadingAnchor.constraint(equalTo: self.avatarView != nil ?self.avatarView!.trailingAnchor : superView.leadingAnchor, constant: paddingSpace)
        }
    }
    
}

// MARK: - Message Bubble Layout
extension BSLBubble {
    func layoutMessageLable(_ message:String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = message
        label.textColor = self.isOutGoing ? .outGoingTextColor : .inCommingTextColor
        self.addSubview(label)
        var constraints = [NSLayoutConstraint]()
        let top = self.topConstraint(label, superView: self, paddingSpace: 2*self.paddingSpace)
        let bottom = label.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -2*self.paddingSpace)
        let labelWidth = label.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.6)
        let xAxis = self.contentXConstraint(label, superView: self, paddingSpace: 3*self.paddingSpace)
        constraints.append(contentsOf: [top, bottom, labelWidth, xAxis])
        NSLayoutConstraint.activate(constraints)
        return label
    }
    
    func layoutMessageBubble(_ message: String, timeString: String) {
        let bubble = self.isOutGoing ? UIView() : RoundShadowView()
        self.addSubview(bubble)
        bubble.layer.cornerRadius = 17
        
        self.layoutTimeLable(timeString)
        self.layoutBubbleTail(bubbleView: bubble)
        let label = self.layoutMessageLable(message)
        var constraints = [NSLayoutConstraint]()
        bubble.backgroundColor = self.isOutGoing ? .outGoingBubbleColor : .inCommingBubbleColor
        let top = self.topConstraint(bubble, superView: label, paddingSpace: -paddingSpace)
        let bottom = bubble.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: self.paddingSpace)
        let tralling = bubble.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 2*paddingSpace)
        let leading = bubble.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -2*paddingSpace)
        constraints.append(contentsOf: [top, bottom, tralling, leading])
        NSLayoutConstraint.activate(constraints)
    }
    
    func layoutBubbleTail(bubbleView: UIView) {
        let tailView = UIImageView(image: self.isOutGoing ? #imageLiteral(resourceName: "outGoingBubbleTail") : #imageLiteral(resourceName: "inCommingBubbleTailS"))
        self.addSubview(tailView)
        tailView.translatesAutoresizingMaskIntoConstraints = false
        let bottom = tailView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor)
        let xAnchor = self.isOutGoing ?
            tailView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor) :
            tailView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor)
        NSLayoutConstraint.activate([bottom, xAnchor])
    }
}

// MARK: - Image Bubble Layout
extension BSLBubble {
    func layoutImageBubble(_ image: UIImage, timeString: String) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17.0
        self.addSubview(imageView)
        self.layoutTimeLable(timeString)
        var constraints = [NSLayoutConstraint]()
        let top = self.topConstraint(imageView, superView: self, paddingSpace: self.paddingSpace)
        let width = imageView.widthAnchor.constraint(equalToConstant: 120.0)
        let height = imageView.heightAnchor.constraint(equalToConstant: 160.0)
        let xAxis = self.contentXConstraint(imageView, superView: self, paddingSpace: self.paddingSpace)
        let bottom = imageView.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -self.paddingSpace)
        constraints.append(contentsOf: [top, width, bottom, height, xAxis])
        NSLayoutConstraint.activate(constraints)
    }

}

// MARK: - Genric Constraints
extension BSLBubble {
    
    func topConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        content.translatesAutoresizingMaskIntoConstraints = false
        return content.topAnchor.constraint(equalTo: superView.topAnchor, constant: paddingSpace)
    }
    
    func bottomConstraint(_ content: UIView, superView: UIView, paddingSpace: CGFloat) -> NSLayoutConstraint {
        return content.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -paddingSpace)
    }

}
