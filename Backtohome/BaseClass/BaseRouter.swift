//
//  BaseRouter.swift
//  SavingMoney
//
//  Created by chayarak on 1/6/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import Foundation
import UIKit


class BaseRouter {
    let home = "Home"
    let homeTab = "HomeTabBar"
    let historyMember = "HistoryMember"
    
    let routes: [String: String] = [
        "Home": "HomeVC",
        "HomeTabBar": "HomeTabBarVC",
        "HistoryMember": "HistoryMemberVC"
    ]
    
    internal weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func present(destinationViewControllerName: String) {
        let destinationViewController = getViewController(storyboardName: destinationViewControllerName)
        let navigationControll = UINavigationController(rootViewController: destinationViewController)
        self.viewController?.present(navigationControll, animated: true, completion: nil)
    }
    
    func present(viewController: UIViewController) {
        let navigationControll = UINavigationController(rootViewController: viewController)
        self.viewController?.present(navigationControll, animated: true, completion: nil)
    }
    
    func redirectTo(name: String) {
        let viewController = getViewController(storyboardName: name)
        redirectTo(viewController: viewController)
    }
    
    func getViewController(storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let storyboardId = routes[storyboardName] else {
            return UIViewController()
        }
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return viewController
    }
    
    func redirectTo(viewController: UIViewController) {
        guard let navigationController = self.viewController?.navigationController else {
            self.viewController?.present(viewController, animated: true, completion: nil)
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func returnTo(viewController: Swift.AnyClass) {
        
        guard let navigationController = self.viewController?.navigationController else {
            self.viewController?.dismiss()
            return
        }
        
        for element in navigationController.viewControllers {
            if element.isKind(of: viewController) {
                navigationController.popToViewController(element, animated: true)
                break
            }
        }
    }
}

extension UIViewController {
    
    func dismiss()  {
        guard let navigationController = self.navigationController else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        navigationController.popViewController(animated: true)
    }
    
}
