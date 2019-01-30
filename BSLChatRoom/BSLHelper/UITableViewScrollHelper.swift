//
//  UITableViewIndexPathHelper.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/29.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension UITableView {
    
    var lastSection: Int {
        return numberOfSections - 1 > 0 ? numberOfSections - 1 : 0
    }
    
    func lastRow(inSection section: Int) -> Int {
        return numberOfRows(inSection: section) - 1 > 0 ? numberOfRows(inSection: lastSection) - 1 : 0
    }
    
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.scrollToRow(at: IndexPath(row: weakSelf.lastRow(inSection: weakSelf.lastSection), section: weakSelf.lastSection), at: .bottom, animated: true)
        }
    }

}
