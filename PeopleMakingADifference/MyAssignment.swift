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

   /*
   func randomPic() -> String
   {
      var randNum = Int(arc4random_uniform(5) + 1)
      switch (randNum)
      {
         case 1:
            return "PMDPic1.jpg"
         case 2:
            return "PMDPic2.jpg"
         case 3:
            return "PMDPic3.jpg"
         case 4:
            return "PMDPic4.jpg"
         case 5:
            return "PMDPic5.jpg"
         default:
            return "PMDPic1.jpg"
      }
   }
   */
   
   var headerPic = "PMDPic1.jpg"
   var headerMes = "My Assignment"
   
   @IBOutlet var tableview: UITableView!
    
   var pantone: UIColor = UIColor(red: 0, green: 134/255.0, blue: 117/255.0, alpha: 0)
  
   //an array of string variables called "items"
   var items: [String] = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
  
   func loadData(vName: String, eName: String, ciTime: String, sSTime: String, sETime: String, vTask : String, rAss : String, sSize: String, lunch:String) -> Void
   {
      
      self.items = ["Volunteer Name: \n\n" + vName, "Event Name: \n\n" + eName, "Check In Time: \n\n" + ciTime, "Arrival Time: \n\n" + sSTime, "Departure Time: \n\n" + sETime, "Task: \n\n" + vTask, "Room Assignment: \n\n" + rAss, "Shirt Size: \n\n" + sSize, "Lunch: \n\n" + lunch]
      
      tableview.reloadData()
   }
   
   
   func clearInfo() -> Void
   {
      self.items = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
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
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count + 1
    }
   
   
    //This function handles the height of each cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
    
      if(indexPath.row == 0)
      {
         return 270
      }
      else
      {
         return UITableViewAutomaticDimension
      }

    }
   
   
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
   
        //If it is the first row of the tableview, then return a myAssignmentHeadCell instead of a regular UITableViewCell
        if(indexPath.row == 0)
        {
         
            let cell: myAssignmentHeadCell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as myAssignmentHeadCell
            //Class function to set cell
            cell.setHeaderCell(headerPic, message: headerMes)
            tableView.backgroundColor = pantone
            tableView.rowHeight = UITableViewAutomaticDimension
            cell.backgroundColor = UIColor.clearColor()
            return cell
        
        }
      
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = items[indexPath.row - 1]
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        tableView.backgroundColor = pantone
        tableView.rowHeight = UITableViewAutomaticDimension
        cell.backgroundColor = UIColor.clearColor()
        return cell
      
    }
   
   

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
   {
      println("You selected cell \(items[indexPath.row])!")

   }

}

