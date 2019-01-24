//
//  BaseXibView.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/23.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

open class BaseXibView: UIView {
    
    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    // MARK: - Visualize xib in storyboard
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}
