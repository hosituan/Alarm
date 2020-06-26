//
//  AlarmViewController.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    public var allAlarm = AlarmData()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAlarm.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! AlarmTableViewCell
        cell.timeLabel?.text = allAlarm.list[indexPath.row].time
        cell.typeLabel?.text = allAlarm.list[indexPath.row].type
        cell.statusSwitch?.isOn = allAlarm.list[indexPath.row].active
        return cell
    }
    

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}
