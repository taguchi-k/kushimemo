//
//  Striing+LinesTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
@testable import kushimemo

class Striing_LinesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLines1Line() {

        let text = "1行目"
        XCTAssertEqual(text.lines, ["1行目"])
    }

    func testLinesLines() {

        let text = "1行目\n2行目\n3行目"
        XCTAssertEqual(text.lines, ["1行目", "2行目", "3行目"])
    }

    func testLinesEmpty() {

        let text = "1行目\n"
        XCTAssertEqual(text.lines, ["1行目"])
    }
}
