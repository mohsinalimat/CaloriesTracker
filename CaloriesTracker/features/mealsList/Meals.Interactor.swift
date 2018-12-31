//
//  Meals.Interactor.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/26/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

extension CTMealsDashboard {
    func didGetUpcomingMeals(_ meals: [CTMeal]) {
        upcomingMeals = meals
        didLoadUpcomingMeals = true
        checkData()
    }
    
    func checkData() {
        guard didLoadPreviousMeals && didLoadUpcomingMeals else { return }
        let isEmpty = upcomingMeals.isEmpty && datasource.isEmpty
        if isEmpty {
            ui.greetingView.backgroundColor = .white
            ui.stateView.state = .empty
        } else {
            ui.greetingView.backgroundColor = .bg
            ui.stateWrapper.removeFromSuperview()
            tableView.reloadData()
            ui.upcomingStack.layoutIfNeeded()
        }
    }
    
    func didGetUpcomingMealsFail(_ err: knError) {
        showState(.error)
        CTMessage.showError(err.message ?? "Server error")
    }
    
    func didGetPreviousMeals(_ meals: [CTMeal]) {
        datasource = meals
        didLoadPreviousMeals = true
        checkData()
    }
    
    func didGetPreviousMealsFail(_ err: knError) {
        showState(.error)
        CTMessage.showError(err.message ?? "Server error")
    }
    
    func showState(_ state: knState) {
        ui.stateView.state = state
    }
}

extension CTMealsDashboard {
    class Interactor {
        func getUpcomingMeals() {
            if hasConnection() == false { return }
            CTGetUpcomingMealsWorker(successAction: output?.didGetUpcomingMeals,
                                     failAction: output?.didGetUpcomingMealsFail).execute()
        }
        
        func hasConnection() -> Bool {
            if Reachability.isConnected == false {
                output?.showState(.noInternet)
                return false
            }
            output?.showState(.loading)
            return true
        }
        func getPreviousMeals() {
            if hasConnection() == false { return }
            CTGetPreviousMealsWorker(successAction: output?.didGetPreviousMeals,
                                     failAction: output?.didGetPreviousMealsFail).execute()
        }
        
        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = CTMealsDashboard
}
