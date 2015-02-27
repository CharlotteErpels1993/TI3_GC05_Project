import UIKit

class VakantieCell: UITableViewCell {
    
    @IBOutlet weak var doelgroepLabel: UILabel!
    @IBOutlet weak var vakantieNaamLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet var afbeelding: UIImageView!

    @IBOutlet weak var ster1: UIImageView!
    @IBOutlet weak var ster2: UIImageView!
    @IBOutlet weak var ster3: UIImageView!
    @IBOutlet weak var ster4: UIImageView!
    @IBOutlet weak var ster5: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
