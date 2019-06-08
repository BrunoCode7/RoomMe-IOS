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

class AddRoomViewController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var owningStatePickerView: UIPickerView!
    @IBOutlet weak var allowedGenderPickerView: UIPickerView!
    @IBOutlet weak var roommatesGenderPickerView: UIPickerView!
    @IBOutlet weak var availableFromDatePickerView: UIDatePicker!
    
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
    
    
    var roomDictionary = [String:Any]()
    let genders = ["Male","Female","Both"]
    let owningStates=["Rental","Owner"]
    let boolValues = [false,true]
    var lat = Double()
    var long = Double()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
    let user = Auth.auth().currentUser
    
    
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
        
        let refreshBarButton: UIBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = refreshBarButton
        activityIndicator.isHidden = true
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
        
        // get user info from firebase
        
        guard let username = user?.displayName,let userEmail = user?.email, let userUid = user?.uid, let userProfilePic = user?.photoURL else {
            showSimpleAlert(title: "Error", message: "Failed to get poster data")
            return
        }
        
        //Full name
            roomDictionary[Constants.userName] = username
        
        //user Email
            roomDictionary[Constants.userEmail] = userEmail
       
        //user UID
            roomDictionary[Constants.userUid] = userUid
        
        //user profile picture URL
        do{
         let photoUrlString = try String(contentsOf:userProfilePic)
            roomDictionary[Constants.userProfilePicUrl] = photoUrlString
        }catch{
            print(error.localizedDescription)
        }
        
        //user phone number
        if let phoneNumber = userPhoneNumberTextField.text?.trimmingCharacters(in: .whitespaces), !phoneNumber.isEmpty{
            roomDictionary[Constants.userPhoneNumber] = phoneNumber
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your phone number")
            self.activityIndicator.isHidden = true
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
            roomDictionary[Constants.apartmentNumber] = Int(apartmentNumber)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your apartment number")
            self.activityIndicator.isHidden = true
            return
        }
        
        //number of room beds
        if let numberOfRoomBeds = numberOfRoomBedsTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfRoomBeds.isEmpty{
            roomDictionary[Constants.numberOfRoomBeds] = Int(numberOfRoomBeds)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of room beds")
            self.activityIndicator.isHidden = true
            return
        }

        //number of roommates
        if let numberOfRoommates = numberOfRoommatesTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfRoommates.isEmpty{
            roomDictionary[Constants.numberOfRoommates] = Int(numberOfRoommates)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of roommates")
            self.activityIndicator.isHidden = true
            return
        }
        
        //allowed gender
        roomDictionary[Constants.allowedGender] = genders[allowedGenderPickerView.selectedRow(inComponent: 0)]

        
        //number of bathrooms
        if let numberOfBathrooms = numberOfBathroomsTextField.text?.trimmingCharacters(in: .whitespaces), !numberOfBathrooms.isEmpty{
            roomDictionary[Constants.numberOfBathrooms] = Int(numberOfBathrooms)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add your number of bathrooms")
            self.activityIndicator.isHidden = true
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
            self.activityIndicator.isHidden = true
            return
        }
        
        if let monthlyRentValue = monthlyRent.text?.trimmingCharacters(in: .whitespaces), !monthlyRentValue.isEmpty{
            roomDictionary[Constants.monthlyRent] = Double(monthlyRentValue)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add the room monthly rental")
            self.activityIndicator.isHidden = true
            return
        }
        
        if let insuranceFeesValue = insuranceFeesTextField.text?.trimmingCharacters(in: .whitespaces), !insuranceFeesValue.isEmpty{
            roomDictionary[Constants.insuranceFees] = Double(insuranceFeesValue)
        }else{
            showSimpleAlert(title: "Data missing", message: "Please add the room insurance fees, if there is none please add 0")
            self.activityIndicator.isHidden = true
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
