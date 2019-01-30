//
//  BSLBubbleLayout.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/24.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension BSLMessageBubble: BSLBubbleLayoutable {
    
}

// MARK: - Message Bubble Layout
extension BSLMessageBubble {
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

