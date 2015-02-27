import UIKit

class AfbeeldingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    image = UIImageView(frame: CGRect(x: 0, y: 16, width: frame.size.width, height: frame.size.height*2/3))
    image.contentMode = UIViewContentMode.ScaleAspectFit
    contentView.addSubview(image)

    }
    
    required init(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
}

