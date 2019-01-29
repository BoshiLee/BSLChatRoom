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
        guard let date = timeStamp.toDate() else {
            self.timeString = "無法解析日期"
            return
        }
        if Calendar.current.isDateInYesterday(date) {
            self.timeString = "昨天"
        } else {
            self.timeString = timeStamp.toDateString(formate: .chineseYYYYMMdddEEEEE)
        }
    }
}
