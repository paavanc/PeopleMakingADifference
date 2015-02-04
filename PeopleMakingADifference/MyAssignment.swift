//
//  MyAssignment.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 10/26/14.
//  Copyright (c) 2014 Brian Tan. All rights reserved.
//

import UIKit

class MyAssignment: UIViewController, UITableViewDelegate//, UITableViewDataSource
{

   
   @IBOutlet weak var volunteerName: UILabel!
   @IBOutlet weak var eventName: UILabel!
   @IBOutlet weak var checkInTime: UILabel!
   @IBOutlet weak var shiftStartTime: UILabel!
   @IBOutlet weak var shiftEndTime: UILabel!
   @IBOutlet weak var volunteerTask: UILabel!
   @IBOutlet weak var roomAssignment: UILabel!
   @IBOutlet weak var tShirtSize: UILabel!
   @IBOutlet weak var lunchOrder: UILabel!
   @IBOutlet var tableview: UITableView!
    
   var pantone: UIColor = UIColor(red: 0, green: 134/255.0, blue: 117/255.0, alpha: 0)
  
  
   var items: [String] = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
  
   func displayInfo(vName: String, eName: String, ciTime: String, sSTime: String, sETime: String, vTask : String, rAss : String, sSize: String, lunch:String) -> Void
   {
      
      self.items = ["Volunteer Name: \n\n" + vName, "Event Name: \n\n" + eName, "Check In Time: \n\n" + ciTime, "Arrival Time: \n\n" + sSTime, "Departure Time: \n\n" + sETime, "Task: \n\n" + vTask, "Room Assignment: \n\n" + rAss, "Shirt Size: \n\n" + sSize, "Lunch: \n\n" + lunch]
      
      tableview.reloadData()
   }
   
   
   func clearInfo() -> Void
   {
      self.items = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
      //tableview.reloadData()
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
    
   }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func successCheckInPopUp() -> Void
    {
        //To create a pop up alert message
        var alertMessage = UIAlertView(title: nil, message: "Thank you! You have been successfully checked in.", delegate: nil, cancelButtonTitle: "Let's Get Started!")
        alertMessage.show()
    }
   /*
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
      return self.items.count;
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
   {
      var cell:UITableViewCell = self.tableview.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

      cell.textLabel?.text = self.items[indexPath.row]
      return cell
   }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        //let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cIdentifier, forIndexPath: indexPath) as UITableViewCell
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        tableView.backgroundColor = pantone
        cell.backgroundColor = UIColor.clearColor()
        
        
        return cell
    }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
   {
      println("You selected cell \(items[indexPath.row])!")

   }

}

