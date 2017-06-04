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

    /// メモを登録する
    ///
    /// - Parameter memo: メモ
    static func add(memo: String) {

        let object = MemoModel()
        object.memoID = MemoDao.dao.newId()!
        object.memo = memo
        object.lastModify = Date().now()

        MemoDao.dao.add(d: object)
    }

    /// メモを更新する
    ///
    /// - Parameter model: メモモデル
    static func update(model: MemoModel) {

        guard let target = dao.findFirst(key: model.memoID as AnyObject) else {
            return
        }

        let object = MemoModel()
        object.memoID = target.memoID
        object.memo = model.memo
        object.lastModify = Date().now()
        _ = dao.update(d: object)
    }

    /// メモを削除する
    ///
    /// - Parameter memoID: メモID
    static func delete(memoID: Int) {
        guard let object = dao.findFirst(key: memoID as AnyObject) else { return }
        dao.delete(d: object)
    }

    /// メモを全て削除する
    static func deleteAll() {
        dao.deleteAll()
    }

    /// 該当のメモを取得する
    ///
    /// - Parameter memoID: メモID
    /// - Returns: メモモデル
    static func findByID(memoID: Int) -> MemoModel? {
        return dao.findFirst(key: memoID as AnyObject)
    }

    /// 全てのメモを取得する
    ///
    /// - Returns: メモモデルの配列
    static func findAll() -> [MemoModel] {
        let objects = MemoDao.dao
            .findAll()
            .sorted(byKeyPath: "lastModify", ascending: false)
        return objects.map { MemoModel(value: $0) }
    }
}
