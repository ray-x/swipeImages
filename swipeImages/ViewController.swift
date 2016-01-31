//
//  ViewController.swift
//  swipeImage
//
//  Created by Ray Xu on 26/01/2016.
//  Copyright © 2016 Ray Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var xr: UIImageView!
    @IBOutlet weak var ss: UIImageView!
    @IBOutlet weak var zp: UIImageView!
    
    @IBOutlet weak var leftOutImage: UIImageView!
    @IBOutlet weak var rightOutImage: UIImageView!
    
    //var imageList=[UIImageView]()
    var imageList:[UIImageView]=[]
    var ImageNames:[String]=[]
    var Images:[UIImage]=[]
    let maxImages = 3
    var imageIndex: NSInteger = 1
    var idx:Int=1
    var lv, mv, rv:UIImageView!
    var sHeight,sWidth,cHeight,cWidth:CGFloat!
    //static var idx=0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:") // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:") // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        imageList=[ss,xr,zp]

        ImageNames=["Mouse"]
        Images=[UIImage(named: "mouse")!, UIImage(named: "cat")!, UIImage(named: "dogrun")! , UIImage(named: "scared-man")!]
        var i=0
        for img in imageList
        {
            img.image=Images[i++]
        }
        
        sHeight=ss.frame.height
        sWidth=ss.frame.width
        cHeight=xr.frame.height
        cWidth=xr.frame.width
        
        lv=imageList[0]
        mv=imageList[1]
        rv=imageList[2]
        
        for img in imageList
        {
            //img.backgroundColor=UIColor.redColor()
        }
        rightOutImage.image=Images[3]
        mv.transform=CGAffineTransformMakeScale(1.6, 1.6)
        mv.center.y+=40
    }
    
    override func viewDidLayoutSubviews() {
        let dist=self.view.frame.width/2-self.imageList[0].center.x
        leftOutImage.center.x=self.imageList[0].center.x - dist
        rightOutImage.center.x=self.imageList[2].center.x+dist
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        let centerPos=self.view.frame.width/2
        let widthSmall=self.view.frame.width/4
        let widthCenter=self.view.frame.width/3
        let leading:CGFloat=20.0
        let dist=centerPos-self.imageList[0].center.x
        let dist2=self.imageList[0].center.x-dist
        let width=self.view.frame.width
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right :
                if idx==0
                {
                    return
                }
                print("User swiped right")
                leftOutImage.hidden=false
                rightOutImage.hidden=true
                UIView.animateWithDuration(0.5, animations: {
                    self.lv.center.x=centerPos
                    self.mv.center.x=width-leading-widthSmall/2
                    self.leftOutImage.center.x=leading+widthSmall/2
                    self.rv.center.x+=dist
                    
                    let scaleTrans=CGAffineTransformMakeScale(1, 1)
                    let scaleTrans2=CGAffineTransformMakeScale(1.6, 1.6)
                    self.mv.transform=scaleTrans
                    self.lv.transform=scaleTrans2
                    }
                    , completion: {
                        (ret: Bool) in
                        let tmp=self.rightOutImage
                        self.rightOutImage=self.rv
                        self.rv=self.mv
                        self.mv=self.lv
                        self.lv=self.leftOutImage
                        self.leftOutImage=tmp
                        self.leftOutImage.center.x = -self.sWidth/2
                        
                        self.idx--
                        
                        if self.idx>2
                        {
                            self.leftOutImage.image=self.Images[self.idx-2]
                        }else{
                            self.leftOutImage.hidden=true
                        }
                        self.leftOutImage.hidden=true

                })
                
            case UISwipeGestureRecognizerDirection.Left:
                print("User swiped Left")
                if idx>=self.Images.count-1
                {
                    return
                }
                
                leftOutImage.hidden=true
                rightOutImage.hidden=false

                UIView.animateWithDuration(0.5, animations: {
                    self.rv.center.x=centerPos
                    self.mv.center.x=leading+widthSmall/2
                    self.rightOutImage.center.x=width-leading-widthSmall/2
                    self.lv.center.x-=dist                 
                    let scaleTrans=CGAffineTransformMakeScale(1, 1)
                    let scaleTrans2=CGAffineTransformMakeScale(1.6, 1.6)
                    self.mv.transform=scaleTrans
                    self.rv.transform=scaleTrans2
                    }
                    , completion: {
                        (ret: Bool) in
                        let tmp=self.leftOutImage
                        self.leftOutImage=self.lv
                        self.lv=self.mv
                        self.mv=self.rv
                        self.rv=self.rightOutImage
                        self.rightOutImage=tmp
                        self.rightOutImage.center.x=self.view.frame.width+self.sWidth/2
                        self.idx++
                        if self.idx<self.Images.count-2
                        {
                            self.rightOutImage.image=self.Images[self.idx+2]
                        }else{
                            //self.rightOutImage.image=UIImage()
                            //self.rightOutImage.image=UIImage()
                            self.rightOutImage.hidden=true
                        }
                        self.rightOutImage.hidden=true
                })
                
            default:
                break //stops the code/codes nothing.
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

