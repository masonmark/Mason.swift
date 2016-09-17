// TestCaseTests.swift Created by mason on 2016-08-15. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import XCTest
@testable import Mason

class TestCaseTests: TestCase {
 
    func test_uniqueId() {
        
        let foo = TestCase()
        let bar = TestCase()
        
        let fooId = foo.uniqueId
        let barId = bar.uniqueId
        
        XCTAssertEqual(fooId, foo.uniqueId)
        XCTAssertNotEqual(fooId, barId)
        
        let rehydratedUUID = UUID(uuidString: fooId)
        XCTAssertEqual(rehydratedUUID?.uuidString, foo.uniqueId)
    }
    
    func test_bundle() {
        
        let b = bundle
        XCTAssertNotNil(b)
    }
    
    func test_temporaryDirectoryURL() {
        
        let u  = temporaryDirectoryURL()
        let u2 = temporaryDirectoryURL()
        
        XCTAssertEqual(u, u2)
        var isDir: ObjCBool = ObjCBool(false)
        XCTAssert(FileManager.default.fileExists(atPath: u.path, isDirectory: &isDir))
        XCTAssert(isDir.boolValue)
    }
}
