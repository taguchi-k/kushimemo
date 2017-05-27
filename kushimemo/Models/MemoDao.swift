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

    static func add(model: MemoModel) {

        let object = MemoModel()
        object.memoID = MemoDao.dao.newId()!
        object.title = model.title
        object.lastModify = model.lastModify
        object.text = model.text

        MemoDao.dao.add(d: object)
    }

    static func update(model: MemoModel) {
        _ = dao.update(d: model)
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
        let objects = MemoDao.dao.findAll()
        return objects.map { MemoModel(value: $0) }
    }
}
