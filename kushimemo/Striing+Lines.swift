//
//  Striing+Lines.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import Foundation

extension String {

    var lines: [String] {

        var lines = [String]()

        self.enumerateLines { (line, stop) in
            lines.append(line)
        }
        return lines
    }
}
