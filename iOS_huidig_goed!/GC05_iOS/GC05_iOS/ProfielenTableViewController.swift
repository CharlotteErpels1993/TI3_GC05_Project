import UIKit

class ProfielenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var profielen  = []
    var profielen2 = []
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //zoekVormingen()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    /*func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeProf ,ielen(searchText.lowercaseString)
    }*/
    
    /*func zoekGefilterdeVormingen(zoek: String) {
        profielen2 = profielen.filter { $0.titel.lowercaseString.rangeOfString(zoek) != nil }
        self.tableView.reloadData()
        
    }*/
    
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
        /*if segue.identifier == "toonVorming" {
            let vormingDetailsController = segue.destinationViewController as VormingDetailsTableViewController
            let selectedVorming = vormingen[tableView.indexPathForSelectedRow()!.row]
            vormingDetailsController.vorming = selectedVorming as Vorming
            //vormingDetailsController.monitor = self.monitor
        }*/
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profielen2.count
    }
    
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell", forIndexPath: indexPath) as UITableViewCell
        //let cell = tableView.dequeueReusableCellWithIdentifier("vormingCell")? as UITableViewCell
        let vorming = vormingen2[indexPath.row]
        
        cell.textLabel.text = vorming.titel
        cell.detailTextLabel!.text = "Meer informatie"
        return cell
    }*/
}