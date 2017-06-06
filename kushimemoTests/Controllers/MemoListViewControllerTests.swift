//
//  MemoListViewControllerTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

class MemoListViewControllerTests: XCTestCase {

    var vc: MemoListViewController!

    override func setUp() {
        super.setUp()

        vc = UIStoryboard
            .viewController(storyboardName: MemoListViewController.className,
                            identifier: MemoListViewController.className) as! MemoListViewController
        _ = vc.view
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHasTableView() {
        XCTAssertNotNil(vc.tableView)
    }

    func testTableViewDelegate() {
        XCTAssertTrue(vc.tableView.delegate is MemoListViewController)
    }

    func testTableViewDataSource() {
        XCTAssertTrue(vc.tableView.dataSource is MemoListProvider)
    }

    func testNavigationBarTitle() {
        let title = vc.navigationItem.title
        XCTAssertEqual(title, "メモ")
    }

    // MARK: - ToolBarEditButton
    func testToolBarEditButton_When_Default() {
        let title = vc.toolbar.items?[0].title
        XCTAssertEqual(title, "メモ追加")
    }

    func testToolBarEditButton_When_EditModeOff() {
        vc.isEditing = false
        let title = vc.toolbar.items?[0].title
        XCTAssertEqual(title, "メモ追加")
    }

    func testToolBarEditButton_When_EditModeOn() {
        vc.isEditing = true
        let title = vc.toolbar.items?[0].title
        XCTAssertEqual(title, "すべて削除")
    }

    // MARK: - NavigationBarEditButton
    func testNavigationBarEditButtonTitle_When_Default() {
        let title = vc.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_When_EditMode_OFF() {
        vc.isEditing = false
        let title = vc.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_When_EditMode_ON() {
        vc.isEditing = true
        let title = vc.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "完了")
    }
}
