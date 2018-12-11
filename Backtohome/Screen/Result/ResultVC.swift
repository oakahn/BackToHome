//
//  ResultVC.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

protocol ResultVCProtocol: BaseVCProtocol {
    
}

class ResultVC: BaseVC {
    
    var nameText: String?
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameText
        isHideTitle = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ResultVC: ResultVCProtocol {
    
}

