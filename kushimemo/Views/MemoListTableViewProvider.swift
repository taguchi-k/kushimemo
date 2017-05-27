//
//  MemoListTableViewProvider.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit
import STV_Extensions

protocol MemoListTableViewProviderDelegate {
    func didDeleteRows()
}

final class MemoListTableViewProvider: NSObject {

    var memos = [MemoModel]()
    var delegate: MemoListTableViewProviderDelegate?

    func add(memos: [MemoModel]) {
        self.memos = memos
    }

    func findMemo(row: Int) -> MemoModel {
        return memos[row]
    }
}

extension MemoListTableViewProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: MemoListTableViewCell.className) as! MemoListTableViewCell
        cell.memo = memos[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        // DBから削除
        MemoDao.delete(memoID: memos[indexPath.row].memoID)

        // 配列から削除
        memos.remove(at: indexPath.row)

        // table更新
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)],
                             with: .fade)
        
        delegate?.didDeleteRows()
    }
}
