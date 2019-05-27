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
    @IBOutlet weak var phoneValue: UILabel!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(room.numberOfBathrooms!)
        populateTheTable(room: room)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
 
    }
    
    private func populateTheTable(room:Room){
        nameTitle.text = "Full Name"
        nameValue.text = room.userName!
        phoneTitle.text = "Phone No."
        phoneValue.text = String(room.userPhoneNumber!)
        emailTitle.text = "Email"
        emailValue.text = room.userEmail!
        owningStateTitle.text = "Owning State"
        owningStateValue.text = room.owningState!
        apartmentNumberTitle.text = "Apartment No."
        apartmentNumberValue.text = String(room.apartmentNumber!)
        numberOfBedsTitle.text = "No. Of Room Beds"
        numberOFBedsValue.text = String(room.numberOfRoomBeds!)
        numberOfBathroomsTitle.text = "No. of Bathrooms"
        numberOfBathroomsValue.text = String(room.numberOfBathrooms!)
        numberOfRoommatesTitle.text = "No. Of Roommates"
        numberOfRoommatesValue.text = String(room.numberOfRoommates!)
        roommatesGenderTitle.text = "Roommates Gender"
        roommatesGenderValue.text = room.roommatesGender!
        allowedGenderTitle.text = "Allowed Gender"
        allowedGenderValue.text = room.allowedGender!
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
        subscribtionFeesValue.text = "\(Decimal(room.monthlySubscriptionFees!))"
        insuranceFeesTitle.text = "Insurance Fees"
        insuranceFeesValue.text = "\(Decimal(room.insuranceFees!))"
        monthlyRentTitle.text = "Monthly Rent"
        monthlyRentValue.text = "\(Decimal(room.monthlyRent!))"
        
        
        
        
        
    }
    
    private func boolToYesNo(value:Bool) -> String{
        if value{
            return "yes"
        }else{
            return "No"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
