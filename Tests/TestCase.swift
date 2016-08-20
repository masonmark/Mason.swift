// TestCase.swift Created by mason on 2016-08-15. Copyright © 2016 MASON MARK (.COM). All rights reserved.
// ...based on NakaharaCoreTestCase.h Created by mason on 2008-10-07.
// ...based on FiveSpeedTestCase.h Created by mason on 2006-01-04.

import XCTest

/// This is my test case base class. There are many like it, but this one is mine.

class TestCase: XCTestCase {
    
    func die(_ why: Any) -> Never {
        
        let message = "\(why)"
        XCTFail(message)
        fatalError(message)
    }
    
    /// Returns a identifier string that is globally unique to this instance.
    
    lazy var uniqueId: String = UUID().uuidString
    
    /// Returns the bundle containing the test case itself (usually an .xctest bundle). Useful for loading test resources/fixtures.
    
    lazy var bundle: Bundle = Bundle(for: type(of: self))

    /// Returns the URL to a temporary directory unique to this test case, creating it if necessary.
    
    func temporaryDirectoryURL() -> URL {
        
        guard let tempDirURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(type(of: self))-\(uniqueId)", isDirectory: true) else {
            die("internal test error: unable to find temp directory")
        }
        
        let fm = FileManager.default
        
        var isDir: ObjCBool = ObjCBool(false)
        
        if !fm.fileExists(atPath: tempDirURL.path, isDirectory: &isDir) || !isDir.boolValue {
            do {
                try fm.createDirectory(at: tempDirURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                die("internal test error: unable to create temp directory")
            }
        }
        
        
        return tempDirURL
    }

}