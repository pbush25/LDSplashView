//
//  LDSplashView.swift
//  LDSplashView
//
//  Created by Patrick M. Bush on 10/22/15
//  Copyright © 2015 Lead Development Co. All rights reserved.
//

import UIKit

@objc class LDSplashView: UIView, LDSplashDelegate {
    
    
    enum LDSplashAnimationType {
        case Fade
        case Bounce
        case Shrink
        case Zoom
        case None
        case Custom
    }
    
    var backgroundViewColor: UIColor? {
        didSet (newColor) {
            if backgroundViewColor == nil {
                self.backgroundViewColor = UIColor.grayColor()
            } else {
                self.backgroundViewColor = newColor
            }
        }
    }
    var backgroundImage: UIImage? {
        didSet (newImage) {
            let imageView = UIImageView(image: newImage)
            imageView.frame = UIScreen.mainScreen().bounds
            self.addSubview(imageView)
        }
    }
    var animationDuration: CGFloat = 1.0 {
        didSet (newDuration) {
            if animationDuration == 1.0 {
                self.animationDuration = newDuration
                self.splashIcon?.animationDuration = Double(self.animationDuration)
            }
        }
    }
    
    var delegate: LDSplashDelegate?
    var splashIcon: LDSplashIcon?
    var customAnimation: CAAnimation? {
        didSet {
            if animationType == .Custom {
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [1, 0.9, 300]
                animation.keyTimes = [0, 0.4, 1]
                animation.duration = Double(self.animationDuration)
                animation.removedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                let function1 = CAMediaTimingFunction(name: "kCAMediaTimingFunctionEaseOut")
                let function2 = CAMediaTimingFunction(name: "kCAMediaTimingFunctionEaseIn")
                animation.timingFunctions = [function1, function2]
                self.customAnimation = animation
            }
        }
    }
    var animationType: LDSplashAnimationType = .None//default is none
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(initWithAnimationType animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.animationType = animationType
    }
    
    init?(initWithBackgroundColor color: UIColor, animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.animationType = animationType
        self.backgroundColor = color
    }
    
    init?(initWithBackgroundImage image: UIImage, animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.animationType = animationType
        self.backgroundImage = image
        let imageView = UIImageView(image: image)
        imageView.frame = self.frame
        self.addSubview(imageView)
    }
    
    init?(initWithSplashIcon icon: LDSplashIcon, animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.animationType = animationType
        self.splashIcon = icon
        self.backgroundColor = backgroundColor
        splashIcon!.center = self.center
        self.layoutIfNeeded()
        self.addSubview(splashIcon!)
    }
    
    init?(initWithSplashIcon icon: LDSplashIcon, backgroundColor: UIColor, animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.splashIcon = icon
        self.backgroundColor = backgroundColor
        self.animationType = animationType
        self.splashIcon!.center = self.center
        self.addSubview(splashIcon!)
        self.layoutIfNeeded()
        self.bringSubviewToFront(splashIcon!)
    }
    
    init?(initWithSplashIcon icon: LDSplashIcon, backgroundImage: UIImage, animationType: LDSplashAnimationType) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.animationType = animationType
        self.splashIcon = icon
        self.splashIcon!.center = self.center
        self.backgroundImage = backgroundImage
        let imageView = UIImageView(image: backgroundImage)
        imageView.frame = self.frame
        self.layoutIfNeeded()
        self.addSubview(imageView)
        self.addSubview(splashIcon!)
    }
    
    //MARK: - Public Methods
    
    func startAnimation() {
        if splashIcon != nil {
            let dictionary = [String("animationDuration") : String(self.animationDuration)]
            NSNotificationCenter.defaultCenter().postNotificationName("startAnimation", object: self, userInfo: dictionary)
        }
        
        if delegate?.didBeginAnimatingWithDuration!(self.animationDuration) != nil {
            self.delegate?.didBeginAnimatingWithDuration!(self.animationDuration)
        }
        
        switch (animationType) {
        case .Bounce:
            self.addBounceAnimation()
            break
        case .Fade:
            self.addFadeAnimation()
            break
        case .Zoom:
            self.addZoomAnimation()
            break
        case .Shrink:
            self.addShrinkAnimation()
            break
        case .None:
            self.addNoAnimation()
            break
        case .Custom:
//            if (animationType != nil) {
//                self.addCustomAnimationWithAnimation(customAnimation!)
//            } else {
//                self.addCustomAnimationWithAnimation(self.customAnimation!)
//            }
            break
        }
        
    }
    
    //MARK: - Animations
    
    func addBounceAnimation() {
        let bounceDuration = self.animationDuration * 0.8
        NSTimer.scheduledTimerWithTimeInterval(Double(bounceDuration), target: self, selector: "pingGrowAnimation", userInfo: nil, repeats: false)
    }
    
    func pingGrowAnimation() {
        let growDuration = self.animationDuration * 0.2
        UIView.animateWithDuration(Double(growDuration), animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(20, 20)
            self.transform = scaleTransform
            self.alpha = 0
            self.backgroundColor = UIColor.blackColor()
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.endAnimating()
        }
    }
    
    func growAnimation() {
        let growDuration = self.animationDuration * 0.7
        UIView.animateWithDuration(Double(growDuration), animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(20, 20)
            self.transform = scaleTransform
            self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.endAnimating()
        }
    }
    func addFadeAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), animations: { () -> Void in
            self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.endAnimating()
        }
    }
    
    func addZoomAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(10, 10)
            self.transform = scaleTransform
            self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.endAnimating()
        }
    }
    
    func addShrinkAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(0.5, 0.5)
            self.transform = scaleTransform
            self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.endAnimating()
        }
    }
    
    func addNoAnimation() {
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeSplashView", userInfo: nil, repeats: true)
    }
    
    func addCustomAnimationWithAnimation(animation: CAAnimation) {
        self.layer.addAnimation(animation, forKey: "LDSplashAnimation")
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeSplashView", userInfo: nil, repeats: true)
    }
    
    func removeSplashView() {
        self.removeFromSuperview()
        self.endAnimating()
    }
    
    func endAnimating() {
        if delegate?.splashViewDidEndAnimating!(self) != nil {
            self.delegate?.splashViewDidEndAnimating!(self)
        }
    }

    }

