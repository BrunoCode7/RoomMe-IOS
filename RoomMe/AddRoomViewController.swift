//
//  AddRoomViewController.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/24/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import UIKit
import Firebase
import MapKit


class AddRoomViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var owningStatePickerView: UIPickerView!
    @IBOutlet weak var allowedGenderPickerView: UIPickerView!
    @IBOutlet weak var roommatesGenderPickerView: UIPickerView!
    @IBOutlet weak var availableFromDatePickerView: UIDatePicker!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    @IBOutlet weak var apartmentNumberTextField: UITextField!
    @IBOutlet weak var numberOfRoommatesTextField: UITextField!
    @IBOutlet weak var numberOfRoomBedsTextField: UITextField!
    @IBOutlet weak var numberOfBathroomsTextField: UITextField!
    @IBOutlet weak var insuranceFeesTextField: UITextField!
    
    @IBOutlet weak var petsAllowed: UISegmentedControl!
    @IBOutlet weak var airConditioned: UISegmentedControl!
    @IBOutlet weak var tvAvailable: UISegmentedControl!
    @IBOutlet weak var fridgeAvailable: UISegmentedControl!
    @IBOutlet weak var cookerAvailable: UISegmentedControl!
    @IBOutlet weak var wifiAvailable: UISegmentedControl!
    @IBOutlet weak var landlineAvailable: UISegmentedControl!
    @IBOutlet weak var cableTvAvailable: UISegmentedControl!
    
    @IBOutlet weak var monthlySubscribtionFees: UITextField!
    @IBOutlet weak var monthlyRent: UITextField!
    @IBOutlet weak var extraComments: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var roomDictionary = [String:Any]()
    let genders = ["Male","Female","Both"]
    let owningStates=["Rental","Owner"]
    let boolValues = [false,true]
    var lat = Double()
    var long = Double()
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case owningStatePickerView:
            return owningStates.count
        case allowedGenderPickerView:
            return genders.count
        case roommatesGenderPickerView:
            return genders.count
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case owningStatePickerView:
            return owningStates[row]
        case allowedGenderPickerView:
            return genders[row]
        case roommatesGenderPickerView:
            return genders[row]
        default:
            return "Error"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect picker views
        owningStatePickerView.delegate = self
        owningStatePickerView.dataSource = self
        allowedGenderPickerView.delegate = self
        allowedGenderPickerView.dataSource = self
        roommatesGenderPickerView.delegate = self
        roommatesGenderPickerView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @IBAction func postRoomData(_ sender: Any) {
        // send room data to firebase
        
        activityIndicator.isHidden = false
        
        //Full name
        if let name = fullNameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty{
            roomDictionary[Constants.userName] = name
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your full name")
            return
        }
        
        //user phone number
        if let phoneNumber = userPhoneNumberTextField.text?.trimmingCharacters(in: .whitespaces), !phoneNumber.isEmpty{
            roomDictionary[Constants.userPhoneNumber] = Int(phoneNumber)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your phone number")
            return
        }
        
        //user Email
        if let userEmail = userEmailTextField.text?.trimmingCharacters(in: .whitespaces), !userEmail.isEmpty{
            roomDictionary[Constants.userEmail] = userEmail
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your Email")
            return
        }
        
        //owner state
        roomDictionary[Constants.owningState] = owningStates[owningStatePickerView.selectedRow(inComponent: 0)]
        
        //creation date
        roomDictionary[Constants.postCreationDate] = Timestamp(date: Date())
        
        //roommates gender
        roomDictionary[Constants.roommatesGender] = genders[roommatesGenderPickerView.selectedRow(inComponent: 0)]
        
        //location lat & long
        roomDictionary[Constants.lat] = lat
        roomDictionary[Constants.long] = long
        
        //apartment number
        if let apartmentNumber = apartmentNumberTextField.text?.trimmingCharacters(in: .whitespaces), !apartmentNumber.isEmpty{
            roomDictionary[Constants.apartmentNumber] = apartmentNumber
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your apartment number")
            return
        }
        
        //number of room beds
        if let numberOfRoomBeds = numberOfRoomBedsTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfRoomBeds.isEmpty{
            roomDictionary[Constants.numberOfRoomBeds] = numberOfRoomBeds
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of room beds")
            return
        }

        //number of roommates
        if let numberOfRoommates = numberOfRoommatesTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfRoommates.isEmpty{
            roomDictionary[Constants.numberOfRoommates] = numberOfRoommates
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of roommates")
            return
        }
        
        //allowed gender
        roomDictionary[Constants.allowedGender] = genders[allowedGenderPickerView.selectedRow(inComponent: 0)]

        
        //number of bathrooms
        if let numberOfBathrooms = numberOfBathroomsTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfBathrooms.isEmpty{
            roomDictionary[Constants.numberOfBathrooms] = numberOfBathrooms
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of bathrooms")
            return
        }
    
        
        //availabilities
        roomDictionary[Constants.availabilityDate] = Timestamp(date: availableFromDatePickerView.date)
        roomDictionary[Constants.petsAllowed] = boolValues[petsAllowed.selectedSegmentIndex]
        roomDictionary[Constants.airConditioned] = boolValues[airConditioned.selectedSegmentIndex]
        roomDictionary[Constants.tvAvailable] = boolValues[tvAvailable.selectedSegmentIndex]
        roomDictionary[Constants.fridgeAvailable] = boolValues[fridgeAvailable.selectedSegmentIndex]
        roomDictionary[Constants.cookerAvailable] = boolValues[cookerAvailable.selectedSegmentIndex]
        roomDictionary[Constants.wifiAvailable] = boolValues[wifiAvailable.selectedSegmentIndex]
        roomDictionary[Constants.landlineAvailable] = boolValues[landlineAvailable.selectedSegmentIndex]
        roomDictionary[Constants.cableChannelsAvailable] = boolValues[cableTvAvailable.selectedSegmentIndex]
        
        //fees
        if let monthlySubscribtionFees = monthlySubscribtionFees.text?.trimmingCharacters(in: .whitespaces), !monthlySubscribtionFees.isEmpty{
            roomDictionary[Constants.monthlySubscribtionFees] = Double(monthlySubscribtionFees)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add the room monthly subscribtion fees, if there is none please put 0")
            return
        }
        
        if let monthlyRentValue = monthlyRent.text?.trimmingCharacters(in: .whitespaces), !monthlyRentValue.isEmpty{
            roomDictionary[Constants.monthlyRent] = Double(monthlyRentValue)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add the room monthly rental")
            return
        }
        
        if let insuranceFeesValue = insuranceFeesTextField.text?.trimmingCharacters(in: .whitespaces), !insuranceFeesValue.isEmpty{
            roomDictionary[Constants.insuranceFees] = Double(insuranceFeesValue)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add the room insurance fees, if there is none please add 0")
            return
        }
        
        
        //get Country
        let location = CLLocation(latitude: lat, longitude: long)
        
        fetchCityAndCountry(from: location) { city, country, error in
            guard let country = country, error == nil else { print("error detecting counry")
                return }
            self.roomDictionary[Constants.country] = country
            
            // post data to firebase
            FirebaseClient.postRoomDataToFirebase(roomData: self.roomDictionary, completionHandler: { (error) in
                if let err = error{
                    self.showSimpleAlert(title: "Error", message: "Failed to post the data, please check your internet connection")
                    print(err)
                }else{
                    self.showSimpleAlert(title: "Congratulations", message: "Your post has been successfully added")
                    self.activityIndicator.isHidden = true
                    self.postButton.isEnabled = false
                }
            })
        }
            }
    
    
    
    
    
    
    
    
    
    private func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    private func showSimpleAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actoinOk = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actoinOk)
        present(alert, animated: true, completion: nil)
    }
    
}
