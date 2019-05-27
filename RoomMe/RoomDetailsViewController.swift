//
//  RoomDetailsViewController.swift
//  RoomMe
//
//  Created by Baraa Hesham on 5/26/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import UIKit

class RoomDetailsViewController: UITableViewController {
    
    var room:Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(room.long!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
