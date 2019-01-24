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
    var paddingSpace: CGFloat = 8.0
    lazy var timeLabel = UILabel()
    
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
        self.handleBubbleLayout(type: viewModel.type, avatar: viewModel.avatar, timeString: viewModel.timeString)
        
    }
    
    func handleBubbleLayout(type: BSLBubbleType, avatar: BSLAvatar, timeString: String) {
        self.layoutAvatarView(avatarImage: avatar.image)
        switch type {
        case .message(let content):
            self.layoutMessageBubble(content, timeString: timeString)
        case .image(let content):
            self.layoutImageBubble(content, timeString: timeString)
        }
    }
        
}
