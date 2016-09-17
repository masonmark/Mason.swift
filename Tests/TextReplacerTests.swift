// TextReplacerTests.swift Created by mason on 2016-08-15. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import XCTest

class TextReplacerTests: TestCase {
    
    let before: [String:String] = [
        "test1.txt" : "What I like about the cloud is that the cloud likes me.\nWow, the cloud",
        "test2.japanese" : "韓国に行って、キムチを食えばどう？\nいいよ。",
        "test3.txt" : "Emoji: 🔥. Slaymoji: 🂋"
    ]
    
    let after: [String:String] = [
        "test1.txt" : "What I like about my butt is that my butt likes me.\nWow, my butt",
        "test2.japanese" : "メキシコに行って、タコスを食えばどう？\nだめよ。",
        "test3.txt" : "Emoji: 💀. Slaymoji: ⌘"
    ]
    
    var dir = URL(fileURLWithPath: "/this/will/be/replaced")
    
    override func setUp() {
        dir = temporaryDirectoryURL().appendingPathComponent(UUID().uuidString)
        
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
            for (filename, text) in before {
                try text.write(to: dir.appendingPathComponent(filename), atomically: true, encoding: .utf8)
            }
        } catch {
            die("can't write text files")
        }
    }
    

    func readFiles() -> [String:String] {
        
        var result: [String:String] = [:]
        
        for filename in after.keys {
            let url = dir.appendingPathComponent(filename)
            if let fileContents = try? String(contentsOf: url)  {
                result[filename] = fileContents
            }
        }
        return result
    }
    
    
    func test_basic() {
        
        let tr = TextReplacer()
        XCTAssertNil( tr.replaceOccurences(of: "the cloud", with: "my butt", directory: dir) )
        XCTAssertNil( tr.replaceOccurences(of: "韓国", with: "メキシコ", directory: dir) )
        XCTAssertNil( tr.replaceOccurences(of: "キムチ", with: "タコス", directory: dir) )
        XCTAssertNil( tr.replaceOccurences(of: "いい", with: "だめ", directory: dir) )
        XCTAssertNil( tr.replaceOccurences(of: "🔥", with: "💀", directory: dir) )
        XCTAssertNil( tr.replaceOccurences(of: "🂋", with: "⌘", directory: dir) )
        
        let actual   = readFiles()
        let expected = after
        
        for (filename) in expected.keys {
            XCTAssertEqual(actual[filename],expected[filename])
        }
    }
    
    
    func test_with_file_extension_filter() {
        
        let tr = TextReplacer()

        let extensions = ["txt", "nonexistent"]
        
        XCTAssertNil( tr.replaceOccurences(of: "the cloud", with: "my butt", directory: dir, extensions: extensions) )
        XCTAssertNil( tr.replaceOccurences(of: "韓国", with: "メキシコ", directory: dir, extensions: extensions) )
        XCTAssertNil( tr.replaceOccurences(of: "キムチ", with: "タコス", directory: dir, extensions: extensions) )
        XCTAssertNil( tr.replaceOccurences(of: "いい", with: "だめ", directory: dir, extensions: extensions) )
        XCTAssertNil( tr.replaceOccurences(of: "🔥", with: "💀", directory: dir, extensions: extensions) )
        XCTAssertNil( tr.replaceOccurences(of: "🂋", with: "⌘", directory: dir, extensions: extensions) )
        
        let actual   = readFiles()
        let expected = [
            "test1.txt" : "What I like about my butt is that my butt likes me.\nWow, my butt",
            "test2.japanese" : "韓国に行って、キムチを食えばどう？\nいいよ。", // should not be processed
            "test3.txt" : "Emoji: 💀. Slaymoji: ⌘"
        ]

        for (filename) in expected.keys {
            XCTAssertEqual(actual[filename],expected[filename])
        }
    }

}
