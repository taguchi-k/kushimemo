//
//  MocMemoListViewController.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import XCTest
import STV_Extensions

@testable import kushimemo

final class MocMemoListViewController: NSObject {

    var controller: UIViewController?

    func create(identifier: String) -> UIViewController {

        controller = UIStoryboard
            .viewController(storyboardName: MemoListViewController.className,
                            identifier: MemoListViewController.className) as! MemoListViewController
        _ = controller?.view

        return controller!
    }
}
