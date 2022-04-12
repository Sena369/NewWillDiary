//
//  DataModel.swift
//  WillDiary
//
//  Created by 澤田世那 on 2022/04/01.
//

import Foundation
import RealmSwift

struct Goal {
    var uuidString = UUID().uuidString
    var goalText: String
    var goalDate = Date()
}

struct Diary {
    var uuidString = UUID().uuidString
    var diaryText: String
    var calendarDate: Date
}

struct ToDoList {
    var uuidString = UUID().uuidString
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


private extension Goal {
    init(managedObject: RealmGoal) {
        self.uuidString = managedObject.uuidString
        self.goalText = managedObject.goalText
        self.goalDate = managedObject.goalDate
    }

    func managedObject() -> RealmGoal {
        let realmGoal = RealmGoal()
        realmGoal.uuidString = self.uuidString
        realmGoal.goalText = self.goalText
        realmGoal.goalDate = self.goalDate
        return realmGoal
    }
}
private extension Diary {
    init(managedObject: RealmDiary) {
        self.uuidString = managedObject.uuidString
        self.diaryText = managedObject.diaryText
        self.calendarDate = managedObject.calendarDate
    }

    func managedObject() -> RealmDiary {
        let realmDiary = RealmDiary()
        realmDiary.uuidString = self.uuidString
        realmDiary.diaryText = self.diaryText
        realmDiary.calendarDate = self.calendarDate
        return realmDiary
    }
}
private extension ToDoList {
    init(managedObject: RealmToDoList) {
        self.uuidString = managedObject.uuidString
        self.toDoDate = managedObject.toDoDate
        let realmToDoItemsArray = Array(managedObject.toDoItems)
        let toDoItemsArray = realmToDoItemsArray.map{ToDoItem(managedObject: $0)}
        self.toDoItems = toDoItemsArray
    }

    func managedObject() -> RealmToDoList {
        let realmToDoList = RealmToDoList()
        realmToDoList.uuidString = self.uuidString
        realmToDoList.toDoDate = self.toDoDate
        let realmToDoItemsArray = self.toDoItems.map{$0.managedObject()}
        realmToDoList.toDoItems.append(objectsIn: realmToDoItemsArray)
        return realmToDoList
    }
}
private extension ToDoList.ToDoItem {
    init(managedObject: RealmToDoItem) {
        self.isCheck = managedObject.isCheck
        self.toDoText = managedObject.toDoText
    }

    func managedObject() -> RealmToDoItem {
        let realmToDoItem = RealmToDoItem()
        realmToDoItem.isCheck = self.isCheck
        realmToDoItem.toDoText = self.toDoText
        return realmToDoItem
    }
}
final class NewWillDiary {
    private let realm = try! Realm()
// サンプル
    func load() -> [ToDoList]{
        let toDoList = ToDoList(uuidString: UUID().uuidString, toDoItems: [ToDoList.ToDoItem(toDoText: "読書", isCheck: false)], toDoDate: Date())
        let realmToDoList = realm.objects(RealmToDoList.self)
        let realmToDoListArray = Array(realmToDoList)
        let toDoLists = realmToDoListArray.map{ToDoList(managedObject: $0)}
        return toDoLists
    }

}








// MARK: - せなさんコード
class ToDoListModel: Object {
    @objc dynamic var detailedItem = ""
    @objc dynamic var check = false
    @objc dynamic var createdAt = Date()
}

class DiaryModel: Object {
    @objc dynamic var calendarDate: String = ""
    @objc dynamic var diaryText: String = ""
    open var primaryKey: String {
        // TODO: 解読
        return "calendarDate"
    }
}
