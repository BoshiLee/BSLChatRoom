//
//  BSLChatRoomLayout.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/29.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension BSLChatRoomViewController {
    
    func addAccessoryViews()  {
        self.tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .chatRoomBackgroundColor
        self.bslInputView = XibViewHelper<BSLInputView>.instantiateNib()
        self.bslInputView.delegate = self
        self.bslInputView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.bslInputView)
        self.layoutTableView()
        self.layoutInputView()
    }
    
    func layoutTableView() {
        let top: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            top = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        } else {
            top = self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor)
        }
        let leading = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tralling = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.tableViewBottom = self.tableView.bottomAnchor.constraint(equalTo: self.bslInputView.topAnchor)
        NSLayoutConstraint.activate([top, leading, tralling, self.tableViewBottom])
    }
    
    func layoutInputView() {
        self.inputViewHeight = self.bslInputView.heightAnchor.constraint(equalToConstant: 58.0)
        let leading = self.bslInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tralling = self.bslInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.setInputViewBottom()
        NSLayoutConstraint.activate([self.inputViewHeight, leading, tralling])
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

extension BSLChatRoomViewController {
    func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let keyboardSize = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey]) as AnyObject).cgRectValue {
            self.currentKeyboardHeight = keyboardSize.height
        }
        self.animatingInputView(userInfo: userInfo, isShowingKeyboard: true)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.currentKeyboardHeight = 0.0
        guard let userInfo = notification.userInfo else { return }
        self.animatingInputView(userInfo: userInfo, isShowingKeyboard: false)
    }
    
    func animatingInputView(userInfo: [AnyHashable : Any], isShowingKeyboard: Bool) {
        if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            self.kbShowingDuration = duration
        }
        if let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            self.kbShowingCurve = curve
        }
        
        let bottomPadding: CGFloat
        if #available(iOS 11.0, *) {
            bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        } else {
            bottomPadding = 0.0
        }
        let bottomConstant = isShowingKeyboard ? -self.currentKeyboardHeight + bottomPadding : 0
        UIView.animate(withDuration: self.kbShowingDuration, delay: 0.0, options: .init(rawValue: self.kbShowingCurve), animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.inputViewBottom.constant = bottomConstant
            if isShowingKeyboard {
                weakSelf.tableView.scrollToBottom(animated: true)
            }
            weakSelf.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    func setInputViewBottom() {
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            self.inputViewBottom = self.bslInputView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        } else {
            self.inputViewBottom = self.bslInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        }
        NSLayoutConstraint.activate([self.inputViewBottom])
    }
}
