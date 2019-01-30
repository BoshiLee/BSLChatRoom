//
//  RoundShadowView.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/29.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 17.0
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 5
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
