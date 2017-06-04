//
//  MemoModelTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest

@testable import kushimemo

class MemoModelTests: XCTestCase {

    let memoModel = MemoModel()

    override func setUp() {
        super.setUp()
        MemoDao.dao.deleteAll()
    }

    override func tearDown() {
        MemoDao.dao.deleteAll()
        super.tearDown()
    }

    func testMemoModelDefault() {
        XCTAssertEqual(memoModel.memoID, 0)
        XCTAssertEqual(memoModel.memo, "")
        XCTAssertNotNil(memoModel.lastModify)
        XCTAssertEqual(memoModel.title, "")
        XCTAssertEqual(memoModel.textBody, "")
    }

    /// メモが設定できるか？
    func testSetMemo() {

        memoModel.memoID = 1
        memoModel.memo = "タイトル\n本文"
        memoModel.lastModify = string2Date("2017/01/01")

        verifyMemo(memoID: 1,
                   memo: "タイトル\n本文",
                   title: "タイトル",
                   textBody: "本文",
                   lastModify: "2017/01/01")
    }

    /// メモが設定できるか？(ディスクリプションなし）
    func testSetMemo_NoDescription() {

        memoModel.memoID = 1
        memoModel.memo = "タイトル"
        memoModel.lastModify = string2Date("2017/12/12")

        verifyMemo(memoID: 1,
                   memo: "タイトル",
                   title: "タイトル",
                   textBody: "",
                   lastModify: "2017/12/12")
    }

    /// メモが設定できるか？（タイトル&ディスクリプションなし）
    func testSetMemo_NoTitleAndDescription() {

        memoModel.memoID = 1
        memoModel.lastModify = string2Date("2017/01/01")

        verifyMemo(memoID: 1,
                   memo: "",
                   title: "",
                   textBody: "",
                   lastModify: "2017/01/01")
    }
}

// MARK: - Helper
private extension MemoModelTests {

    func verifyMemo(memoID: Int,
                    memo: String,
                    title: String,
                    textBody: String,
                    lastModify: String) {

        XCTAssertEqual(memoModel.memoID, memoID)
        XCTAssertEqual(memoModel.memo, memo)
        XCTAssertEqual(memoModel.title, title)
        XCTAssertEqual(memoModel.textBody, textBody)
        XCTAssertEqual(memoModel.lastModify, string2Date(lastModify))
    }

    func string2Date(_ dateString: String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString)!
    }
}
