//
//  ViewController.swift
//  GolfTrack
//
//  Created by bucquet on 11/6/16.
//  Copyright © 2016 bucquet. All rights reserved.
//

import UIKit
import AVFoundation


var meters = Double()
var distancereal = Double()
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate{
    let line = CAShapeLayer()
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    
    var realfirstPoint: CGPoint?
    var realsecondPoint: CGPoint?
    var lookif = false
    var notFirstTime = false
    @IBOutlet weak var scroll_view: UIScrollView!
    var realImage = UIImageView()
    
    var determine = 1
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
       print("prepared")
    }
        
    
    @IBAction func camerabtn(_ sender: Any) {
        determine = 1
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func clear(_ sender: Any) {
        lookif = true
        firstPoint = nil
        secondPoint = nil
        realfirstPoint = nil
        realsecondPoint = nil
        line.removeFromSuperlayer()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        realImage.image = image
        realImage.frame = CGRect(x: 0, y: 0, width: scroll_view.frame.width, height: scroll_view.frame.height)
        scroll_view.zoomScale = 1.0
        lookif = true
        self.dismiss(animated: true, completion: nil)
        imageLbl.isHidden = true
        imageImg.isHidden = true
        imageLbl2.isHidden = true
        if notFirstTime == false{
            let alert = UIAlertController(title: "Info", message: "Now that you have taken a picture of the flag, please draw it by pressing on both edges one at a time, then click Done. You can zoom in now if it helps.", preferredStyle: UIAlertControllerStyle.alert)
        
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Don't show again", style: UIAlertActionStyle.cancel, handler: { action in
            
                // do something like...
                self.notFirstTime = true
                let notFirstTimeDefault = UserDefaults.standard
                notFirstTimeDefault.set(self.notFirstTime, forKey: "first")
            
            }))
        
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    @IBOutlet weak var imageLbl2: UILabel!
    
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        
        guard let _ = firstPoint else {
            firstPoint = touchPoint
            realfirstPoint = touchPoint
            return
        }
        
        guard let _  = secondPoint else {
            secondPoint = touchPoint
            realsecondPoint = touchPoint
            addLine(fromPoint: firstPoint!, toPoint: secondPoint!)
            
            firstPoint = nil
            secondPoint = nil
            
            return
        }
    }
    @IBOutlet weak var imageLbl: UILabel!
    @IBOutlet weak var imageImg: UIImageView!
    
    @IBAction func DONEbtn(_ sender: Any) {
        if realfirstPoint != nil && realsecondPoint != nil{
            distancereal = sqrt(Double((realfirstPoint!.x - realsecondPoint!.x)*(realfirstPoint!.x - realsecondPoint!.x) + (realfirstPoint!.y - realsecondPoint!.y)*(realfirstPoint!.y - realsecondPoint!.y)))
            
            meters = (distancereal / 3780) / Double(self.scroll_view.zoomScale)
            print(meters)
            print(distancereal)
            
            performSegue(withIdentifier: "DONE", sender: self)
        }
        
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        if lookif == true{
            
            
            let linePath = UIBezierPath()
            
        
            linePath.move(to: start)
            linePath.addLine(to: end)
            line.path = linePath.cgPath
            line.strokeColor = UIColor.red.cgColor
            line.lineWidth = 3
            line.lineJoin = kCALineJoinRound

            
            self.view.layer.addSublayer(line)
            lookif = false
            
            
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.realImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLbl.isHidden = false
        imageImg.isHidden = false
        imageLbl2.isHidden = false
        
        realImage.frame = CGRect(x: 0, y: 0, width: scroll_view.frame.width, height: scroll_view.frame.width)
        realImage.isUserInteractionEnabled = true
        realImage.contentMode = UIViewContentMode.scaleAspectFit
        scroll_view.addSubview(realImage)
        scroll_view.delegate = self
        self.view.sendSubview(toBack: scroll_view)
        self.view.sendSubview(toBack: realImage)
        
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        self.scroll_view.minimumZoomScale = 1.0
        self.scroll_view.maximumZoomScale = 10.0
        
        let notFirstTimeDefault = UserDefaults.standard
        notFirstTime = notFirstTimeDefault.bool(forKey: "first")
        print(notFirstTime)
    }
    
  }

