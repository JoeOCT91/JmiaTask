//
//  NotificationName.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 19/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let flagsChanged = Notification.Name("FlagsChanged")
}

@objc public extension NSNotification {
    static var flagsChanged: NSString { return "FlagsChanged" }
}