@objc class LDSplashIcon: UIImageView {
    
    enum LDIconSplashAnimationType {
        case Fade
        case Bounce
        case Ping
        case Grow
        case Blink
        case Shrink
        case Zoom
        case None
        case Custom
    }
    
    var animationType: LDIconSplashAnimationType = .None
    var customAnimation: CAAnimation?
    var animationTime: CGFloat = 1.0
    var iconImage: UIImage?
    
    var iconColor: UIColor? {
        didSet(color) {
            if color == nil {
                self.tintColor = UIColor.whiteColor()
            } else {
                 self.tintColor = iconColor
            }
        }
    }
    
    var iconSize: CGSize = CGSize(width: 80, height: 80) {
        didSet {
            self.frame = CGRectMake(0, 0, iconSize.width, iconSize.height)
        }
    }
    
    var splashView: LDSplashView?
    
    init!(initWithImage image: UIImage) {
        super.init(image: image)
        
        self.iconImage = image
        self.tintColor = self.iconColor
        self.contentMode = .ScaleAspectFit
        self.frame = CGRectMake(0, 0, self.iconSize.width, self.iconSize.height)
        self.addObserverForAnimationNotification()
        
    }
    
    init?(initWithImage image: UIImage, animationType: LDIconSplashAnimationType) {
        super.init(image: image)
        self.iconImage = image
        self.animationDuration = Double(animationTime)
        self.animationType = animationType
        self.tintColor = iconColor
        self.contentMode = .ScaleAspectFit
        self.frame = CGRectMake(0, 0, iconSize.width, iconSize.height)
        self.addObserverForAnimationNotification()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Implementation
    func addObserverForAnimationNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification:", name: "startAnimation", object: nil)
    }
    
    func receiveNotification(notification: NSNotification) {
        if notification.userInfo!["animationDuration"] != nil {
            let duration = Double(notification.userInfo!["animationDuration"] as! String)
            self.animationDuration = duration!
        }
        self.startAnimation()
    }
    
    func startAnimation() {
        switch (animationType) {
        case .Bounce:
            self.addBounceAnimation()
            break
        case .Fade:
            self.addFadeAnimation()
            break
        case .Grow:
            self.addGrowAnimation()
            break
        case .Shrink:
            self.addShrinkAnimation()
            break
        case .Ping:
            self.addPingAnimation()
            break
        case .Blink:
            self.addBlinkAnimation()
            break
        case .None:
            self.addNoAnimation()
            break
        case .Custom:
            if customAnimation != nil {
                self.addCustomAnimation(customAnimation!)
            } else {
                self.addCustomAnimation(customAnimation!)
            }
            break
        default:
            print("No animation type selected")
            break
        }
    }
    
    func addBounceAnimation() {
        let shrinkDuration = self.animationDuration * 0.3
        let growDuration = self.animationDuration * 0.7
        
        UIView.animateWithDuration(Double(shrinkDuration), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(0.75, 0.75)
            self.transform = scaleTransform
            }) { (_) -> Void in
                UIView.animateWithDuration(Double(growDuration), animations: { () -> Void in
                    let scaleTransform = CGAffineTransformMakeScale(20, 20)
                    self.transform = scaleTransform
                    self.alpha = 0
                    }, completion: { (_) -> Void in
                        self.removeFromSuperview()
                })
                
        }
    }
    
    func addFadeAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), animations: { () -> Void in
            self.image = self.iconImage
            self.alpha = 0
            }) { (_) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func addGrowAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(20, 20)
            self.transform = scaleTransform
            }) { (_) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func addShrinkAnimation() {
        UIView.animateWithDuration(Double(self.animationDuration), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(0.75, 0.75)
            self.transform = scaleTransform
            }) { (_) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func addPingAnimation() {
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeAnimations", userInfo: nil, repeats: true)
        UIView.animateWithDuration(1.5, delay: 0, options: .Repeat, animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(0.75, 0.75)
            self.transform = scaleTransform
            }) { (_) -> Void in
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    let scaleTransform = CGAffineTransformMakeScale(20, 20)
                    self.transform = scaleTransform
                })
        }
    }
    
    func addBlinkAnimation() {
        self.alpha = 0
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeAnimations", userInfo: nil, repeats: true)
        UIView.animateWithDuration(1.5, delay: 0, options: .Repeat, animations: { () -> Void in
            self.alpha = 1
            }) { (_) -> Void in
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    self.alpha = 0
                })
        }
    }
    
    func removeAnimations() {
        self.layer.removeAllAnimations()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.removeFromSuperview()
    }
    
    func addNoAnimation() {
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeAnimations", userInfo: nil, repeats: true)
    }
    
    func addCustomAnimation(animation: CAAnimation) {
        self.layer.addAnimation(animation, forKey: "LDSplashAnimation")
        NSTimer.scheduledTimerWithTimeInterval(Double(self.animationDuration), target: self, selector: "removeAnimations", userInfo: nil, repeats: true)
    }
}

@objc protocol LDSplashDelegate {
    optional func didBeginAnimatingWithDuration(duration: CGFloat)
    
    optional func splashViewDidEndAnimating(splashView: LDSplashView)
}