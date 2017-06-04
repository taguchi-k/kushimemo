//
//  MemoListTableViewCellTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

class MemoListTableViewCellTests: XCTestCase {

    var tableView: UITableView?
    let dataSouce = FakeDataSource()
    var cell: MemoListTableViewCell?

    override func setUp() {
        super.setUp()

        let controller = MocMemoListViewController()
            .create(identifier: MemoListViewController.className) as! MemoListViewController

        tableView = controller.tableView
        tableView?.dataSource = dataSouce

        cell = tableView?.dequeueReusableCell(
            withIdentifier: MemoListTableViewCell.className) as? MemoListTableViewCell
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(cell?.titleLabel)
    }

    func testHasLastModifyLabel() {
        XCTAssertNotNil(cell?.lastModifyLabel)
    }

    func testHasTextBodyLabel() {
        XCTAssertNotNil(cell?.textBodyLabel)
    }

    func testConfigCell() {

        let memoModel = MemoModel()
        memoModel.memo = "タイトル\n本文"
        memoModel.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        cell?.memo = memoModel

        XCTAssertEqual(cell?.titleLabel.text, "タイトル")
        // ここで同年の日付形式チェックもしている
        XCTAssertEqual(cell?.lastModifyLabel.text, "01/01")
        XCTAssertEqual(cell?.textBodyLabel.text, "本文")
    }

    // MARK: - 日付形式テスト（同年は testConfigCell でチェック）

    /// 当日
    func testLastModifyToDay() {

        let date = Date()

        let memo = MemoModel()
        memo.lastModify = date
        cell?.memo = memo

        XCTAssertEqual(cell?.lastModifyLabel.text, date.toStr(dateFormat: "HH:mm"))
    }

    /// 前年以前
    func testPriorYears() {

        let date = "2016/01/01".toDate(dateFormat: "yyyy/MM/dd")

        let memo = MemoModel()
        memo.lastModify = date
        cell?.memo = memo

        XCTAssertEqual(cell?.lastModifyLabel.text, "2016/01/01")
    }
}

extension MemoListTableViewCellTests {

    final class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
