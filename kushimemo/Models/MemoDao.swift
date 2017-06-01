//
//  MemoDao.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import Foundation
import RealmSwift

final class MemoDao {

    static let dao = RealmDaoHelper<MemoModel>()

    static func add(memo: String) {

        let object = MemoModel()
        object.memoID = MemoDao.dao.newId()!
        object.memo = memo
        object.lastModify = Date()

        MemoDao.dao.add(d: object)
    }

    static func update(model: MemoModel) {

        guard let target = dao.findFirst(key: model.memoID as AnyObject) else {
            return
        }

        let object = MemoModel()
        object.memoID = target.memoID
        object.memo = model.memo
        object.lastModify = Date()
        _ = dao.update(d: object)
    }

    static func delete(memoID: Int) {
        guard let object = dao.findFirst(key: memoID as AnyObject) else { return }
        dao.delete(d: object)
    }

    static func deleteAll() {
        dao.deleteAll()
    }

    static func findByID(memoID: Int) -> MemoModel? {
        return dao.findFirst(key: memoID as AnyObject)
    }

    static func findAll() -> [MemoModel] {
        let objects = MemoDao.dao
            .findAll()
            .sorted(byKeyPath: "lastModify", ascending: false)
        return objects.map { MemoModel(value: $0) }
    }
}
