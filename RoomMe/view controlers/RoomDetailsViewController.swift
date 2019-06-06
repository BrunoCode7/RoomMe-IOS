//
//  RoomDetailsViewController.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/26/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import UIKit

class RoomDetailsViewController: UITableViewController {
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var phoneTitle: UILabel!
//    @IBOutlet weak var phoneValue: UILabel!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    @IBOutlet weak var owningStateTitle: UILabel!
    @IBOutlet weak var owningStateValue: UILabel!
    @IBOutlet weak var apartmentNumberTitle: UILabel!
    @IBOutlet weak var apartmentNumberValue: UILabel!
    @IBOutlet weak var numberOfBedsTitle: UILabel!
    @IBOutlet weak var numberOFBedsValue: UILabel!
    @IBOutlet weak var numberOfBathroomsTitle: UILabel!
    @IBOutlet weak var numberOfBathroomsValue: UILabel!
    @IBOutlet weak var numberOfRoommatesTitle: UILabel!
    @IBOutlet weak var numberOfRoommatesValue: UILabel!
    @IBOutlet weak var roommatesGenderTitle: UILabel!
    @IBOutlet weak var roommatesGenderValue: UILabel!
    @IBOutlet weak var allowedGenderTitle: UILabel!
    @IBOutlet weak var allowedGenderValue: UILabel!
    @IBOutlet weak var availabilityDateTitle: UILabel!
    @IBOutlet weak var availabilityDateValue: UILabel!
    @IBOutlet weak var petsAllowedTitle: UILabel!
    @IBOutlet weak var petsAllowedValue: UILabel!
    @IBOutlet weak var airConditionedTitle: UILabel!
    @IBOutlet weak var airConditionedValue: UILabel!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvValue: UILabel!
    @IBOutlet weak var fridgeTitle: UILabel!
    @IBOutlet weak var fridgeValue: UILabel!
    @IBOutlet weak var cookerTitle: UILabel!
    @IBOutlet weak var cookerValue: UILabel!
    @IBOutlet weak var wifiTitle: UILabel!
    @IBOutlet weak var wifiValue: UILabel!
    @IBOutlet weak var landlineTitle: UILabel!
    @IBOutlet weak var landlineValue: UILabel!
    @IBOutlet weak var subscribtionFeesTitle: UILabel!
    @IBOutlet weak var subscribtionFeesValue: UILabel!
    @IBOutlet weak var insuranceFeesTitle: UILabel!
    @IBOutlet weak var insuranceFeesValue: UILabel!
    @IBOutlet weak var monthlyRentTitle: UILabel!
    @IBOutlet weak var monthlyRentValue: UILabel!
    
    var room:Room!
    
    @IBOutlet weak var phoneNumberButtonOt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTheTable(room: room)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
 
    }
    
    private func populateTheTable(room:Room){
        nameTitle.text = "Full Name"
        if let name = room.userName{
            nameValue.text = name
        }
        phoneTitle.text = "Phone No."
        if let phoneNumber = room.userPhoneNumber{
            phoneNumberButtonOt.setTitle(phoneNumber, for: .normal)
        }
        emailTitle.text = "Email"
        if let email = room.userEmail{
            emailValue.text = email
        }
        owningStateTitle.text = "Owning State"
        if let state = room.owningState{
            owningStateValue.text = state
        }
        apartmentNumberTitle.text = "Apartment No."
        if let mApartmentNumber = room.apartmentNumber{
            apartmentNumberValue.text = String(mApartmentNumber)
        }
        numberOfBedsTitle.text = "No. Of Room Beds"
        if let mNumberOfBeds = room.numberOfRoomBeds{
            numberOFBedsValue.text = String(mNumberOfBeds)
        }
        numberOfBathroomsTitle.text = "No. of Bathrooms"
        if let mNumberOfBathrooms = room.numberOfBathrooms{
            numberOfBathroomsValue.text = String(mNumberOfBathrooms)
        }
        numberOfRoommatesTitle.text = "No. Of Roommates"
        if let mNumberOfRoommates = room.numberOfRoommates {
            numberOfRoommatesValue.text = String(mNumberOfRoommates)
        }
        roommatesGenderTitle.text = "Roommates Gender"
        if let mRoommatesGender = room.roommatesGender{
            roommatesGenderValue.text = mRoommatesGender
        }
        allowedGenderTitle.text = "Allowed Gender"
        if let mAllowedGender = room.allowedGender{
            allowedGenderValue.text = mAllowedGender

        }
        availabilityDateTitle.text = "Available From"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd,yyyy"
        
        availabilityDateValue.text = "\(dateFormater.string(from: room.availabilityDate!.dateValue()))"
        petsAllowedTitle.text = "Pets Allowed"
        petsAllowedValue.text = boolToYesNo(value: room.petsAllowed!)
        airConditionedTitle.text = "Air Conditioned"
        airConditionedValue.text = boolToYesNo(value: room.airConditioned!)
        tvTitle.text = "TV Available"
        tvValue.text = boolToYesNo(value: room.tvAvailable!)
        fridgeTitle.text = "Fridge Available"
        fridgeValue.text = boolToYesNo(value: room.fridgeAvailable!)
        cookerTitle.text = "Cooker Available"
        cookerValue.text = boolToYesNo(value: room.cookerAvailable!)
        wifiTitle.text = "WIFI Available"
        wifiValue.text = boolToYesNo(value: room.wifiAvailable!)
        landlineTitle.text = "Landline"
        landlineValue.text = boolToYesNo(value: room.landlineAvailable!)
        subscribtionFeesTitle.text = "Subscribtion Fees"
        if let mSubFees = room.monthlySubscriptionFees{
            subscribtionFeesValue.text = "\(Decimal(mSubFees))"

        }
        insuranceFeesTitle.text = "Insurance Fees"
        if let mInsuranceFees = room.insuranceFees{
            insuranceFeesValue.text = "\(Decimal(mInsuranceFees))"
            
        }
        monthlyRentTitle.text = "Monthly Rent"
        if let mMonthlyRent = room.monthlyRent{
            monthlyRentValue.text = "\(Decimal(mMonthlyRent))"
            
        }
        
        
        
        
        
    }
    
    private func boolToYesNo(value:Bool) -> String{
        if value{
            return "yes"
        }else{
            return "No"
        }
    }
    

    @IBAction func callButton(_ sender: Any) {
        if let phoneCallURL = URL(string: "telprompt://\(room.userPhoneNumber!)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
}
