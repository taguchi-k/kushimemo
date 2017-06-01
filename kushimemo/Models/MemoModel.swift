//
//  MemoModel.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import Foundation
import RealmSwift

final class MemoModel: Object {

    dynamic var memoID = 0
    dynamic var memo = ""
    dynamic var lastModify = Date()

    /// タイトル（メモ一行目）
    var title: String {
        return memo.lines.first ?? ""
    }

    /// 本本（メモ二行目以降）
    var textBody: String {
        return memo.lines.dropFirst().joined(separator: Constants.lineFeed)
    }

    override static func primaryKey() -> String? {
        return "memoID"
    }
}
