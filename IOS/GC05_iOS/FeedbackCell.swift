import UIKit

class FeedbackCell: UITableViewCell {
    
    @IBOutlet var vakantieNaam: UILabel!
    @IBOutlet var feedback: UILabel!
    @IBOutlet var score: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
