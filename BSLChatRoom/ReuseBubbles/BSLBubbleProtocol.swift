//
//  BSLBubbleProtocol.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLBubbleProtocol where Self: UITableViewCell {
    var isSentByMe: Bool { get set }
    func configure(withViewModel viewModel: BSLBubbleViewModel)
}

protocol BSLBubbleLayoutable {
    func xAxisContraint() -> NSLayoutConstraint
}

extension BSLBubbleLayoutable where Self: BSLBubbleProtocol {


}
