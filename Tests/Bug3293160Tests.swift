// NotificationTests.swift Created by mason on 2016-08-12. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import XCTest

class Bug3293160Test: XCTestCase {
    
    static var statistician = Statistician()
    
    override func setUp() {
        Bug3293160Test.statistician = Statistician()
          // reset stats before each test
    }
    
    
    func test_that_rdar_3293160_is_still_a_thing() {
        
        // This test case proves that we need to unregister our observer objects before the observed
        // objects are deallocated, or else our observer objects may receive spurious notifications 
        // at a later time, if more objects that post the same notification are allocated later and
        // end up occupying any of the same memory addresses as the previous observed objects.
        //
        // To avoid this, we need to implement a mechanism to "remove all observers of object X".
        //
        // The name comes from bug number 3293160 (rdar://3293160), filed June 15, 2003, against
        // Mac OS X 10.2.6 (6L60):
        
        // ----------------------------
        //    Mason Mark 15-Jun-2003 00:22 AM
        //
        //    * SUMMARY This is a Cocoa development bug.
        //
        //    According to the NSNotificationCenter documentation, the following code
        //    should remove any observers who are registered to receive notifications
        //    containing anObject:
        //
        //    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        //    [nc removeObserver:nil name:nil object:anObject];
        //
        //    However, it does not remove the observers. If another object
        //    subsequently is allocated at the same memory address as the original,
        //    and also posts notifications, the original observer will receive more
        //    notifications, potentially causing bugs and crashes.
        //
        //    * STEPS TO REPRODUCE The easiest way to see this bug is to download the
        //    sample app I created. It is permanently posted at:
        //
        //    http://fivespeed.net/mason/remove_observer_bug/
        //
        //    The app includes source code demonstrating the above problem.
        //
        //    * RESULTS The result of using this API is that the observer objects are
        //    not removed, contrary to the developer's expectations (and the
        //    documentation).
        //
        //    * REGRESSION I have not had time to test this on prior OS releases. It
        //    is my belief that the problem did not exist on previous releases of Mac
        //    OS X, but I can't be sure. Maybe I simply never noticed.
        //
        //    This is Mac OS X 10.2.6  (6L60)
        //
        //    * NOTES none
        // ----------------------------
        //
        // There was some discussion of this on the preeminent Cocoa developer mailing list at
        // that time:
        //
        //   http://www.cocoabuilder.com/archive/cocoa/3713-removeobserver-name-object-is-broken-with-sample-app.html
        //
        // It was definitively established in that thread that NSNotificationCenter has actually never
        // supported this mode of operation, despite what the documentation said at that time (and
        // despite my erroneous recollections of it working on Mac OS X 10.1). Apple eventually changed
        // the documentation, and closed the issue in 2005.
        //
        // So while it's not really a bug in Apple's framework, it's an issue you need to be aware of if
        // you use addObserver(_:selector:name:object:) / addObserver:selector:name:object:.
        //
        // In the intervening 13 years since my original bug report Apple has (of course) fixed and made
        // more convenient many aspects of programming against their Frameworks. This includes a similar
        // issue with using NotificationCenter (née NSNotificationCenter): it is no longer necessary to 
        // manually unregister your observer object before the observer object is deallocated; the 
        // notification center now handles that for you. 
        //
        // Therefore, I wondered if implementing a workaround for bug 3293160 was still necessary, and
        // wrote this test case to find out. (Spoiler alert: still necessary.)
        

        let stats = Bug3293160Test.statistician

        // First, set up a group of Observee instances, and create a corresponding Observer
        // instance for each one. We will later destroy the observees, but will keep the observers
        // around so that we can see if they receive spurious notifications after the observees are
        // destroyed.
        
        var observees = [
            Observee(),
            Observee(),
            Observee(),
        ]
        let observers = [
            Observer(),
            Observer(),
            Observer(),
        ]
        for (ee, er) in zip(observees, observers) {
            
            let nc  =  NotificationCenter.default
            let sel = #selector(Observer.receive(notification:))
            
            nc.addObserver(er, selector: sel, name: .masonTest, object: ee)
            nc.addObserver(forName: .masonTest, object: ee, queue: nil, using: { (notification) in
                stats.recordBlockInvocation(notification: notification)
            })
        }
        
        // Collect the unique identifiers from the Observee objects we are actually
        // interested in, for bookkeeping purposes:
        
        let identifiersBeingObserved = observees.map {
            $0.identifier
        }
        stats.identifiersBeingObserved = identifiersBeingObserved
        print("identifiersBeingObserved: \(identifiersBeingObserved.joined(separator: "  "))")
        
        
        let addressesBeingObserved: [String] = observees.map {
            let p: UnsafeMutableRawPointer = Unmanaged.passUnretained($0).toOpaque()
            return "\(p)"
        }
        stats.addressesBeingObserved = addressesBeingObserved
        print("addressesBeingObserved: \(addressesBeingObserved.joined(separator: "  "))")

        // Next, have each Observee instance post a notification defined number of times:
        
        let sendCount = 1000
        
        for _ in 1...sendCount {
            for o in observees {
                o.notifyObservers()
            }
        }
        
        var numberOfNotificationsSentByObservedObjects = observees.count * sendCount
        
        XCTAssert(stats.allNotificationsSent.count == numberOfNotificationsSentByObservedObjects)
        XCTAssert(stats.notificationsReceivedByObservers.count == numberOfNotificationsSentByObservedObjects)
        
        
        for _ in 1..<observees.count {
            observees.remove(at: 0)
        }
        
        let extraSendCount = 1000
        
        for _ in 1...extraSendCount {
            for o in observees {
                o.notifyObservers()
            }
        }
        observees.remove(at: 0) // remove our last observee (causing its deallocation)
        
        XCTAssert(stats.deinitedObservees.count == identifiersBeingObserved.count)
        
        numberOfNotificationsSentByObservedObjects += extraSendCount
        XCTAssert(stats.allNotificationsSent.count == numberOfNotificationsSentByObservedObjects)
        XCTAssert(stats.notificationsReceivedByObservers.count == numberOfNotificationsSentByObservedObjects)

        
        let expectedReceiveCount = Bug3293160Test.statistician.notificationsReceivedByObservers.count
        print("expectedReceiveCount: \(expectedReceiveCount)")
        
        let spuriousNotificationCount = 10000 //_000
        
        for _ in 1...spuriousNotificationCount {
            // The point here is to flood the world with Observee objects, so that we eventually allocate
            // additional Observee instances at the same memory address used by one of now-deallocted
            // original Observee instances used above.
            //
            // This is imprecise and often doesn't occur unless we run this loop 100,000 or more times...
            // but sometimes it happens when we loop only 100 times.
            //
            // It is also sensitive to whatever else is going on on the local machine -- stopping at a breakpoint
            // seems to affect it; printing out messages seems to affect it;
            let bozo = Observee()
            bozo.notifyObservers()
        }
        
        let expectedTotalNotificationCount = numberOfNotificationsSentByObservedObjects + spuriousNotificationCount;
        let actualTotalNotificationCount   = stats.allNotificationsSent.count
        
        XCTAssertEqual(actualTotalNotificationCount, expectedTotalNotificationCount)
        
        let actualReceiveCount = stats.notificationsReceivedByObservers.count
        
        XCTAssertNotEqual(expectedReceiveCount, actualReceiveCount, "Hmm. So, no spurious notifications were received, but that does not *really* prove that a workaround for 3293160 is unnecessary... change sendCount to 1_000_000 and try again. If this test still fails, then maybe the issue is solved in NotificationCenter (?).")
        
        print(stats)
    }
    
    
    // MARK: helper classes
    
