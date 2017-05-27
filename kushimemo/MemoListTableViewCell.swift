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

    var memo: MemoModel? {
        didSet {
            guard let memo = memo else { return }

            titleLabel.text = memo.title
            lastModifyLabel.text = memo.lastModify.dateStyle()
            textBodyLabel.text = memo.text
        }
    }
}
