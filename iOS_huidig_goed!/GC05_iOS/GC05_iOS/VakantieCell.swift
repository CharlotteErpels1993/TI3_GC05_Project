import UIKit

class VakantieCell: UITableViewCell {
    
    @IBOutlet weak var doelgroepLabel: UILabel!
    @IBOutlet weak var vakantieNaamLabel: UILabel!
    @IBOutlet weak var locatieLabel: UILabel!
    @IBOutlet var afbeelding: UIImageView!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
