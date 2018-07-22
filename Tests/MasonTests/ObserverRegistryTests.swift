// ObserverRegistryTests.swift Created by mason on 2016-09-16. Copyright © 2016 MASON MARK (.COM). All rights reserved.

#if !os(Linux)

import XCTest
@testable import Mason

class ObserverRegistryTests: XCTestCase {
    
    var o = Observee();

    var values: [String] = []

    
    override func setUp() {
        
        super.setUp()
        
        o.addObserver(name: .fooObserverRegistryTestsNotification) { (notif) in
            self.values.append(notif.name.rawValue)
        }
        
        o.addObserver(name: .barObserverRegistryTestsNotification) { (notif) in
            self.values.append(notif.name.rawValue)
        }
        
        o.addObserver(name: .bazObserverRegistryTestsNotification) { (notif) in
            self.values.append(notif.name.rawValue)
        }
    }
    
    
    func testBasic() {
        
        o.post(name: .fooObserverRegistryTestsNotification)
        o.post(name: .barObserverRegistryTestsNotification)
        o.nukeRegistry()
        o.post(name: .bazObserverRegistryTestsNotification)
        
        guard values.count == 2 else {
            XCTFail()
            return
        }
        
        XCTAssert(values[0] == "fooObserverRegistryTestsNotification")
        XCTAssert(values[1] == "barObserverRegistryTestsNotification")
        
        // I think that since we've proved that NotificationCenter doesn't invoke the observation block when  notifications are posted by the *exact* same object instance, we are pretty safe assuming that it will also not send notifications when posted by subsequently-allocated objects that happen to occupy the same memory test. Therefore, through this simple mechanism, we can declare Bug 3293160 a non-issue.
    }
    
}


class Observee {
    
    private var observerRegistry = ObserverRegistry()
    
    
    func addObserver(name: Notification.Name? = nil, block: @escaping (Notification) -> Swift.Void) {
        _ = observerRegistry.addObserver(name: name, object: self, queue: nil, using: block)
    }
    
    
    func post(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: self)
    }
    
    
    func nukeRegistry() {
        let old = observerRegistry
        let new = ObserverRegistry()
        observerRegistry = new
        print("Replaced \(old) with \(new).")
    }
    
}


extension Notification.Name {
    static let fooObserverRegistryTestsNotification = Notification.Name("fooObserverRegistryTestsNotification")
    static let barObserverRegistryTestsNotification = Notification.Name("barObserverRegistryTestsNotification")
    static let bazObserverRegistryTestsNotification = Notification.Name("bazObserverRegistryTestsNotification")
}

#endif // !os(Linux)
