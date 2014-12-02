import UIKit

class AfbeeldingCollectionViewCell: UICollectionViewCell {
    
    /*@IBOutlet weak var image: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }*/
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //let textLabel: UILabel!
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 16, width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
        
        //let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
        //textLabel = UILabel(frame: textFrame)
        //textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        //textLabel.textAlignment = .Center
        //contentView.addSubview(textLabel)
    }
}