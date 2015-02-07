//
//  CheckIn.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 10/26/14.
//  Copyright (c) 2014 Brian Tan. All rights reserved.
//

import UIKit
import Parse

class CheckIn: UIViewController
{
   //PMD EVENT NAME, CAN BE CHANGED HERE TO OBTAIN DATA FROM SPECIFIC PARSE DATASHEET
   var pmdEventName = "SchoolCleaning"
   

   //UIViews
   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var roomcodeTextField: UITextField!
   @IBOutlet weak var timeLabel: UILabel!

   override func viewDidLoad()
   {
      super.viewDidLoad()


    
   }
    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    
   //Exits keyboard on "done" in Room Code textfield
   
   @IBAction func roomTextFieldEditingDidEnd(sender: AnyObject)
   {
      (sender as UITextField).resignFirstResponder();
   
   }
   
   //Exits keyboard on "done" in Email textfield
   
   @IBAction func emailTextFieldEditingDidEnd(sender: AnyObject)
   {
      //cast the sender to a UITextField b/c thats what we are working with
      (sender as UITextField).resignFirstResponder();
   }
   
   func clearTextFields() -> Void
   {
      emailTextField.text = nil;
      roomcodeTextField.text = nil;
   }
    
    func getCurrentTimeDate() -> NSDate
    {
        return NSDate().dateByAddingTimeInterval(-1*60*60*5)
    }

   
   func getCurrentTime() -> String
   {
      //create variables that hold the current date's info
      let currentDate = NSDate();
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: currentDate)
      var hour = components.hour
      let minute = components.minute
      
      var timeOfDay = "AM"
      if(hour > 11)
      {
         //Make it a 12 Hour Time display
         if(hour > 12)
         {
            hour = hour - 12;
         }
         
         //If the hour is past 12, change timeofDay to PM
         timeOfDay = " PM"
      }
      //24 hour clock displays 12 AM as 0:00, so change to display 12:00
      if(hour == 0)
      {
         hour = 12;
      }
      
      var hourText = String(hour)
      var minText = String(minute)
      if(minute < 10)
      {
         minText = "0" + minText
      }
      
      var checkedInAt = hourText + ":" + minText + timeOfDay
      return checkedInAt
   
   }
   
   
   //Submit button found on Check In page
   @IBAction func checkInSubmit(sender: AnyObject)
   {
      //check the Room Code
        var query = PFQuery(className:pmdEventName)
        query.whereKey("roomCode", equalTo:roomcodeTextField.text)
        query.getFirstObjectInBackgroundWithBlock 
        {
            (object: PFObject!, error: NSError!) -> Void in
            //IF THE ROOM CODE MATCHES
            if object != nil 
            {
               
                //check if the email exists
                var queryTwo = PFQuery(className:self.pmdEventName)
                queryTwo.whereKey("Email", equalTo:self.emailTextField.text)
                queryTwo.getFirstObjectInBackgroundWithBlock 
                {
                    (object: PFObject!, error: NSError!) -> Void in
                    //THE EMAIL EXISTS
                    if object != nil 
                    {
                       	// SAVE THE ARRIVAL TIME TO DATABASE
                        var timeUpdate = PFObject(className:self.pmdEventName)
                        var query = PFQuery(className:self.pmdEventName)
                        query.getObjectInBackgroundWithId(object.objectId) 
                        {
                            (timeUpdate: PFObject!, error: NSError!) -> Void in
                            if error != nil 
                            {
                                NSLog("%@", error)
                            } 
                            else 
                            {
                                if (object["ArrivalTime"] == nil)
                                {
                                    timeUpdate["ArrivalTime"]=self.getCurrentTimeDate()
                                    timeUpdate.saveEventually()
                                }

                            }
                   	 	}
                        
                        
                     
                        //get tabBarController if there is one, and then change the view to index 1 (which is the second view controller
                        self.tabBarController?.selectedIndex = 1
                     
                        //Creates an instance of Volunteer which contain all area of info, grabbed from Parse
                        var pmdVolunteer = Volunteer(volunteerName: (object["Name"] as String), eventName: "PMD", checkInTime: self.getCurrentTime(), arrivalTime: (object["shiftStarts"] as String), departureTime: (object["shiftEnds"] as String), task: (object["Assignment"] as String), roomAssignment: (object["Room"] as String), shirtSize: (object["tShirtSize"] as String), lunch: (object["Lunch"] as String))
                     
                                    
                  	   //Calls the displayInfo method on the MyAssignments page
                        (self.tabBarController?.viewControllers?[1] as MyAssignment).loadData(pmdVolunteer.volunteerName, eName: pmdVolunteer.eventName, ciTime: pmdVolunteer.checkInTime, sSTime: pmdVolunteer.arrivalTime, sETime: pmdVolunteer.departureTime, vTask: pmdVolunteer.task, rAss: pmdVolunteer.roomAssignment, sSize: pmdVolunteer.shirtSize, lunch: pmdVolunteer.lunch)
                     
                        //Write a method or find the class method of UITextLabel to clear the info enter
                        //
                        //
                     
                     
                        //Calls the successfulCheckInPopUp method on the MyAssignments page
                        (self.tabBarController?.viewControllers?[1] as MyAssignment).successCheckInPopUp()
                        
                    }
                    //IF EMAIL DOESNT EXIST 
                    else
                    {
                        //To create a pop up alert message
                        var alertMessage = UIAlertView(title: "ERROR", message: "Invalid E-mail Address", delegate: nil, cancelButtonTitle: "Try Again")
                        alertMessage.show()
                       
                    }
            	}
            }
            //IF ROOM CODE DOESNT MATCH 
            else 
            {
                var alertMessage = UIAlertView(title: "ERROR", message: "Invalid Room Code", delegate: nil, cancelButtonTitle: "Try Again")
                alertMessage.show()
            }
           
         }
      }
   
   
      
}
