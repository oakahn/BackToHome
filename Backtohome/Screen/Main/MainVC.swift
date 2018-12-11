//
//  MainVC.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

protocol MainVCProtocol: BaseVCProtocol {
    
}

class MainVC: BaseVC {
    
    lazy var presenter = MainPresenter(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.compare(UIImage(named: "") ?? UIImage())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainVC: MainVCProtocol {
    
}
