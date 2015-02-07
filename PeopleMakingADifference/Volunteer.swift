//
//  Volunteer.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 2/5/15.
//  Copyright (c) 2015 Brian Tan. All rights reserved.
//

import Foundation

class Volunteer
{
   //Volunteer member variables 
   var volunteerName = "Volunteer Name"
   var eventName = "Event Name"
   var checkInTime = "Check In Time"
   var arrivalTime = "Arrival Time"
   var departureTime = "Departure Time"
   var task = "Task"
   var roomAssignment = "Room Assignment"
   var shirtSize = "Shirt Size"
   var lunch = "Lunch"
   
   //The Volunteer initializer
   init(volunteerName: String, eventName: String, checkInTime: String, arrivalTime: String, departureTime: String, task: String, roomAssignment: String, shirtSize: String, lunch: String)
   {
      self.volunteerName = volunteerName
      self.eventName = eventName
      self.checkInTime = checkInTime
      self.arrivalTime = arrivalTime
      self.departureTime = departureTime
      self.task = task
      self.roomAssignment = roomAssignment
      self.shirtSize = shirtSize
      self.lunch = lunch
   }




};