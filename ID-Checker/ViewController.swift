//
//  ViewController.swift
//  ID-Checker
//
//  Created by Chen Hsin Hsuan on 2015/5/31.
//  Copyright (c) 2015年 AirconTW. All rights reserved.
//

import UIKit
import Spring
import GoogleMobileAds
import Parse

var cnText:String?
var twText:String?
var hkText:String?
var koText:String?
var cnLineImageView:SpringImageView?
var twLineImageView:SpringImageView?
var hkLineImageView:SpringImageView?
var koLineImageView:SpringImageView?

let TW_PlistData = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("TW", ofType: "plist")!)
let CN_PlistData = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("CN", ofType: "plist")!)
let HK_PlistData = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("HK", ofType: "plist")!)

let PAGE_ADUNIT_ID = "ca-app-pub-5200673733349176/5811626441"


class ViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var adBannerView: GADBannerView!
    
    var theGADInterstitial = GADInterstitial(adUnitID: PAGE_ADUNIT_ID)
    let request = GADRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        //廣告設定

        request.testDevices = [
            "ffd5b4c17425a518e4f9c99b1738ae16" //AirPhone
        ];
        
//        adBannerView.loadRequest(request)
        theGADInterstitial.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func checkButtonPressed(sender: SpringButton) {
        
        sender.animation = "pop"
        sender.scaleX = 1.5
        sender.scaleY = 1.5
        sender.animate()
    

        if cnText != nil && count(cnText!) > 0{
            if( count(cnText!) == 18 && Checker.checkChinaId(cnText!)){
                cnLineImageView?.image = UIImage(named: "GreenLine.png")
                createRightObject(cnText!, national: "China")
            }else{
                cnLineImageView?.image = UIImage(named: "RedLine.png")
                createWrongObject(cnText!, national: "China")
            }
        }else{
            cnLineImageView?.image = UIImage(named: "GrayLine.png")
        }
        
        if twText != nil &&  count(twText!) > 0 {
            if( count(twText!) == 10 && Checker.checkTaiwanId(twText!)){
                twLineImageView?.image = UIImage(named: "GreenLine.png")
                createRightObject(twText!, national: "Taiwan")
            }else{
                twLineImageView?.image = UIImage(named: "RedLine.png")
                createWrongObject(twText!, national: "Taiwan")
            }
        }else{
            twLineImageView?.image = UIImage(named: "GrayLine.png")
        }
        
        if  hkText != nil &&  count(hkText!) > 0{
            if( count(hkText!) == 9 && Checker.checkHongKongId(hkText)){
                hkLineImageView?.image = UIImage(named: "GreenLine.png")
                createRightObject(hkText!, national: "HongKong")
            }else{
                hkLineImageView?.image = UIImage(named: "RedLine.png")
                createWrongObject(hkText!, national: "HongKong")
            }
        }else{
            hkLineImageView?.image = UIImage(named: "GrayLine.png")
        }

        if  koText != nil &&  count(koText!) > 0{
            if( count(koText!) == 13 && Checker.checkKoreaId(koText!)){
                koLineImageView?.image = UIImage(named: "GreenLine.png")
                createRightObject(koText!, national: "Korea")
            }else{
                koLineImageView?.image = UIImage(named: "RedLine.png")
                createWrongObject(koText!, national: "Korea")
            }
        }else{
            koLineImageView?.image = UIImage(named: "GrayLine.png")
        }
        
        
        
        //準備廣告
        if (theGADInterstitial.isReady) {
            theGADInterstitial.presentFromRootViewController(self)
        }else{
            theGADInterstitial = GADInterstitial(adUnitID: PAGE_ADUNIT_ID)
            theGADInterstitial.loadRequest(request)
        }
        
    }
    
    
    func createRightObject(id:String, national:String){

        var object = PFObject(className: "Right")
        object.setObject(id, forKey: "number")
        object.setObject(national, forKey: "national")
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Right has been saved.")
        }

    }
    
    
    func createWrongObject(id:String, national:String){
    
        var object = PFObject(className: "Wrong")
        object.setObject(id, forKey: "number")
        object.setObject(national, forKey: "national")
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Wrong has been saved.")
        }
    
    }
       
}

