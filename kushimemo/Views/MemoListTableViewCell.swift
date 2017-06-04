//
//  MemoListTableViewCell.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit
import STV_Extensions

final class MemoListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastModifyLabel: UILabel!
    @IBOutlet weak var textBodyLabel: UILabel!

    var memoModel: MemoModel? {
        didSet {
            guard let memoModel = memoModel else { return }

            titleLabel.text = memoModel.title
            lastModifyLabel.text = memoModel.lastModify.dateStyle()
            textBodyLabel.text = memoModel.textBody
        }
    }
}
