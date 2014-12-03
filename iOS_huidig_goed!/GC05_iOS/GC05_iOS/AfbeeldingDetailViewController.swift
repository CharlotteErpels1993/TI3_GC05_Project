import UIKit

class AfbeeldingDetailViewController: UIViewController {
    var image: UIImage!
    var images: [UIImage]!
    var nummer: Int!

    @IBOutlet var volgendeButton: UIButton!
    @IBOutlet var vorigeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if nummer == (images.count-1) {
            volgendeButton.hidden = true
        } else {
            volgendeButton.hidden = false
        }
        
        if nummer == 0 {
            vorigeButton.hidden = true
        } else {
            vorigeButton.hidden = false
        }
        
        imageView.image = image
    }
    @IBAction func volgende(sender: AnyObject) {
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
    }
    
}