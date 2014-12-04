import UIKit

class SidebarTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var arrayKind: [String] = ["Vakanties","Inloggen", "Registreren"]
    var arrayOuder: [String] = ["Uitloggen", "Vakanties", "Favorieten"]
    var arrayMonitor: [String] = ["Uitloggen","Eigen profiel", "Vakanties",  "Vormingen", "Voorkeur vakantie", "Profielen"]
    var arrayJoetz: [String] = ["Uitloggen", "Vakanties", "Vormingen", "Profielen", "Nieuwe monitor"]
    var array: [String]?
    
    
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
    
    func update() {
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PFUser.currentUser() == nil {
            return 3
            
        } else {
            var gebruikerPF = PFUser.currentUser()
            var soort: String = gebruikerPF["soort"] as String
            if soort == "ouder" {
                return 3
            } else {
                return 6
            } // else return 5 (JOETZ)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        
        
        if PFUser.currentUser() == nil {
            cell!.textLabel?.text = self.arrayKind[indexPath.row]

        } else {
            var gebruikerPF = PFUser.currentUser()
            var soort: String = gebruikerPF["soort"] as String
            if soort == "monitor" {
                cell!.textLabel?.text = self.arrayMonitor[indexPath.row]
            } else if soort == "ouder" {
                cell!.textLabel?.text = self.arrayOuder[indexPath.row]
            } // else if soort = JOETZ
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == selectedMenuItem {
            hideSideMenuView()
        }
        selectedMenuItem = indexPath.row
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController: UIViewController
        
        if PFUser.currentUser() == nil {
            self.tableView.reloadData()
            switch indexPath.row {  
            case 0:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                break
            case 1:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Inloggen") as UIViewController
                break
            case 2:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Registreren") as UIViewController
                break
            default:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                
                break
            }
            sideMenuController()?.setContentViewController(destViewController)
        } else {
            var gebruikerPF = PFUser.currentUser()
            var soort: String = gebruikerPF["soort"] as String
            if soort == "monitor" {
                self.tableView.reloadData()
                switch indexPath.row {
                case 0:
                    hideSideMenuView()
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
                    let alertController = UIAlertController(title: "Uitloggen", message: "Wilt u zeker uitloggen?", preferredStyle: .ActionSheet)
                    
                    let callAction = UIAlertAction(title: "Uitloggen", style: UIAlertActionStyle.Destructive, handler: {
                        action in
                        PFUser.logOut()
                        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                        self.sideMenuController()?.setContentViewController(destViewController)
                        self.hideSideMenuView()
                        }
                    )
                    
                    alertController.addAction(callAction)
                    
                    let cancelAction = UIAlertAction(title: "Annuleer", style: .Default, handler: nil)
                    alertController.addAction(cancelAction)
                    
                    presentViewController(alertController, animated: true, completion: nil)
                    break
                case 1:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
                    break
                case 2:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    break
                case 3:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vormingen") as UIViewController
                    break
                case 4:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Voorkeur") as UIViewController
                    break
                case 5:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profielen") as UIViewController
                    break
                default:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
                    break
                }
                
                
                sideMenuController()?.setContentViewController(destViewController)
            } else if soort == "ouder" {
                self.tableView.reloadInputViews()
                switch indexPath.row {
                case 0:
                    hideSideMenuView()
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    let alertController = UIAlertController(title: "Uitloggen", message: "Wilt u zeker uitloggen?", preferredStyle: .ActionSheet)
                    
                    let callAction = UIAlertAction(title: "Uitloggen", style: UIAlertActionStyle.Destructive, handler: {
                        action in
                        PFUser.logOut()
                        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                        self.sideMenuController()?.setContentViewController(destViewController)
                        self.hideSideMenuView()
                        }
                    )
                    alertController.addAction(callAction)
                    
                    let cancelAction = UIAlertAction(title: "Annuleer", style: .Default, handler: nil)
                    alertController.addAction(cancelAction)
                    
                    presentViewController(alertController, animated: true, completion: nil)
                    break
                case 1:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    break
                case 2:
                    var destViewController2: VakantiesTableViewController = /*destViewController = */mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as VakantiesTableViewController
                    destViewController2.favoriet = true
                    destViewController = destViewController2
                    break
                default:
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Vakanties") as UIViewController
                    break
                
                }
                sideMenuController()?.setContentViewController(destViewController)
            } // else if soort = JOETZ
        }
    }

    
}
