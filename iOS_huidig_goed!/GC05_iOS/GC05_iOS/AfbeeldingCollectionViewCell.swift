import UIKit

class AfbeeldingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
}