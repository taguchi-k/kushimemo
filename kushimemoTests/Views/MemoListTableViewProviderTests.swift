//
//  MemoListProviderTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
@testable import kushimemo

class MemoListProviderTests: XCTestCase {

    let dataSource = MemoListProvider()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMemosCount() {
        XCTAssertEqual(dataSource.memos.count, 0)
    }

    func testAddMemosCount() {

        let memos = [MemoModel(), MemoModel(), MemoModel()]
        dataSource.add(memos: memos)

        XCTAssertEqual(dataSource.memos.count, 3)
    }
}
