//
//  Register.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/20/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTRegisterCtr {
    func didRegister(user: CTUser) {
        ui.registerButton.setProcess(visible: false)
        appSetting.user = user
        appSetting.didLogin = true
        present(CTBigBoss())
    }
    
    func didRegisterFail(_ err: knError) {
        ui.registerButton.setProcess(visible: false)
        CTMessage.showError(err.message ?? "Can't register at this time", inSeconds: 5)
    }
}

extension CTRegisterCtr {
    class Interactor {
        func register(validation: Validation) {
            CTRegisterWorker(name: validation.name!,
                             email: validation.email!,
                             password: validation.password!,
                             success: output?.didRegister,
                             fail: output?.didRegisterFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTRegisterCtr
}

extension CTRegisterCtr {
    class Validation {
        var name: String?
        var email: String?
        var password: String?
        func validate() -> (isValid: Bool, error: String?) {
            let emptyMessage = "%@ can't be empty"
            if name == nil || name?.isEmpty == true {
                return (false, String(format: emptyMessage, "Name")) }
            if email == nil || email?.isEmpty == true {
                return (false, String(format: emptyMessage, "Email")) }
            if password == nil || password?.isEmpty == true  {
                return (false, String(format: emptyMessage, "Password")) }
            
            if email?.isValidEmail() == false {
                return (false, "Invalid email") }
            
            let passwordCheck = CTPasswordValidation()
            if passwordCheck.checkCharCount(password!) == false {
                return (false, "Password has at least 6 characters")
            }
            return (true, nil)
        }
    }
}
