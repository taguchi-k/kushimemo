//
//  MemoModelTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

class MemoModelTests: XCTestCase {

    let memo = MemoModel()

    override func setUp() {
        super.setUp()
        MemoDao.dao.deleteAll()
    }

    override func tearDown() {
        MemoDao.dao.deleteAll()
        super.tearDown()
    }

    func testMemoModelDefault() {

        XCTAssertEqual(memo.memoID, 1)
        XCTAssertEqual(memo.title, "")
        XCTAssertNotNil(memo.lastModify)
        XCTAssertEqual(memo.text, "")
    }

    func testMemoModel() {

        memo.memoID = 2
        memo.title = "タイトル"
        memo.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        memo.text = "本文"

        XCTAssertEqual(memo.memoID, 2)
        XCTAssertEqual(memo.title, "タイトル")
        XCTAssertEqual(memo.lastModify.toStr(dateFormat: "yyyy/MM/dd"), "2017/01/01")
        XCTAssertEqual(memo.text, "本文")
    }
}
