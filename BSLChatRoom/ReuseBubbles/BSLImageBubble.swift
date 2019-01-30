//
//  BSLImageBubble.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/30.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLImageBubble: UITableViewCell, BSLBubbleProtocol {
    
    var isOutGoing: Bool = false
    var bubbleImageView: WebImageView!
    var avatarView: BSLAvatarView?
    var timeLabel = UILabel()
    
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    func configure(withViewModel viewModel: BSLBubbleViewModel) {
        self.isOutGoing = viewModel.isOutGoing
        guard case .image(let content) = viewModel.type else { return }
        self.layoutAvatarView(imageURL: viewModel.avatar.imageURL)
        self.layoutImageBubble(content, timeString: viewModel.timeString)
    }
    
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
        self.bubbleImageView.configuration.placeholderImage = #imageLiteral(resourceName: "smile")
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
}

extension BSLImageBubble: BSLBubbleLayoutable {
    
    func layoutImageBubble(_ imageURL: URL, timeString: String) {
        self.bubbleImageView = WebImageView()
        bubbleImageView.image = #imageLiteral(resourceName: "smile")
        bubbleImageView.contentMode = .scaleAspectFill
        bubbleImageView.clipsToBounds = true
        bubbleImageView.layer.cornerRadius = 17.0
        self.addSubview(bubbleImageView)
        self.layoutTimeLable(timeString)
        var constraints = [NSLayoutConstraint]()
        let top = self.topConstraint(bubbleImageView, superView: self, paddingSpace: self.paddingSpace)
        let width = bubbleImageView.widthAnchor.constraint(equalToConstant: 120.0)
        let height = bubbleImageView.heightAnchor.constraint(equalToConstant: 160.0)
        let xAxis = self.contentXConstraint(bubbleImageView, superView: self, paddingSpace: self.paddingSpace)
        let bottom = bubbleImageView.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -self.paddingSpace)
        constraints.append(contentsOf: [top, width, bottom, height, xAxis])
        NSLayoutConstraint.activate(constraints)
    }
}
