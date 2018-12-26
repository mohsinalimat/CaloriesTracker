//
//  LogoutWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct CTLogoutWorker {
    init() { }
    
    func execute() {
        appSetting.didLogin = false
        appSetting.standardCalories = appSetting.DEFAULT_CALORIES
        try? Auth.auth().signOut()
    }
}
