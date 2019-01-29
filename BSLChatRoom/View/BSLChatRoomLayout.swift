//
//  BSLChatRoomLayout.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/29.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension BSLChatRoomViewController {
    
    func initTableView() {
        self.tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .chatRoomBackgroundColor
        let top: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            top = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        } else {
            top = self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor)
        }
        let leading = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tralling = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottom = self.tableView.bottomAnchor.constraint(equalTo: self.bslInputView.topAnchor)
        NSLayoutConstraint.activate([top, leading, tralling, bottom])
    }
    
    func initInputView() {
        self.bslInputView = XibViewHelper<BSLInputView>.instantiateNib()
        self.bslInputView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.bslInputView)
        self.inputViewHeight = self.bslInputView.heightAnchor.constraint(equalToConstant: self.originalInputViewHeight)
        let leading = self.bslInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tralling = self.bslInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            self.inputViewBottom = self.bslInputView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        } else {
            self.inputViewBottom = self.bslInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        }
        NSLayoutConstraint.activate([self.inputViewHeight, leading, tralling, self.inputViewBottom])
    }
}

extension BSLChatRoomViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.addTapGestureRecognizer(action: {
            self.dismissKeyboard()
        })
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
