// MasonTests.swift Created by mason on 2016-08-14. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import XCTest
@testable import Mason

class MasonTests: XCTestCase {
    
    func test_basic() {
        let mason = "awesome"
        XCTAssert(mason == "awesome")
    }
}

extension MasonTests {
    
    static var allTests : [(String, (MasonTests) -> () throws -> Void)] {
        return [
            ("test_basic", test_basic),
        ]
    }
}
