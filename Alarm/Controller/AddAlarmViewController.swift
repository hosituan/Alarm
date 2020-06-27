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
    var titleNav: String = ""
    var objectEdit: NSManagedObject = NSManagedObject()

    @IBOutlet var navAdd: UINavigationItem!
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let selectedDate: String = dateFormater.string(from: timePicker.date)
        let type = "Alarm"
        let active = false
        if (titleNav == "Add Alarm") {
            self.addData(time: selectedDate, type: type, active: active)
            DataManager.shared.firstVC.loadData()
            DataManager.shared.firstVC.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        else if (titleNav == "Edit Alarm") {
            self.updateData(time: selectedDate, type: type, active: active, object: objectEdit)
            DataManager.shared.firstVC.loadData()
            DataManager.shared.firstVC.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        
    }
    @IBOutlet var timePicker: UIDatePicker!

    @IBOutlet var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.timeStyle = .short
        navAdd.title = titleNav
        
        
        //let selectedDate: String = dateFormater.string(from: timePicker.calendar)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    func addData(time: String, type: String, active: Bool) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
      }
      // 1
      let managedContext = appDelegate.persistentContainer.viewContext
      
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
    
    func updateData(time: String, type: String, active: Bool, object: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alarm")
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            for data in tasks {
                if (data == object) {
                    data.setValue(time, forKey: "time")
                    data.setValue(type, forKey: "type")
                    data.setValue(active, forKey: "active")
                    
                }
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
