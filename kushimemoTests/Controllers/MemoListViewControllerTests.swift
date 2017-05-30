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
}
