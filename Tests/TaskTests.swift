// TaskTests.swift Created by mason on 2016-03-19. Copyright © 2016 MASONMARK.COM. All rights reserved.

import XCTest


public class TaskTests: XCTestCase {

    func test_fixForCase11DeadlockWithLargeOutput() {
        // Mason 2016-03-19: This is actually a test for the old NakaharaTask class (a massively more complex NSTask wrapper than Task).
        
        // This was a regression test for a 2007 Obj-C bug (I think "Case 11" means we had just switched to Fogbugz and only had 11 bugs at that time?) involving filling up some buffers and deadlocking. Not sure how applicable it even is to this 2015 Swift version, but let's do it anyway.
        
        let testData   = NSMutableData()
        var testString = ""
        
        while testData.length < (1024 * 150) {
            let junk = "NAKAHARANAKAHARANAKAHARANAKAHARANAKAHARANAKAHARANAKAHARANAKAHARA"
            testData.appendData(junk.dataUsingEncoding(NSUTF8StringEncoding)!)
            
            testString += junk
        }
        
        let tmpPath = NSTemporaryDirectory() + "testFixForCase11DeadlockWithLargeOutput-" + NSUUID().UUIDString
        
        XCTAssertTrue(tmpPath.characters.count > 20)
        
        let wroteOK = testData.writeToFile(tmpPath, atomically: true)
        XCTAssertTrue(wroteOK)
        
        let t = Task("/bin/cat", arguments: [tmpPath], launch: false)
        t.launch()
        
        XCTAssert(t.terminationStatus == 0)
        
        let actualText   = t.stdoutText
        let expectedText = testString

        XCTAssert(actualText == expectedText)

        let actualData   = t.stdoutData
        let expectedData = testData
         
        XCTAssert(actualData == expectedData)
    }
    

    // This was once useful for debugging:
    //    func test_whuuuut() {
    //        for i in 1..<1000 {
    //            test_fixForCase11DeadlockWithLargeOutput()
    //            print("ugh \(i)")
    //        }
    //        
    //    }


    func testBasic() {
        let good = Task("/bin/ls", arguments: ["/System"])
        let bad  = Task("/bin/ls", arguments: ["/hgghj/gfhjffjh/ghfghfhj/hgfghj"])
        
        good.launch()
        bad.launch()
        
        XCTAssert(good.stdoutData.length > 0)
        XCTAssert(good.stderrData.length == 0)
        XCTAssert(good.terminationStatus == 0)
        XCTAssert(bad.stdoutData.length == 0)
        XCTAssert(bad.stderrData.length > 0)
        XCTAssert(bad.terminationStatus != 0)
    }
    
    
    func testBasicII() {
        let ok = Task.run("/bin/ls", arguments: ["/System"])
        XCTAssert(ok.stdoutText != "")
        XCTAssert(ok.stderrText == "")
        XCTAssert(ok.terminationStatus == 0)

        let ng = Task.run("/bin/ls", arguments: ["/nope/nope/jshdfdjk"])
        XCTAssert(ng.stdoutText == "")
        XCTAssert(ng.stderrText != "")
        XCTAssert(ng.terminationStatus != 0)
    }

}
