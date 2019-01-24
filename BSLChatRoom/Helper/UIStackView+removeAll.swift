//
//  UIStackView+removeAll.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/23.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import Foundation

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func removeLastArrangeSubview() {
        guard self.arrangedSubviews.count > 0 else { return }
        let lastView = self.arrangedSubviews[self.arrangedSubviews.endIndex]
        self.removeArrangedSubview(lastView)
    }
    
}
