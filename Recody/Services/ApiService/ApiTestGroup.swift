//
//  ApiTestGroup.swift
//  Recody
//
//  Created by Glory Kim on 2022/12/05.
//

import Foundation

class ApiTestGroup {
    static let worker = SimpleWoker()
    static func doTest() {
        worker.api(.search("123", "ddd"))
    }
}
