//
//  GetAllUsersWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/27/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct CTGetAllUsersWorker {
    private var successAction: (([CTUser]) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(successAction: (([CTUser]) -> Void)?, failAction: ((knError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let db = Helper.getUserDb()
        db.observeSingleEvent(of: .value) { (snapshot) in
            guard var raws = snapshot.value as? [String: AnyObject] else {
                self.failAction?(knError(code: "no_data"))
                return
            }
            if let myId = Auth.auth().currentUser?.uid {
                raws = raws.filter({ user in
                    let isActive = user.value["is_active"] as? Bool ?? true
                    let notMe = user.key != myId
                    return notMe && isActive
                })
            }
            
            var users = Array(raws.values).map({ return CTUser(raw: $0) })
            users.sort(by: { return ($0.name ?? "") < ($1.name ?? "") })
            self.successAction?(users)
        }
    }
}
