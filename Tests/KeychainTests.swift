//  KeychainTests.swift Created by mason on 2016-02-21. Copyright © 2016 masonmark.com. All rights reserved.

import XCTest

class KeychainTests: XCTestCase
{
    let key1 = "foo.bar.baz.mary.had.a.little.lamb.bro.and.its.fleece.was.red.white.and.blue"
    let key2 = "the.freedom.of.birds.is.an.insult.to.me"
    
    
    func test_basic() {
        let data1 = NSUUID().UUIDString.dataUsingEncoding(NSUTF8StringEncoding)!
        let data2 = NSUUID().UUIDString.dataUsingEncoding(NSUTF8StringEncoding)!
        XCTAssertNotEqual(data1, data2) // just a sanity check, of course this is always true
        
        Keychain.write(key1, data: data1)
        XCTAssertEqual(Keychain.read(key1), data1)
        
        Keychain.write(key2, data: data2)
        XCTAssertEqual(Keychain.read(key2), data2)
        
        XCTAssertNil(Keychain.read(NSUUID().UUIDString))
    }
    
    
    func test_empty_string_lookup() {
        // Mason 2016-02-21: This was a real bug; initial version of Keychain did return some data in this case.
        XCTAssertNil(Keychain.read(""))
    }
    
    
    func test_write_empty_data() {
        // Can't think of any reason to do this in real life, but I wrote this test just to make sure it didn't crash or anything.
        Keychain.write(key1, data: NSData())
        let readData = Keychain.read(key1)
        XCTAssertEqual(readData, NSData())
    }
    
}
