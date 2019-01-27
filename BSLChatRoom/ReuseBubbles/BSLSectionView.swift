//
//  BSLSectionView.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/26.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

class BSLSectionView: UITableViewHeaderFooterView {
    var containerView: UIView!
    var titleLabel: UILabel!
    var leftLine: UIView!
    var rightLine: UIView!
    let paddingSpace: CGFloat = 16.0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubViews()
        self.layoutContainerView()
        self.layoutTitleLabel()
        self.layoutleftLine()
        self.layoutRightLine()
    }
    
    func addSubViews() {
        self.containerView = UIView()
        self.leftLine = UIView()
        self.rightLine = UIView()
        self.titleLabel = UILabel()
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.leftLine)
        self.containerView.addSubview(self.rightLine)
        self.containerView.addSubview(self.titleLabel)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.leftLine.translatesAutoresizingMaskIntoConstraints = false
        self.rightLine.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutTitleLabel() {
        titleLabel.textColor = .sectionTextColor
        titleLabel.font = .systemFont(ofSize: 11.0, weight: .medium)
        titleLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
    }
    
    func layoutRightLine() {
        self.rightLine.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        self.rightLine.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        self.rightLine.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.rightLine.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10.0).isActive = true
        self.rightLine.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.paddingSpace).isActive = true
    }
    
    func layoutleftLine() {
        self.leftLine.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        self.leftLine.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        self.leftLine.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.leftLine.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.paddingSpace).isActive = true
        self.leftLine.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -10.0).isActive = true
    }
    
    func layoutContainerView() {
        self.containerView.backgroundColor = .chatRoomBackgroundColor
        self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: BSLSectionViewModel) {
        self.titleLabel.text = viewModel.timeString
    }
}
