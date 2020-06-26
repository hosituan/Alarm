//
//  ViewController.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        // Do any additional setup after loading the view.
    }


}