    class Statistician: CustomStringConvertible {

        var initedObservees: [String] = []
        var deinitedObservees: [String] = []
        var byIdentifier: [String:Int] = [:]
        var allNotificationsSent: [String] = []
        var notificationsSentByObservedObjects: [String] = []
        var notificationsReceivedByObservers: [String] = []
        var blockInvocations: [String] = []
        
        var identifiersByAddress: [String:Set<String>] = [:]
          // We want to get notifications for only the objects we observe (and not
          // objects at the same address that are created later, after our original
          // observed objects have been deallocated. So at the end, we will look at
          // this.
        
        var identifiersBeingObserved: [String] = []
        var addressesBeingObserved: [String] = []
        
        
        func recordInit(_ observee: Observee) {
            
            initedObservees.append("init:\(observee.identifier)")
        }

        func recordDeinit(_ observee: Observee) {
            
            deinitedObservees.append("deinit:\(observee.identifier)")
        }
        
        func recordSend(_ observee: Observee) {
            
            let key           = observee.identifier
            let oldCount      = byIdentifier[key] ?? 0
            byIdentifier[key] = oldCount + 1
            
            allNotificationsSent.append(key)
            
            if identifiersBeingObserved.contains(key) {
                notificationsSentByObservedObjects.append(key)
            }
        }
        
