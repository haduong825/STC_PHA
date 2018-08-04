//
//  UIStoryboard+Navigation.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import UIKit
import SlideMenuControllerSwift

extension UIStoryboard {
    
    func loginStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Login", bundle: .main)
    }
    
    func menuStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Menu", bundle: Bundle.main)
    }
    
    func homeStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }
    
    func expenditureProvincialStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "ExpenditureProvincial", bundle: Bundle.main)
    }
    
    func revenueDistrictStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "RevenueDistrict", bundle: .main)
    }
    
    func revenueProvincialStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "RevenueProvincial", bundle: .main)
    }
    
    func revenueSymmetricialStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "RevenueSymmetrical", bundle: .main)
    }
    
    func expenditureBudgetStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "ExpenditureBudget", bundle: .main)
    }
    
    func estimateCollectStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "EstimateCollect", bundle: .main)
    }
    
    func estimateOutStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "EstimateOut", bundle: .main)
    }
    
    func editURLStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "EditURL", bundle: .main)
    }
    
    func instantiateNavLogin() -> UIViewController {
        return loginStoryboard().instantiateViewController(withIdentifier: "navLogin")
    }
    
    func instantiateNavHome() -> SlideMenuController {
        let nav = homeStoryboard().instantiateViewController(withIdentifier: "navHome") as! UINavigationController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateNavExpenditureProvincial() -> SlideMenuController {
        let nav = expenditureProvincialStoryboard().instantiateViewController(withIdentifier: "tabExpenditureProvincial") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabRevenueDistrict() -> SlideMenuController {
        let nav = revenueDistrictStoryboard().instantiateViewController(withIdentifier: "tabRevDis") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabRevenueProvincial() -> SlideMenuController {
        let nav = revenueProvincialStoryboard().instantiateViewController(withIdentifier: "TabRevProViewController") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabRevenueSymmetrical() -> SlideMenuController {
        let nav = revenueSymmetricialStoryboard().instantiateViewController(withIdentifier: "TabRevSymViewController") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabExpenditureBudget() -> SlideMenuController {
        let nav = expenditureBudgetStoryboard().instantiateViewController(withIdentifier: "TabExpBudViewController") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabEstimateCollect() -> SlideMenuController {
        let nav = estimateCollectStoryboard().instantiateViewController(withIdentifier: "tabEstimateCollect") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateTabEstimateOut() -> SlideMenuController {
        let nav = estimateOutStoryboard().instantiateViewController(withIdentifier: "TabEstOutViewController") as! UITabBarController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
    func instantiateNAVEditURL() -> SlideMenuController {
        let nav = editURLStoryboard().instantiateViewController(withIdentifier: "navEdit") as! UINavigationController
        let menu = menuStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return SlideMenuController(mainViewController: nav, leftMenuViewController: menu)
    }
    
}
