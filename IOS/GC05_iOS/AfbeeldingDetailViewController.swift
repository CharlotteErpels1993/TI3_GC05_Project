import UIKit

class AfbeeldingDetailViewController: UIViewController {
    var image: UIImage!
    var images: [UIImage]!
    var nummer: Int!

    @IBOutlet weak var imageView: UIImageView!
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de tool bar verborgen is
    //         - zorgt voor het swipen tussen afbeeldingen (zowel links als rechts)
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: ("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: ("handleSwipes:"))
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        imageView.image = image
    }
    
    //
    //Naam: handleSwipes
    //
    //Werking: - kijkt welke richting de sender heeft: 
    //              * Links: de gebruiker mag swipen naar links zolang er afbeeldingen zijn
    //              * Rechts: de gebruiker mag swipen naar rechts zolang er afbeeldingen zijn
    //
    //Parameters:
    //  - sender: UISwipeGestureRecognizer
    //
    //Return:
    //
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