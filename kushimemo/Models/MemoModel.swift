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

    dynamic var memoID = 1
    dynamic var title = ""
    dynamic var lastModify = Date()
    dynamic var text = ""

    override static func primaryKey() -> String? {
        return "memoID"
    }
}
