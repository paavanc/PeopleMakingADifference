
import UIKit

class CheckOut: UIViewController, UITextFieldDelegate
{

   @IBOutlet weak var checkoutEmailTextField: UITextField!
   @IBOutlet weak var checkoutRoomTextField: UITextField!
   @IBOutlet weak var checkOutConfirmLabel: UILabel!
    
    
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
    
    //To create a pop up alert message
    var alertMessage = UIAlertView(title: "Warning", message: "Are you sure you want to check out?", delegate: nil, cancelButtonTitle: "Ok")
    alertMessage.show()
    
    checkoutEmailTextField.delegate = self
    checkoutRoomTextField.delegate = self
    
    
   }
   
    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == checkoutEmailTextField {
            textField.resignFirstResponder()
            checkoutRoomTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            
        }
        
        return true
    }
    
    
    
   func getCurrentTimeDate() -> NSDate
   {
      return NSDate().dateByAddingTimeInterval(-1*60*60*5)
   }
   
    func noArrivalTime() -> Void
    {
        //To create a pop up alert message
        var alertMessage = UIAlertView(title: nil, message: "Please check in first.", delegate: nil, cancelButtonTitle: "Ok")
        alertMessage.show()
    }
    
   func getCurrentTimeString() -> String
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
   
   
   @IBAction func checkOutButtonPressed(sender: AnyObject)
   {
    
    
    
    //check the Room Code
    var query = PFQuery(className:"SchoolCleaning")
    query.whereKey("roomCode", equalTo:checkoutRoomTextField.text)
    query.getFirstObjectInBackgroundWithBlock
        {
            (object: PFObject!, error: NSError!) -> Void in
            //IF THE ROOM CODE MATCHES
            if object != nil
            {
               
                //check if the email exists
                var queryTwo = PFQuery(className:"SchoolCleaning")
                queryTwo.whereKey("Email", equalTo:self.checkoutEmailTextField.text)
                queryTwo.getFirstObjectInBackgroundWithBlock
                    {
                        (object: PFObject!, error: NSError!) -> Void in
                        
                        //THE EMAIL EXISTS
                        if object != nil
                        {
                            
                            
                                    //THE ArrivalTime EXISTS
                                    if object["ArrivalTime"] != nil
                                    {
                            
                            
                           
                            // SAVE THE ARRIVAL TIME TO DATABASE
                            var timeUpdate = PFObject(className:"SchoolCleaning")
                            var query = PFQuery(className:"SchoolCleaning")
                            query.getObjectInBackgroundWithId(object.objectId)
                                {
                                    (timeUpdate: PFObject!, error: NSError!) -> Void in
                                    if error != nil
                                    {
                                        NSLog("%@", error)
                                    }
                                    else
                                    {
                                        let signInTime=timeUpdate["ArrivalTime"]
                                       
                                        let calendar = NSCalendar.currentCalendar()
                                        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: signInTime as NSDate)
                                        var hour = components.hour
                                        let minute = components.minute
                                       
                                       if (object["DepartureTime"] == nil){
                                        timeUpdate["DepartureTime"]=self.getCurrentTimeDate()
                                       
                                       
                                        let calendarOut = NSCalendar.currentCalendar()
                                        let componentsOut = calendarOut.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: self.getCurrentTimeDate())
                                        var hourOut = componentsOut.hour
                                        var minuteOut = Double(componentsOut.minute)
                                        var TotalHours = hourOut-hour
                                        var TotalMins = Double(minute) - Double(minuteOut)
                                       
                                       
                                        if TotalMins < 7{
                                            TotalMins=0
                                        }
                                       
                                        if (TotalMins > 7 && TotalMins < 15){
                                            TotalMins=15
                                        }
                                       
                                        if (TotalMins > 15 && TotalMins < 22){
                                            TotalMins = 15
                                        }
                                       
                                        if (TotalMins > 22 && TotalMins < 30){
                                            TotalMins = 30
                                        }
                                       
                                        if (TotalMins > 30 && TotalMins < 37){
                                            TotalMins = 30
                                        }
                                        if (TotalMins > 37 && TotalMins < 45){
                                            TotalMins = 45
                                        }
                                        if (TotalMins > 45 && TotalMins < 52){
                                            TotalMins = 45
                                        }
                                       
                                        if (TotalMins > 52 && TotalMins < 60){
                                            TotalMins = 0
                                            TotalHours=TotalHours + 1
                                        }
                                        var HourFraction=Double (TotalMins)
                                        //var HourFraction=Double (TotalMins)*(1.0/60.0)
                                        var TotalTimeNumber=Double(TotalHours) + HourFraction
                                        timeUpdate["TotalTime"]=TotalTimeNumber
                                        timeUpdate.saveEventually()
                                       
                                    }
                                        
                                       else {
                                        //To create a pop up alert message
                                        var alertMessage = UIAlertView(title: "Note", message: "You have already checked out!", delegate: nil, cancelButtonTitle: "Ok")
                                        alertMessage.show()
                                        
                                        }
                                        }
                            }
                           
                           
                           
                            //clears info on the MyAssignments View
                            (self.tabBarController?.viewControllers?[1] as MyAssignment).clearInfo()
                           
                             //clears info on the CheckIn View
                            (self.tabBarController?.viewControllers?[0] as CheckIn).clearTextFields()
                           
                           
                           //clears the info on the CheckOut View
                              self.checkoutEmailTextField.text = nil
                              self.checkoutRoomTextField.text = nil
                           
                            //get tabBarController if there is one, and then change the view to index 1 (which is the second view controller
                            self.tabBarController?.selectedIndex = 0
                            
                                        if (object["Reminders"]  != nil) {
                                            var reminderMessage=object["Reminders"] as String
                                        
                            var alertMessage = UIAlertView(title: nil, message: "You have been checked out. Thanks for participating!" + reminderMessage, delegate: nil, cancelButtonTitle: "OK")
                            alertMessage.show()
                            }
                                        
                                        else{
                                            
                                            var alertMessage = UIAlertView(title: nil, message: "You have been checked out. Thanks for participating!", delegate: nil, cancelButtonTitle: "OK")
                                            alertMessage.show()
                                        }
                                        
                                        
                           // self.checkOutConfirmLabel.text = "You Have Checked Out!"
                           
                        }
                                    else {
                                        //If someone has not checked in
                                        self.noArrivalTime()
                                    }
                
            }
                            //IF EMAIL DOESNT EXIST
                        else
                        {
                           
                            //self.checkOutConfirmLabel.text="Incorrect email address."
                            
                            var alertMessage = UIAlertView(title: "Error", message: "Incorrect email adress.", delegate: nil, cancelButtonTitle: "OK")
                            alertMessage.show()
                           
                        }
                }
            }
                //IF ROOM CODE DOESNT MATCH
            else
            {  
                //self.checkOutConfirmLabel.text = "Incorrect room code."
                
                var alertMessage = UIAlertView(title: "Error", message: "Incorrect room code.", delegate: nil, cancelButtonTitle: "OK")
                alertMessage.show()
            }
           
    }
    
    
   //END OF BUTTON PRESS FUNC
   }
}
