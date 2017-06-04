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

    func testmemoModelsCount() {
        XCTAssertEqual(dataSource.memoModels.count, 0)
    }

    func testAddmemoModelsCount() {

        let memoModels = [MemoModel(), MemoModel(), MemoModel()]
        dataSource.add(memoModels: memoModels)

        XCTAssertEqual(dataSource.memoModels.count, 3)
    }
}
