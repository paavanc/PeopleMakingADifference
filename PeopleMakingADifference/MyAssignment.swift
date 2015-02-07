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

   
   @IBOutlet var tableview: UITableView!
   
   //This will select a random PMD Event pic everytime the app opens
   var headerPic = "PMDPic" + String(arc4random_uniform(5) + 1) + ".jpg"
   var headerMes = "My Assignment"

   /////MANAGES WHAT CONTENT OF TABLEVIEW CELLS/////
   //UITableView.cellForRowAtIndexPath obtains its content from this array "items"
   var items: [String] = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
  
   //This method adds the data from the PMDVolunteer class instantiated at CheckIn to the item array
   func loadData(vName: String, eName: String, ciTime: String, sSTime: String, sETime: String, vTask : String, rAss : String, sSize: String, lunch:String) -> Void
   {
      
      self.items = ["Volunteer Name: \n\n" + vName, "Event Name: \n\n" + eName, "Check In Time: \n\n" + ciTime, "Arrival Time: \n\n" + sSTime, "Departure Time: \n\n" + sETime, "Task: \n\n" + vTask, "Room Assignment: \n\n" + rAss, "Shirt Size: \n\n" + sSize, "Lunch: \n\n" + lunch]
      
      tableview.reloadData()
   }
   
   func clearInfo() -> Void
   {
      self.items = ["Volunteer Name", "Event Name", "Check In Time", "Arrival Time", "Departure Time", "Task", "Room Assignment", "Shirt Size", "Lunch"]
   }
   /////MANAGES WHAT CONTENT OF TABLEVIEW CELLS/////
   
   
   override func viewDidLoad()
   {
      
      super.viewDidLoad()
      
    
   }
   
    //This method is called upon successful check in from CheckIn ViewController
    func successCheckInPopUp() -> Void
    {
        //To create a pop up alert message
        var alertMessage = UIAlertView(title: nil, message: "Thank you! You have been successfully checked in.", delegate: nil, cancelButtonTitle: "Let's Get Started!")
        alertMessage.show()
    }
   
    /////UITableView PROTOCOL METHODS/////
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
   
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
   
        //If it is the first row of the tableview, then return a myAssignmentHeadCell instead of a regular UITableViewCell
        if(indexPath.row == 0)
        {
         
            let cell: myAssignmentHeadCell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as myAssignmentHeadCell
            //FIND A WAY TO PASS THE VOLUNTEERS FIRST NAME
            cell.setHeaderCell(headerPic, message: headerMes, welcome: "VolunteerName")
            cell.backgroundColor = UIColor.clearColor()
            return cell
        
        }
      
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = items[indexPath.row - 1]
        cell.textLabel?.numberOfLines = 0;
        //set the text color to PMD's logo color, pantone
        cell.textLabel?.textColor = UIColor(red: 25.0/255.0, green: 94.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        tableView.backgroundColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
      
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
   /////UITableView PROTOCOL METHODS/////
   

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
   {
      println("You selected cell \(items[indexPath.row])!")

   }

}

