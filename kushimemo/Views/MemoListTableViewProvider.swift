//
//  MemoListProvider.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit
import STV_Extensions

protocol MemoListProviderDelegate: class {
    func didDeleteRows()
}

final class MemoListProvider: NSObject {

    var memoModels = [MemoModel]()

    weak var delegate: MemoListProviderDelegate?

    func add(memoModels: [MemoModel]) {
        self.memoModels = memoModels
    }

    /// 該当のメモを取得する
    ///
    /// - Parameter index: TableViewのインデックス
    /// - Returns: メモ
    func memo(index: Int) -> MemoModel {
        guard index < memoModels.count else { fatalError("memoModelsの要素数を超えました。") }
        return memoModels[index]
    }
}

// MARK: - UITableViewDataSource
extension MemoListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: MemoListTableViewCell.className) as! MemoListTableViewCell
        cell.memoModel = memoModels[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        // DBから削除
        MemoDao.delete(memoID: memoModels[indexPath.row].memoID)
        // 配列から削除
        memoModels.remove(at: indexPath.row)
        // table更新
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)],
                             with: .fade)
        
        delegate?.didDeleteRows()
    }
}
