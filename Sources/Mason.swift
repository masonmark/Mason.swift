import Foundation

public class Mason {
    
    func fu(bro: String = "🌎") {
        print("F.U., \(bro).")
    }
    
    
    /// Make prettier strings for printing to console.
    
    public class func stringify(what: Any?) -> String {
        if let str = what as? String {
            return str
        } else {
            return "\(what)"
        }
    }

}

public func todo(what: Any? = nil, function: String = #function, file: String = #file, line: Int = #line) {
    var msg = "ℹ️ → TODO: "
    if what != nil {
        msg += Mason.stringify(what)
    }
    
    log(msg, function: function, file: file, line: line)
}


public func log(what: Any? = nil, function: String = #function, file: String = #file, line: Int = #line) {
    var fileName = "UNKNOWN"
    if let lastComponent = NSURL(fileURLWithPath: file).lastPathComponent {
        fileName = lastComponent
    }
    
    var msg = ""
    if what != nil {
        msg += Mason.stringify(what)
        msg += "  —  "
    }
    msg += "\(function), \(fileName):\(line)"
    print(msg)
}
