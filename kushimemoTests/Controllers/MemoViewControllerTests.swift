//
//  MemoViewControllerTests.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

class MemoViewControllerTests: XCTestCase {

    var vc: MemoViewController!

    override func setUp() {
        super.setUp()

        vc = UIStoryboard
            .viewController(storyboardName: MemoViewController.className,
                            identifier: MemoViewController.className) as! MemoViewController
        _ = vc.view
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHasTextView() {
        XCTAssertNotNil(vc.textView)
    }

    func testHasTextViewButtom() {
        XCTAssertNotNil(vc.textViewBottom)
    }

    func testTextViewDelegate() {
        XCTAssertTrue(vc.textView.delegate is MemoViewController)
    }
}
