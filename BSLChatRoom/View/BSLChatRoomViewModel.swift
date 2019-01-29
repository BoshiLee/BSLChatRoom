//
//  BSLChatRoomViewModel.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/22.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import UIKit

protocol BSLChatRoomPresentable: AnyObject {
    func didAppendMessages(indeices: [IndexPath])
    func hideKeyboard()
}

class BSLChatRoomViewModel: NSObject {
    
    fileprivate weak var presenter: BSLChatRoomPresentable!
    fileprivate let coordinator = BSLChatRoomCoordinator()
    fileprivate lazy var bubbleVMs = [[BSLBubbleViewModel]]()
    // MARK: - Properties
    
    init(presenter: BSLChatRoomPresentable) {
        self.presenter = presenter
    }

    func appendMessage(_ newMessages: [BSLMessage]) {
        self.bubbleVMs = self.coordinator.appendNewMessages(newMessages)
    }
    
}

// MARK: - Table view data source
extension BSLChatRoomViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.presenter.hideKeyboard()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 18.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let vm = self.coordinator.createHeader(atSection: section) else { return nil }
        let sectionView = vm.sectionInstance(headerFooter: BSLSectionView.self, tableView: tableView)
        sectionView.configure(with: vm)
        return sectionView
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.bubbleVMs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bubbleVMs[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bubbleVM = self.bubbleVMs[indexPath.section][indexPath.row]
        let cell = bubbleVM.cellInstance(cell: BSLBubble.self, tableView: tableView, atIndexPath: indexPath)
        cell.configure(withViewModel: bubbleVM)
        return cell
    }


}
