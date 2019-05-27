//
//  MapViewController.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/20/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    var gClickedRoom:Room!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var longPressgesture: UILongPressGestureRecognizer!
    @IBOutlet var navBar: UINavigationItem!
    @IBOutlet weak var cancelLocationButton: UIBarButtonItem!
    @IBOutlet weak var confirmLocationButton: UIBarButtonItem!
    
    private var gPickedAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        FirebaseClient.getAllRoomsFromFirestore { (rooms, error) in
            if let allRooms = rooms{
                DispatchQueue.main.async {
                    self.showRoomsLocationsOnMap(rooms: allRooms, theMapview: self.mapView)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation{
            if annotation.isEqual(gPickedAnnotation) {
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
                pinAnnotationView.pinTintColor = .blue
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.animatesDrop = true
                pinAnnotationView.isDraggable = true
                
                return pinAnnotationView
            }
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.pinTintColor = .blue
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let lat = view.annotation?.coordinate.latitude, let long = view.annotation?.coordinate.longitude{
                FirebaseClient.getSingleRoomDataFromLocation(lat: Double(lat), long: Double(long)) { (rooms, error) in
                    if let err = error{
                        print(err)
                    }else{
                        DispatchQueue.main.async {
                            self.gClickedRoom = rooms![0]
                            self.performSegue(withIdentifier: "roomDetails", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        switch newState {
        case .starting:
            print("is dragging")
            break
        case .ending:
            gPickedAnnotation.coordinate.latitude = (view.annotation?.coordinate.latitude)!
            gPickedAnnotation.coordinate.longitude = (view.annotation?.coordinate.longitude)!
            print(gPickedAnnotation.coordinate)
            break
        default:
            break
        }
    }
    @IBAction func mapLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UILongPressGestureRecognizer.State.began{
            print("long pressed")
            navigationController?.setNavigationBarHidden(false, animated: true)
            let location = sender.location(in: self.mapView)
            let coordinates = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            addAnnotationToMapView(annotationCoordinates: coordinates)
            print(coordinates)
            longPressgesture.isEnabled = false
        }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        mapView.removeAnnotation(gPickedAnnotation)
        longPressgesture.isEnabled = true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRoom"{
            let controller = segue.destination as! AddRoomViewController
            controller.lat = gPickedAnnotation.coordinate.latitude
            controller.long = gPickedAnnotation.coordinate.longitude
            mapView.removeAnnotation(gPickedAnnotation)
        }
        if segue.identifier == "roomDetails"{
            let controller = segue.destination as! RoomDetailsViewController
            controller.room = gClickedRoom
        }
    }
    
    
    //helper Methods
    
    private func addAnnotationToMapView(annotationCoordinates: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = annotationCoordinates.latitude
        annotation.coordinate.longitude = annotationCoordinates.longitude
        gPickedAnnotation = annotation
        self.mapView.addAnnotation(annotation)
    }
    
    private func showRoomsLocationsOnMap(rooms:[Room], theMapview:MKMapView){
        var annotations = [MKPointAnnotation]()
        
        for room in rooms {
            
            if let latitude = room.lat , let longitude = room.long{
                let lat = CLLocationDegrees(exactly:latitude)
                let long = CLLocationDegrees(exactly: longitude)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                
                let annotation = MKPointAnnotation()
                if let posterUserName = room.userName{
                    annotation.title = "\(posterUserName)"
                }else{
                    annotation.title = ""
                }
                
                if let rental = room.monthlyRent{
                    annotation.subtitle = "Monthly rent:\(Decimal(rental))"
                }else{
                    annotation.subtitle = ""
                    
                }
                
                annotation.coordinate = coordinate
                
                annotations.append(annotation)
                
            }
            
            
        }
        if theMapview.annotations.count != 0 {
            print("There are some annotations")
            theMapview.removeAnnotations(theMapview.annotations)
        }else{
            print("There is no annotations")
            theMapview.addAnnotations(annotations)
        }
        theMapview.addAnnotations(annotations)
        
    }
    
}

