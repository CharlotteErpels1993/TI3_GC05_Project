import UIKit

class AfbeeldingDetailViewController: UIViewController {
    var image: UIImage!
    var images: [UIImage]!
    var nummer: Int!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: ("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: ("handleSwipes:"))
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        /*if nummer == (images.count-1) {
            volgendeButton.hidden = true
        } else {
            volgendeButton.hidden = false
        }
        
        if nummer == 0 {
            vorigeButton.hidden = true
        } else {
            vorigeButton.hidden = false
        }*/
        
        imageView.image = image
    }
    /*@IBAction func volgende(sender: AnyObject) {
        if nummer != (images.count-1) {
            nummer = nummer + 1
            var i = images[nummer]
            self.image = i
            viewDidLoad()
        }
    }
    
    @IBAction func vorige(sender: AnyObject) {
        if nummer != 0 {
            nummer = nummer - 1
            var i = images[nummer]
            self.image = i
            viewDidLoad()
        }
    }*/
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if sender.direction == .Left {
            if nummer != (images.count-1) {
                nummer = nummer + 1
                var i = images[nummer]
                self.image = i
                viewDidLoad()
            }
        }
        
        if sender.direction == .Right {
            if nummer != 0 {
                nummer = nummer - 1
                var i = images[nummer]
                self.image = i
                viewDidLoad()
            }
        }
    }
    
}