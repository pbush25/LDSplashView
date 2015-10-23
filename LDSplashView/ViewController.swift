//
//  ViewController.swift
//  LDSplashView
//
//  Created by Patrick M. Bush on 10/22/15.
//  Copyright © 2015 Lead Development Co. All rights reserved.
//

import UIKit


class ViewController: UIViewController, LDSplashDelegate {

    var splashView: LDSplashView?
    var indicatorView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        //other examples
        //self.twitterSplash()
        //self.customLoadSplash()
        //self.snapchatSplash()
        //self.pingSplash()
        self.fadeExampleSplash()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    //MARK: - Splash Screen Examples
    
    func twitterSplash() {
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "twitter background.png")
        self.view.addSubview(imageView)
        
        let twitterSplashIcon = LDSplashIcon(initWithImage: UIImage(named: "twitterIcon.png")!, animationType: .Bounce)
        let twitterColor = UIColor(red: 0.2598, green: 0.6, blue: 1.0, alpha: 1.0)
        self.splashView = LDSplashView(initWithSplashIcon: twitterSplashIcon!, backgroundColor: twitterColor, animationType: .None)
        splashView!.delegate = self
        splashView!.animationDuration = 3
        self.view.addSubview(splashView!)
        self.view.bringSubviewToFront(splashView!)
        splashView!.startAnimation()
    }
    
    func customLoadSplash() {
        let color = UIColor(red: 168/255, green: 36/255, blue: 0.0/255, alpha: 1)
        self.splashView = LDSplashView(initWithBackgroundColor: color, animationType: .Zoom)
        splashView!.animationDuration = 3.0
        splashView!.delegate = self //optional, only assign delegate if you implement delgate methods
        self.indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        self.indicatorView!.frame = self.view.frame
        self.view.addSubview(splashView!)
        self.view.addSubview(indicatorView!)
        self.splashView!.startAnimation()
    }
    
    func snapchatSplash() {
        let splashIcon = LDSplashIcon(initWithImage: UIImage(named: "snapchat icon.png")!, animationType: .None)
        let snapchatColor = UIColor(red: 255, green: 252, blue: 0, alpha: 1)
        self.splashView = LDSplashView(initWithSplashIcon: splashIcon!, backgroundColor: snapchatColor, animationType: .Fade)
        self.splashView!.animationDuration = 3.0
        self.view.addSubview(splashView!)
        self.splashView!.startAnimation()
    }
    
    func pingSplash() {
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "ping background.png")
        self.view.addSubview(imageView)
        
        let pingSplashIcon = LDSplashIcon(initWithImage: UIImage(named: "ping.png")!, animationType: .Ping)
        self.splashView = LDSplashView(initWithSplashIcon: pingSplashIcon!, backgroundColor: UIColor.whiteColor(), animationType: .Bounce)
        self.splashView!.animationDuration = 3.0
        self.view.addSubview(splashView!)
        self.splashView!.startAnimation()
    }
    
    func fadeExampleSplash() {
        let splashIcon = LDSplashIcon(initWithImage: UIImage(named: "white dot.png")!, animationType: .Blink)
        splashIcon!.iconSize = CGSize(width: 200, height: 200)
        print(splashIcon!.frame)
        splashIcon!.layoutIfNeeded()
        self.splashView = LDSplashView(initWithSplashIcon: splashIcon!, backgroundColor: UIColor.blackColor(), animationType: .Fade)
        self.splashView!.animationDuration = 5.0
        self.view.addSubview(splashView!)
        self.splashView!.startAnimation()
    }
    
    
    //MARK: - Delegate Methods, implement if you need to know when the animations have started and ended
    
    func didBeginAnimatingWithDuration(duration: CGFloat) {
        print("Started animating")
        indicatorView?.startAnimating()
    }
    
    func splashViewDidEndAnimating(splashView: LDSplashView) {
        print("Stopped animating")
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
