//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    let dateFormater: DateFormatter = DateFormatter()
    var allAlarm = AlarmData()

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let selectedDate: String = dateFormater.string(from: timePicker.date)
        let type = "Alarm"
        let actiave = true
        allAlarm.list.append(AlarmItem(alarmTime: selectedDate, alarmType: type, activeStatus: actiave))
        
    }
    @IBOutlet var timePicker: UIDatePicker!

    @IBOutlet var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.timeStyle = .short
        //let selectedDate: String = dateFormater.string(from: timePicker.calendar)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
