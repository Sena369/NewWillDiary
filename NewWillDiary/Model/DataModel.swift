//
//  DataModel.swift
//  WillDiary
//
//  Created by 澤田世那 on 2022/04/01.
//

import Foundation
import RealmSwift

struct Goal {
    var uuid: UUID
    var goalText: String
    var goalDate = Date()
}

struct Diary {
    var uuid: UUID
    var diaryText: String
    var calendarDate: Date
}

struct ToDoList {
    var uuid: UUID
    var toDoItems: [ToDoItem]
    var toDoDate: Date

    struct ToDoItem {
        var toDoText: String
        var isCheck: Bool
    }
}


class RealmGoal: Object {
    @objc dynamic var uuidString: String = ""
    @objc dynamic var goalText: String = ""
    @objc dynamic var goalDate: Date = Date()

    convenience init(uuid:UUID,  text: String,goalDate: Date) {
        self.init()
        self.uuidString = uuid.uuidString
        self.goalText = text
        self.goalDate = goalDate
    }
    override class func primaryKey() -> String? {
        "uuidString"
    }
}

class RealmDiary: Object {
    @objc dynamic var uuidString: String = ""
    @objc dynamic var diaryText: String = ""
    @objc dynamic var calendarDate: Date = Date()
    convenience init(uuid:UUID,  diaryText: String,calendarDate: Date) {
        self.init()
        self.uuidString = uuid.uuidString
        self.diaryText = diaryText
        self.calendarDate = calendarDate
    }
    override class func primaryKey() -> String? {
        "uuidString"
    }
}


class RealmToDoList: Object {
    @objc dynamic var uuidString: String = ""
    var toDoItems = List<RealmToDoItem>()
    @objc dynamic var toDoDate: Date = Date()
    convenience init(uuid:UUID, toDoDate: Date) {
        self.init()
        self.uuidString = uuid.uuidString
        self.toDoDate = toDoDate
    }
    override class func primaryKey() -> String? {
        "uuidString"
    }
}

class RealmToDoItem: Object {
    @objc dynamic var toDoText: String = ""
    @objc dynamic var isCheck: Bool = false
    let toDoItems = LinkingObjects(fromType: RealmToDoList.self, property: "toDoItems")

    convenience init(toDoText: String,isCheck: Bool) {
        self.init()
        self.toDoText = toDoText
        self.isCheck = isCheck
    }
}





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
