

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Parse.enableLocalDatastore()
        
        Parse.setApplicationId("a3jgklEb2rHZYcgqDezLfqSP6i1C2u4eVV8R03YS", clientKey:
            "3ZguW3kx5J6PuieccT7ypJ5ZvYhwX08ESKL8cDNX")
        
        //Moet eigenlijk aangeroepen worden voor setApplicationId()
        //Bug van Parse
        //Er is een fix die samen met de volgende SDK release zal uitkomen
        Parse.enableLocalDatastore()
        
        /*if Reachability.isConnectedToNetwork() {
            //er is internet
            if isEmptyInLocalDataStore("Vakantie") == true {
                fillTableInLocalDatastore("Vakantie")
            } else {
                updateObjectsInLocalDataStoreFromParse("Vakantie")
            }
        }*/
        
        
        /*if !Reachability.isConnectedToNetwork() {
            var response: ([String], Int?) = SD.existingTables()

            if response.1 == nil {
                
            }
            
        }*/
        
        
        
        if PFUser.currentUser() != nil {
            PFUser.logOut()
        }
        
        //ParseData.deleteAllTables()
        /*if Reachability.isConnectedToNetwork() {
            ParseData.createDatabase()
        }*/

        
        // Connectie check
        /*if Reachability.isConnectedToNetwork() {
            self.parseData.createDatabase()
        } else {
            var alert = UIAlertController(title: "Oeps..", message: "Je hebt geen internet verbinding. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { action in
                exit(0)
            }))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
                
            }))
            ViewController(alert, animated: true, completion: nil)
        }*/
        
        /*if Reachability.isConnectedToNetwork() {
            self.parseData.createDatabase()
        } else {
            var alert = UIAlertController(title: "Oeps..", message: "Je hebt geen internet verbinding. Ga naar instellingen om dit aan te passen.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ga naar instellingen", style: .Default, handler: { action in
                switch action.style{
                default:
                    UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!);
                }
            }))

            
            /*alert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { action in
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
            }))
            self.presentViewController(alert, animated: true, completion: nil)*/
            /*let alertController = UIAlertController(title: "Oeps...", message: "Je hebt geen internet verbinding. Ga naar settings om dit aan te passen.", preferredStyle: .ActionSheet)
            
            let callAction = UIAlertAction(title: "Settings", style: .Default, handler: {
                action in
                /*let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)*/
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
                }
            )
            alertController.addAction(callAction)
            
            let defaultAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertController.addAction(defaultAction)*/
            
            //presentViewController(alertController, animated: true, completion: nil)
        }*/
        
        return true
    }
    
    /*func applicationDidFinishLaunching(application: UIApplication) {
        Parse.setApplicationId("a3jgklEb2rHZYcgqDezLfqSP6i1C2u4eVV8R03YS", clientKey: "3ZguW3kx5J6PuieccT7ypJ5ZvYhwX08ESKL8cDNX")
    }*/
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

