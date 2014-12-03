import UIKit

class VormingenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vormingen: [Vorming] = []
    var vormingen2: [Vorming] = []
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func gaTerugNaarVormingTableView(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        ParseData.deleteVormingTable()
        
        var activityIndicator = getActivityIndicatorView(self)
        
        ParseData.vulVormingTableOp()
        //zoekVormingen()
        self.vormingen = ParseData.getAlleVormingen()
        self.vormingen2 = self.vormingen
        self.tableView.reloadData()
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
        
        vormingen2.sort({ $0.titel < $1.titel })
        vormingen.sort({ $0.titel < $1.titel })
        
        activityIndicator.stopAnimating()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeVormingen(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVormingen(zoek: String) {
        vormingen2 = vormingen.filter {$0.titel?.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.vormingen2 = vormingen
        }
        self.tableView.reloadData()
        
    }
    
    /*func zoekVormingen() {
        vormingen.removeAll(keepCapacity: true)
        var query = PFQuery(className: "Vorming")
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vorming = Vorming(vorming: object)
                        self.vormingen.append(vorming)
                    }
                }
                self.vormingen2 = self.vormingen
                self.tableView.reloadData()
            }
        })
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVorming" {
            let vormingDetailsController = segue.destinationViewController as VormingDetailsTableViewController
            let selectedVorming = vormingen[tableView.indexPathForSelectedRow()!.row]
            vormingDetailsController.vorming = selectedVorming as Vorming
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vormingen2.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell", forIndexPath: indexPath) as UITableViewCell
        let vorming = vormingen2[indexPath.row]

        cell.textLabel?.text = vorming.titel
        cell.detailTextLabel!.text = "Meer informatie"
        return cell
    }
}