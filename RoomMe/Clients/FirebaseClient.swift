//
//  FirebaseClient.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/22/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import Foundation
import Firebase

public class FirebaseClient {
    
    static func getAllRoomsFromFirestore(completionHandler:@escaping (_ roomsList:[Room]?,_ error:Error?)->Void){
        let db = Firestore.firestore()
        db.collection("AllRoomsPosts").getDocuments { (snapshots, error) in
            if let error = error{
                print("Error getting documents: \(error)")
                completionHandler(nil,error)
            }else{
                let dictionaries = snapshots?.documents.compactMap({$0.data()}) ?? []
                let rooms = dictionaries.compactMap({Room(data: $0)})
                completionHandler(rooms,nil)

            }
        }
    }
    static func getSingleRoomDataFromLocation(lat:Double, long:Double, completionHandler:@escaping (_ roomsList:[Room]?,_ error:Error?)->Void){
        let db = Firestore.firestore()
        let roomsRef = db.collection("AllRoomsPosts")
        roomsRef.whereField("lat", isEqualTo: lat).whereField("long", isEqualTo: long).getDocuments { (snapshots, error) in
            if let error = error{
                print("Error getting documents: \(error)")
                completionHandler(nil,error)
            }else{
                let dictionaries = snapshots?.documents.compactMap({$0.data()}) ?? []
                let rooms = dictionaries.compactMap({Room(data: $0)})
                completionHandler(rooms,nil)
                
            }
        }
        
    }
    
    
    static func postRoomDataToFirebase(roomData:[String:Any], completionHandler:@escaping (_ error:Error?)->Void){
        let db = Firestore.firestore()
        db.collection("AllRoomsPosts").addDocument(data: roomData) { (error) in
            if let err = error {
                completionHandler(err)
                
            }else{
                completionHandler(nil)
            }
        }
    }
}
