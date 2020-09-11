//
//  View2.swift
//  GolfTrack
//
//  Created by bucquet on 11/11/16.
//  Copyright © 2016 bucquet. All rights reserved.
//

import Foundation
import UIKit

class View2: UIViewController {
    
    @IBOutlet weak var ymOutlet: UISegmentedControl!

    @IBAction func ValueChanged(_ sender: Any) {
        if ymOutlet.selectedSegmentIndex == 1{
            yards = false
            distance.text = "\(dist)"
            Min.text = "Min: \(dist - (dist * 10/100))"
            Max.text = "Max: \(dist + (dist * 10/100))"
        }
        else{
            yards = true
            distance.text = "\(disty)"
            Min.text = "Min: \(disty - (disty * 10/100))"
            Max.text = "Max: \(disty + (disty * 10/100))"
        }
        let yardsDefault = UserDefaults.standard
        yardsDefault.set(yards, forKey: "ym")
        
    }
    
    var yards = true
    var disty = 0.0
    @IBOutlet weak var Max: UILabel!
    @IBOutlet weak var Min: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    var dist = Double()
    
    @IBOutlet weak var parametres: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yardsDefault = UserDefaults.standard
        
        yards = yardsDefault.bool(forKey: "ym")
        if yards == false{
            ymOutlet.selectedSegmentIndex = 1
        }
        else{
            ymOutlet.selectedSegmentIndex = 0
        }
        
        dist = (0.106/meters)
        
        
        dist = dist * 2.251
        disty = dist * 1.09361
        dist = (round(10 * dist) / 10)
        disty = (round(10 * disty) / 10)

        
        if yards == false{
            distance.text = "\(dist)"
            Min.text = "Min: \(dist - (dist * 10/100))"
            Max.text = "Max: \(dist + (dist * 10/100))"
        }
        else{
            distance.text = "\(disty)"
            Min.text = "Min: \(disty - (disty * 10/100))"
            Max.text = "Max: \(disty + (disty * 10/100))"
        }
        
        
        
        
    }
}
