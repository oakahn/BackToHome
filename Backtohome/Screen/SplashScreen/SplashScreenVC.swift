//
//  SplashScreenVC.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

protocol SplashScreenProtocol: BaseVCProtocol {
    
}

class SplashScreenVC: BaseVC {
    
    var timer = Timer()
    var countdown = 2
    lazy var router = SplashScreenRouter(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLoading(message: "", hasBg: true)
        runTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        countdown -= 1
        setup()
    }
    
    func setup() {
        if countdown == 0 {
            hideLoading()
            router.redirectToMainPage()
        }
    }
}

extension SplashScreenVC: SplashScreenProtocol {
    
}
