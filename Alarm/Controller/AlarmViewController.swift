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
        viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    @IBAction func changedSwitch(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview?.superview as? AlarmTableViewCell else {
            return
        }

        let indexPath = tableView.indexPath(for: cell)
        print(indexPath!.row)
        let alarm = alarms[indexPath!.row]
        updateData(time: alarm.value(forKeyPath: "time") as! String, type: alarm.value(forKeyPath: "type") as! String, active: cell.statusSwitch.isOn )
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
        let alert = UIAlertController(title: "Message", message: "\(String(describing: alarm.value(forKeyPath: "time"))),\(String(describing: alarm.value(forKeyPath: "type"))), \(String(describing: alarm.value(forKeyPath: "active")))", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    func tableView(_ tableView: UITableView, UIContextualAction indexPath: IndexPath) {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, actionPerformed) in
            //self.mainArray.remove(at: indexPath.row)
            //self.tableData.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func updateData(time: String, type: String, active: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Alarm")
        fetchRequest.predicate = NSPredicate(format: "time", time)
        do {
            let update = try! managedContext.fetch(fetchRequest)
            let objectUpdate = update[0] as! NSManagedObject
            objectUpdate.setValue(type, forKey: "type")
            objectUpdate.setValue(active, forKey: "active")
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
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
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      //1
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


}
