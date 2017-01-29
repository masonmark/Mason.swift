// ObserverRegistry.swift Created by mason on 2016-09-16. Copyright © 2016 MASON MARK (.COM). All rights reserved.

#if !os(Linux)

import Foundation

/// A helper class that an object can use to implement an API for observing it, via NotificationCenter, while making sure all its observers are deallocated when it is. (This prevents an observer object from potentially receiving spurious notifications in the future, after the object being observed is already long gone.)
///
/// This is the spiritual successor to FiveSpeedBug3293160Workaround, circa 2003. For historical details about that, refer to Bug3293160Tests.swift.

class ObserverRegistry {
    
    
    private var observers: [AnyObject] = []

    
    deinit {
        removeAllObservers()
    }

    
    func removeAllObservers() {
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        observers = []
    }
    
    
    /// Registers a block to be executed whenever the `obj` posts a notification `name` (if `name` is nil, the block will be executed regardless of notification name).
    ///
    /// Before returning the corresponding opaque observation token, the registry stores it, and will unregister it for all notifications when the registry itself is deallocated.
    
    func addObserver(name: NSNotification.Name? = nil, object: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void) -> NSObjectProtocol {
        
        let observer = NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: block)
        observers.append(observer)
        return observer
    }
        
}

#endif // !os(Linux)
