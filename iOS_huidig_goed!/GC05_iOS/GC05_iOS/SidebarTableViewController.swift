import UIKit

class SidebarTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel.text = "test"
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == selectedMenuItem {
            return
        }
        selectedMenuItem = indexPath.row
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController: UIViewController
        
        switch indexPath.row {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Inloggen") as UIViewController
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Registreren") as UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4") as UIViewController
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
}
