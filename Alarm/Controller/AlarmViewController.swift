//
//  AlarmViewController.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit
import CoreData

class AlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var alarms: [NSManagedObject] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func changedSwitch(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview?.superview as? AlarmTableViewCell else {
            return
        }

        let indexPath = tableView.indexPath(for: cell)
        print(indexPath!.row)
        let alarm = alarms[indexPath!.row]
        updateData(time: alarm.value(forKey: "time") as! String, type: alarm.value(forKey: "type") as! String, active: cell.statusSwitch.isOn )
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let alarm = alarms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! AlarmTableViewCell
        cell.timeLabel?.text = alarm.value(forKeyPath: "time") as? String
        cell.typeLabel?.text = alarm.value(forKeyPath: "type") as? String
        cell.statusSwitch?.isOn = ((alarm.value(forKeyPath: "active")) as? Bool)!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alarm = alarms[indexPath.row]
        self.deleteData(object: alarm)
        loadData()
        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, actionPerformed) in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let AddAlarmViewController = storyBoard.instantiateViewController(withIdentifier: "AddAlarm") as! AddAlarmViewController
            self.present(AddAlarmViewController, animated:true, completion:nil)
        }
         
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, actionPerformed) in
            let alarm = self.alarms[indexPath.row]
            self.deleteData(object: alarm)
        }
         
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    func deleteData(object: NSManagedObject)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alarm")
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            for data in tasks {
                if (data == object) {
                    managedObjectContext.delete(data)
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
        self.loadData()
        self.tableView.reloadData()
    }
    
    func updateData(time: String, type: String, active: Bool) {
      
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
        alarm.setValue(time, forKey: "time")
        alarm.setValue(type, forKey: "type")
        alarm.setValue(active, forKey: "active")
      
      // 4
      do {
        try managedContext.save()
        alarms.append(alarm)
      }
      catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
      }
    }
    func loadData()
    {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alarm")
        
        //3
        do {
          alarms = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataManager.shared.firstVC = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //1
        loadData()
    }


}
