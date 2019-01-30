//
//  BSLMessageCell.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLMessageBubble: UITableViewCell, BSLBubbleProtocol {
    
    var isOutGoing: Bool = false
    
    var avatarView: BSLAvatarView?
    
    var timeLabel = UILabel()
    
    // MARK: - Cell initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initailAvatarView() {
        self.avatarView = XibViewHelper<BSLAvatarView>.instantiateNib()
    }
        
    override func prepareForReuse() {
        self.avatarView = nil
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(withViewModel viewModel: BSLBubbleViewModel) {
        self.isOutGoing = viewModel.isOutGoing
        guard case .message(let content) = viewModel.type else { return }
        self.layoutAvatarView(imageURL: viewModel.avatar.imageURL)
        self.layoutMessageBubble(content, timeString: viewModel.timeString)
    }
    
}
