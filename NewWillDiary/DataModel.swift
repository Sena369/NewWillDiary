//
//  DataModel.swift
//  WillDiary
//
//  Created by 澤田世那 on 2022/04/01.
//

import Foundation
import RealmSwift

class ToDoListModel: Object {
    @objc dynamic var detailedItem = ""
    @objc dynamic var check = false
    @objc dynamic var createdAt = Date()
}
   
class DiaryModel: Object {
    
    @objc dynamic var calendarDate: String = ""
    @objc dynamic var diaryText: String = ""
    open var primaryKey: String { // TODO: 解読
         return "calendarDate"
    }
}


