//
//  Others.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 3.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

// Array Extension
extension Array {
    mutating func rotate() -> Element? {
        guard let lastElement = popLast() else {
            return nil
        }
        insert(lastElement, at: 0)
        return lastElement
    }
}

// Weak

struct Weak<Object: AnyObject> {
    weak var value: Object?
}

// SubscribableValue

struct SubscribableValue<T> {
    private typealias Subscription = (object: Weak<AnyObject>, handler: (T) -> Void)
    private var subscriptions: [Subscription] = []
    var value: T {
        didSet {
            for (object, handler) in subscriptions where object.value != nil {
                handler(value)
            }
        }
    }
    init(value: T) {
        self.value = value
    }
    mutating func subscribe(_ object: AnyObject, using handler: @escaping (T) -> Void) {
        subscriptions.append((Weak(value: object), handler))
        cleanupSubscriptions()
    }
    private mutating func cleanupSubscriptions() {
        subscriptions = subscriptions.filter({ entry in
            return entry.object.value != nil
        })
    }
}