        func recordReceive(_ notification: Notification) {
            
            var identifier = "error bro no object"
            var objectAddress = "error no address"
            
            if let object = notification.object as? Observee {
                identifier = object.identifier
                let p: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
                objectAddress = "\(p)"
            }

            notificationsReceivedByObservers.append(identifier)
            
            var identifiersForThisAddress = identifiersByAddress[objectAddress] ?? []
            identifiersForThisAddress.insert(identifier)
            identifiersByAddress[objectAddress] = identifiersForThisAddress
        }
        
        func recordBlockInvocation(notification: Notification) {
            var identifier = "error bro no object"
            var objectAddress = "error no address"
            
            if let object = notification.object as? Observee {
                identifier = object.identifier
                let p: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
                objectAddress = "\(p)"
            }
            blockInvocations.append("\(identifier):\(objectAddress)")
        }
        
        var identifiesReceivedForEachObservedAddress: String {
            var result = ""
            for addr in addressesBeingObserved {
                let identifiers = identifiersByAddress[addr]
                //result += "\(addr): [\(identifiers?.joined(separator: ",  "))]"
                result += "\(addr): \(identifiers?.count ?? -1)\n"
            }
            return result
        }

        public var description: String {

            return [
                "",
                "*** STATISTICS: ***",
                "blockInvocations: \(blockInvocations.count)",
                "allNotificationsSent.count: \(allNotificationsSent.count)",
                "notificationsSentByObservedObjects.count: \(notificationsSentByObservedObjects.count)",
                "notificationsReceivedByObservers.count: \(notificationsReceivedByObservers.count)",
                "number of identifiers received for each observed address:",
                identifiesReceivedForEachObservedAddress,
                "*******************"
                

            ].joined(separator: "\n\n")
        }

    }
    
    
    /// Observee is a simple object that posts notifications others can observe.
    
    class Observee {
        
        let identifier = UUID().uuidString
        
        init() {
            Bug3293160Test.statistician.recordInit(self)
        }
        
        deinit {
            Bug3293160Test.statistician.recordDeinit(self)
        }
        
        func notifyObservers() {
            Bug3293160Test.statistician.recordSend(self)
            NotificationCenter.default.post(name: .masonTest, object: self)
        }
    }
    
    
    /// Observer is a very simple class with one purpose: sit around and wait for notifications. When he gets one, he tells the global statistician to record it.
    
    class Observer {
        
        @objc func receive(notification: Notification) {
            Bug3293160Test.statistician.recordReceive(notification )
        }
    }

}


extension Notification.Name {
    static let masonTest = Notification.Name("masonTest")
}
