import UIKit

class AfbeeldingDetailViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var acivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acivityIndicatorView.startAnimating()
        imageView.image = image
        acivityIndicatorView.stopAnimating()

    }
}