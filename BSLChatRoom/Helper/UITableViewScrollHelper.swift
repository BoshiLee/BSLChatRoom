//
//  UITableViewIndexPathHelper.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/29.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            let lastSection = weakSelf.numberOfSections - 1 > 0 ? weakSelf.numberOfSections - 1 : 0
            let lastRow = weakSelf.numberOfRows(inSection: lastSection) - 1 > 0 ? weakSelf.numberOfRows(inSection: lastSection) - 1 : 0
            weakSelf.self.scrollToRow(at: IndexPath(row: lastRow, section: lastSection), at: .bottom, animated: true)
        }
    }

}
