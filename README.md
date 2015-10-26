# LDSplashView
A Swift class that can be used to animate a view to imitate an animated launch screen

LDSplashView is a simple class that can be used to create beautiful animated splash screens to be used while transitioning from the launch screen to the first view of your app. 

The splash view will allow you to create splash views with one of several pre-built animations. You can also add an icon on top of the splash screen such as your logo. 

NOTE: The Objective-C version of this code can be found here: https://github.com/sachinkesiraju/SKSplashView, with a huge thanks to sachinkesiraju for the original. This is simply a Swift port of his code. 

LDSplashView

 Installation

Just download the zip file, drag the LDSPlashView.swift file into your project, import `LDSPlashView` in the view you're working in and you're good to go. 

 Implementation
 LDSplashView

    let splashView = LDSplashView(initWithBackgroundImage image: UIImage) //The SplashView can be initialized with a variety of animation types and backgrounds. See customizability for more.

    splashView.animationDuration = 3.0 //Set the animation duration (Default: 1s)

    self.view.addSubview(splashView) //Add the splash view to your current view

    splashView.startAnimation() //Call this method to start the splash animation

The SplashView can also be initialized with the following methods:

    init?(initWithAnimationType animationType: LDSplashAnimationType)
    
    init?(initWithBackgroundColor color: UIColor, animationType: LDSplashAnimationType)
    
    init?(initWithBackgroundImage image: UIImage, animationType: LDSplashAnimationType)
    
    init?(initWithSplashIcon icon: LDSplashIcon, animationType: LDSplashAnimationType) 
    
    init?(initWithSplashIcon icon: LDSplashIcon, backgroundColor: UIColor, animationType: LDSplashAnimationType)
    
    init?(initWithSplashIcon icon: LDSplashIcon, backgroundImage: UIImage, animationType: LDSplashAnimationType)


The appearance of the splash view can be customized with the following properties:

    backgroundViewColor: UIColor? //Sets the background color of the splash view (Default: gray)
    backgroundImage: UIImage? //Sets a background image to the splash view
    animationDuration: CGFloat! //Sets the duration of the splash view (Default: 1s)
The Splash view also allows you to customize the animation transition of the splash view with the following animation types of `LDSplashAnimationType`:

    .Fade
    .Bounce
    .Shrink
    .Zoom
    .None
    .Custom
    
    
 SKSplashIcon

In addition to adding an animated splash view, you can also add an icon on your splash view with its own customizability options that will animate as long as the splash view is running. To add a splash icon to your splash view:

Initialize the splash view as follows:

    let splashIcon = LDSplashIcon(initWithImage: iconImage, animationType: LDIconSplashAnimationType)
    //Initialize with the customizability option of your choice. See Customizability for more.
Add the splash icon when you are initializing your splash view

    init!(initWithImage image: UIImage)
    init?(initWithImage image: UIImage, animationType: LDIconSplashAnimationType)

The appearance of the splash icon can be customized with the following properties:

    iconColor: UIColor?
    iconSize: CGSize! //default is set to (80 * 80)

The animation of the splash icon can also be customized with the following animation types:

    .Fade
    .Bounce
    .Ping
    .Grow
    .Blink
    .Shrink
    .Zoom
    .None
    .Custom

 Delegate
You can optionally add the SplashView delegate to your view controller to listen to when the splash view begins and ends animating. To do this:

Add `LDSplashDelegate` to your interface
Set the delegate to your splash view `splashView.delegate = self`
Add the following methods to listen to updates

    func didBeginAnimatingWithDuration(duration: CGFloat) {
        print("Started animating")
    }
    
    func splashViewDidEndAnimating(splashView: LDSplashView) {
        print("Stopped animating")
    }
    

Example
Some examples of splash views created using LDSplashView (Twitter iOS app and Ping iOS app). All code to the examples is available in the Demo. If you found a way to mimick another popular iOS app's splash view using SKSplashView, let me know so I can add it here.


 Community
If you feel you can improve or add more customizability to LDSplashView, feel free to raise an issue/submit a PR.

For any questions, reach out to me on Twitter @pbush25

 License
LDSplashView is available under the MIT License. See the LICENSE for more info.
