//
//  1.Setting.swift
//  knCollection
//
//  Created by Ky Nguyen Coinhako on 7/3/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

var appSetting = AppSetting()
struct AppSetting {
    var user: CTUser? 
    var token: String? {
        get { return UserDefaults.get(key: "token") as String? }
        set {
            didLogin = newValue != nil
            UserDefaults.set(key: "token", value: newValue)
        }
    }
    var didLogin: Bool {
        get { return UserDefaults.get(key: "didLogin") as Bool? ?? false }
        set { UserDefaults.set(key: "didLogin", value: newValue) }
    }
    var standardCalory: Int {
        get { return UserDefaults.get(key: "standardCalory") as Int? ?? 200 }
        set { UserDefaults.set(key: "standardCalory", value: newValue) }
    }
}

let padding: CGFloat = 24
