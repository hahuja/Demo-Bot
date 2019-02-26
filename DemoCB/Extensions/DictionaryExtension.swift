//
//  DictionaryExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation

extension Dictionary {
    func stringForKey(_ key: Key) -> String {
        if let string = self[key] as? String {
            return string
        }
        return ""
    }
}
