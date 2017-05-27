//
//  MemoDaoTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

class MemoDaoTests: XCTestCase {

    override func setUp() {
        super.setUp()
        MemoDao.dao.deleteAll()
    }

    override func tearDown() {
        MemoDao.dao.deleteAll()
        super.tearDown()
    }

    func testAddMemo() {

        // Setup
        let object = MemoModel()
        object.memoID = 1
        object.title = "タイトル"
        object.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        object.text = "本文"

        // Exercise
        MemoDao.add(model: object)

        // Verify
        verifyMemo(memoID: 1, title: "タイトル", lastModifyStr: "2017/01/01", text: "本文")
    }

    func testUpdateMemo() {

        // Setup
        let object = MemoModel()
        object.memoID = 1
        object.title = "タイトル"
        object.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        object.text = "本文"

        // Exercise
        MemoDao.add(model: object)
        object.title = "タイトル更新"
        object.text = "本文更新"
        MemoDao.update(model: object)

        // Verify
        verifyMemo(memoID: 1, title: "タイトル更新", lastModifyStr: "2017/01/01", text: "本文更新")
    }

    func testDeleteMemo() {

        // Setup
        let object = MemoModel()
        object.memoID = 1
        object.title = "タイトル"
        object.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        object.text = "本文"

        // Exercise
        MemoDao.add(model: object)
        MemoDao.delete(memoID: 1)

        // Verify
        verifyCount(count: 0)
    }

    func testFindAllMemo() {

        // Setup
        let memos = [MemoModel(), MemoModel(), MemoModel()]

        // Exercise
        memos.forEach {
            MemoDao.add(model: $0)
        }

        // Verify
        verifyCount(count: 3)
    }

    func testFindMemo() {

        // Setup
        let object = MemoModel()
        object.memoID = 1
        object.title = "タイトル"
        object.lastModify = "2017/01/01".toDate(dateFormat: "yyyy/MM/dd")
        object.text = "本文"

        // Exercise
        MemoDao.add(model: object)
        let result = MemoDao.findByID(memoID: 1)

        //Verify
        XCTAssertEqual(result?.memoID, 1)
    }
}

// MARK: - private method
private extension MemoDaoTests {

    func verifyMemo(memoID: Int, title: String, lastModifyStr: String, text: String) {

        let result = MemoDao.findAll()

        XCTAssertEqual(result.first?.memoID, memoID)

        if let resultTitle = result.first?.title {
            XCTAssertEqual(resultTitle, title)
        }

        if let lastModify = result.first?.lastModify.toStr(dateFormat: "yyyy/MM/dd") {
            XCTAssertEqual(lastModify, lastModifyStr)
        }

        if let resultText = result.first?.text {
            XCTAssertEqual(resultText, text)
        }
    }
    
    func verifyCount(count: Int) {
        
        let result = MemoDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
