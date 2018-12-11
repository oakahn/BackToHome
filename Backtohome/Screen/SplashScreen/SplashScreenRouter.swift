//
//  SplashScreenRouter.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import Foundation

class SplashScreenRouter: BaseRouter {
    
    func redirectToMainPage() {
        redirectTo(name: self.main)
    }
    
}
