//
//  BSLMessageCell.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLBubble: UITableViewCell, BSLBubbleProtocol {
    
    var isSentByMe: Bool = false
    
    var avatarView: BSLAvatarView?
    var paddingSpace: CGFloat = 16.0
    
    // MARK: - Cell initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        self.avatarView = nil
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
        
    func configure(withViewModel viewModel: BSLBubbleViewModel) {
        self.isSentByMe = viewModel.isSentByMe
        self.handleBubbleLayout(type: viewModel.type, avatar: viewModel.avatar)
        
    }
    
        
}
