func annuleerControllerRegistratie(controller: UIViewController) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let alertController = UIAlertController()
    
    let callAction = UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Destructive, handler: {
        action in
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Inloggen") as UIViewController
        controller.sideMenuController()?.setContentViewController(destViewController)
        controller.hideSideMenuView()
        }
    )
    alertController.addAction(callAction)
    
    let cancelAction = UIAlertAction(title: "Ga terug", style: .Default, handler: nil)
    alertController.addAction(cancelAction)
    
    controller.presentViewController(alertController, animated: true, completion: nil)
}

func annuleerControllerVoorkeur(controller: UIViewController) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let alertController = UIAlertController()
    
    let callAction = UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Destructive, handler: {
        action in
        var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
        controller.sideMenuController()?.setContentViewController(destViewController)
        controller.hideSideMenuView()
        }
    )
    alertController.addAction(callAction)
    
    let cancelAction = UIAlertAction(title: "Ga terug", style: .Default, handler: nil)
    alertController.addAction(cancelAction)
    
    controller.presentViewController(alertController, animated: true, completion: nil)
}

func annuleerControllerInschrijvenVakantieVorming(controller: UIViewController) {
    let alertController = UIAlertController()
    
    let callAction = UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Destructive, handler: {
        action in
        controller.performSegueWithIdentifier("gaTerug", sender: controller)
        controller.hideSideMenuView()
        }
    )
    alertController.addAction(callAction)
    
    let cancelAction = UIAlertAction(title: "Ga terug", style: .Default, handler: nil)
    alertController.addAction(cancelAction)
    
    controller.presentViewController(alertController, animated: true, completion: nil)
}

