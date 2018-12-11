//
//  MainRouter.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import Foundation

class MainRouter: BaseRouter {
    
    func redirectToResult(name: String) {
        guard let vc = getViewController(storyboardName: self.result) as? ResultVC else {
            return
        }
        vc.nameText = name
        redirectTo(viewController: vc)
    }
}
