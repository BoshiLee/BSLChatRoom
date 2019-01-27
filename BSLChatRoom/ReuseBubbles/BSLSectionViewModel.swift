//
//  BSLSectionViewModel.swift
//  BSLChatRoom
//
//  Created by Boshi Li on 2019/1/27.
//  Copyright © 2019 Boshi Li. All rights reserved.
//

import Foundation

class BSLSectionViewModel: TableSectionViewModelProtocol {
    
    let timeString: String
    init(timeStamp: Int64) {
        self.timeString = timeStamp.toDateString(formate: .chineseYYYYMMdddEEEEE)
    }
}
