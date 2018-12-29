//
//  DeleteUserWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
struct CTDeleteUserWorker {
    private var userId: String
    private var successAction: (() -> Void)?
    private var failAction: ((knError) -> Void)?
    init(userId: String, successAction: (() -> Void)?, failAction: ((knError) -> Void)?) {
        self.userId = userId
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = CTDataBucket.getUserDb()
        db.child(userId).child("is_deleted").setValue(true)
        successAction?()
    }
}

