// TestCaseTests.swift Created by mason on 2016-08-15. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import XCTest
@testable import Mason

import Foundation

class TestCaseTests: TestCase {
 
#if !os(Linux)
    
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
        
        // Mason 2017-01-29: This test disabled on Linux, because:
        //        Test Case 'TestCaseTests.test_bundle' started at 19:32:54.823
        //        fatal error: init(for:) is not yet implemented: file Foundation/NSBundle.swift, line 56
        //        ubuntu@mason-linux-2017:~/Mason.swift$
        //        ubuntu@mason-linux-2017:~/Mason.swift$ swift --version
        //        Swift version 3.0.2 (swift-3.0.2-RELEASE)
        //        Target: x86_64-unknown-linux-gnu
        //        ubuntu@mason-linux-2017:~/Mason.swift$ 

        
        let b = bundle
        XCTAssertNotNil(b)
    }
    
#endif

    func test_temporaryDirectoryURL() {
        
        let u  = temporaryDirectoryURL()
        let u2 = temporaryDirectoryURL()
        
        XCTAssertEqual(u, u2)
        
        #if !os(Linux)
            
            // Test Case 'TestCaseTests.test_temporaryDirectoryURL' started at 19:34:56.190
            // fatal error: resourceValues(forKeys:) is not yet implemented: file Foundation/NSURL.swift, line 629

            if let v = try? u.resourceValues(forKeys: [.isDirectoryKey]) {
                guard v.isDirectory != nil else {
                    XCTFail("The text temp dir should, but does not, exist.")
                    return
                }
            } else {
                XCTFail("Could not read attrs of test temp dir.")
            }
        #endif

    }
}

extension TestCaseTests {
    
    static var allTests : [(String, (TestCaseTests) -> () throws -> Void)] {
        return [
            ("test_temporaryDirectoryURL", test_temporaryDirectoryURL),
        ]
    }
}
