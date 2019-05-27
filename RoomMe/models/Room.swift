//
//  Room.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/22/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import Foundation
import Firebase

public class Room {
    var postCreationDate:Timestamp?
    var userName:String?
    var userEmail:String?
    var userPhoneNumber:Int?
    var owningState:String?
    var lat:Double?
    var long:Double?
    var apartmentNumber:Int?
    var numberOfRoomBeds:Int?
    var numberOfRoommates:Int?
    var roommatesGender:String?
    var allowedGender:String?
    var country:String?
    var availabilityDate:Timestamp?
    var petsAllowed:Bool?
    var airConditioned:Bool?
    var numberOfBathrooms:Int?
    var tvAvailable:Bool?
    var fridgeAvailable:Bool?
    var cookerAvailable:Bool?
    var wifiAvailable:Bool?
    var landlineAvailable:Bool?
    var cableChannelsAvailable:Bool?
    var monthlySubscriptionFees:Double?
    var monthlyRent:Double?
    var insuranceFees:Double?

    
    public init? (data:[String:Any]){
        
        
        self.postCreationDate = data[Constants.postCreationDate] as? Timestamp
        self.userName = data[Constants.userName] as? String
        self.userPhoneNumber = data[Constants.userPhoneNumber] as? Int
        self.userEmail = data[Constants.userEmail] as? String
        self.owningState = data[Constants.owningState] as? String
        self.lat = data[Constants.lat] as? Double
        self.long = data[Constants.long] as? Double
        self.apartmentNumber = data[Constants.apartmentNumber] as? Int
        self.numberOfRoommates = data[Constants.numberOfRoommates] as? Int
        self.numberOfRoomBeds = data[Constants.numberOfRoomBeds] as? Int
        self.roommatesGender = data[Constants.roommatesGender] as? String
        self.allowedGender = data[Constants.allowedGender] as? String
        self.country = data[Constants.country] as? String
        self.availabilityDate = data[Constants.availabilityDate] as? Timestamp
        self.petsAllowed = data[Constants.petsAllowed] as? Bool
        self.airConditioned = data[Constants.airConditioned] as? Bool
        self.numberOfBathrooms = data[Constants.numberOfBathrooms] as? Int
        self.tvAvailable = data[Constants.tvAvailable] as? Bool
        self.fridgeAvailable = data[Constants.fridgeAvailable] as? Bool
        self.cookerAvailable = data[Constants.cookerAvailable] as? Bool
        self.wifiAvailable = data[Constants.wifiAvailable] as? Bool
        self.landlineAvailable = data[Constants.landlineAvailable] as? Bool
        self.cableChannelsAvailable = data[Constants.cableChannelsAvailable] as? Bool
        self.monthlySubscriptionFees = data[Constants.monthlySubscribtionFees] as? Double
        self.monthlyRent = data[Constants.monthlyRent] as? Double
        self.insuranceFees = data[Constants.insuranceFees] as? Double
        
        
        
    }
    
}
