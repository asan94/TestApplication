//
//  String.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
