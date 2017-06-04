//
//  MemoDaoTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest

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

    /// 登録できるか確認する
    func testAddMemo() {
        MemoDao.add(memo: "タイトル\n本文")
        verifyMemo(memoID: 1, title: "タイトル", textBody: "本文")
    }

    /// 登録できるか確認する（本文がないケース）
    func testAddMemo_ForNoDescription() {
        MemoDao.add(memo: "タイトル")
        verifyMemo(memoID: 1, title: "タイトル", textBody: "")
    }

    /// 変更できるか確認する
    func testUpdateMemo() {

        // Setup
        MemoDao.add(memo: "タイトル\n本文")

        // Exercise
        let result = MemoDao.findAll().first
        result?.memo = "タイトル更新\n本文更新"
        MemoDao.update(model: result!)

        // Verify
        verifyMemo(memoID: 1, title: "タイトル更新", textBody: "本文更新")
    }

    /// 削除できるか確認する
    func testDeleteMemo() {
        MemoDao.add(memo: "タイトル\n本文")
        MemoDao.delete(memoID: 1)
        verifyCount(count: 0)
    }

    /// メモが取得できるか？
    func testFindAllMemo() {

        MemoDao.add(memo: "タイトル1\n本文")
        MemoDao.add(memo: "タイトル2\n本文")
        MemoDao.add(memo: "タイトル3\n本文")

        verifyCount(count: 3)
    }

    /// メモが更新日の降順で取得されるか？
    func testFindAllMemo_ForOrder() {

        MemoDao.add(memo: "タイトル1\n本文1")
        sleep(1)
        MemoDao.add(memo: "タイトル2\n本文2")
        sleep(1)
        MemoDao.add(memo: "タイトル3\n本文3")

        let result = MemoDao.findAll()

        XCTAssertEqual("タイトル3", result[0].title)
        XCTAssertEqual("タイトル2", result[1].title)
        XCTAssertEqual("タイトル1", result[2].title)
    }

    /// 該当のメモが取得できるか？
    func testFindByIDMemo() {

        MemoDao.add(memo: "タイトル1\n本文1")
        MemoDao.add(memo: "タイトル2\n本文2")
        MemoDao.add(memo: "タイトル3\n本文3")

        let result = MemoDao.findByID(memoID: 2)
        XCTAssertEqual("タイトル2", result?.title)
        XCTAssertEqual("本文2", result?.textBody)
    }
}

// MARK: - private method
private extension MemoDaoTests {

    func verifyMemo(memoID: Int, title: String, textBody: String) {

        let result = MemoDao.findAll()

        XCTAssertEqual(result.first?.memoID, memoID)

        if let resultTitle = result.first?.title {
            XCTAssertEqual(resultTitle, title)
        }

        if let resultTextBody = result.first?.textBody {
            XCTAssertEqual(resultTextBody, textBody)
        }
    }
    
    func verifyCount(count: Int) {
        
        let result = MemoDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
