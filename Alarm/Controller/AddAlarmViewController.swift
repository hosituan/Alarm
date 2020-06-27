//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit
import CoreData

class AddAlarmViewController: UIViewController {
    let dateFormater: DateFormatter = DateFormatter()
    var allAlarm = AlarmData()
    var alarms: [NSManagedObject] = []

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let selectedDate: String = dateFormater.string(from: timePicker.date)
        let type = "Alarm"
        let active = false
        self.save(time: selectedDate, type: type, active: active)
        DataManager.shared.firstVC.viewWillAppear(true)
        DataManager.shared.firstVC.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet var timePicker: UIDatePicker!

    @IBOutlet var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.timeStyle = .short
        
        //let selectedDate: String = dateFormater.string(from: timePicker.calendar)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    func save(time: String, type: String, active: Bool) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
      }
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
        let entity = NSEntityDescription.entity(forEntityName: "Alarm", in: managedContext)!
      
        let alarm = NSManagedObject(entity: entity, insertInto: managedContext)
      
      // 3
        alarm.setValue(time, forKeyPath: "time")
        alarm.setValue(type, forKeyPath: "type")
        alarm.setValue(active, forKeyPath: "active")
      
      // 4
      do {
        try managedContext.save()
        alarms.append(alarm)
      }
      catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
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
