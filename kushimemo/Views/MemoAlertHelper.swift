//
//  MemoAlertHelper.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/30.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit

protocol MemoAlertHelperDelegate: class {
    func deleteAll()
}

final class MemoAlertHelper: NSObject {

    weak var delegate: MemoAlertHelperDelegate?
    private var alert: UIAlertController!

    /// メモ削除用ダイアログの作成
    ///
    /// - Parameters:
    ///   - delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func deleteMemo(delegate: MemoAlertHelperDelegate) -> UIAlertController {

        self.delegate = delegate
        alert = UIAlertController(title: nil,
                                  message: nil,
                                  preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "LIST_CANCEL".localized(),
                                         style: .cancel,
                                         handler: nil)

        let deleteAction = UIAlertAction(title: "LIST_DELETE_ALL".localized(),
                                         style: .destructive) { _ in self.delegate?.deleteAll() }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        return alert
    }
}
