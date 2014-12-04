func getActivityIndicatorView(controller: UIViewController) -> UIActivityIndicatorView {
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    activityIndicator.color = UIColor.redColor()
    activityIndicator.center = controller.view.center
    activityIndicator.startAnimating()
    controller.view.addSubview(activityIndicator)
    
    return activityIndicator
}

