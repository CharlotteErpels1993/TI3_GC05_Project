import UIKit

class VormingenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vormingen: [Vorming] = []
    var vormingen2: [Vorming] = []
    var monitor: Monitor!
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoekVormingen()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeVormingen(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVormingen(zoek: String) {
        vormingen2 = vormingen.filter { $0.titel.lowercaseString.rangeOfString(zoek) != nil }
        self.tableView.reloadData()
        
    }
    
    func zoekVormingen() {
        vormingen.removeAll(keepCapacity: true)
        var query = PFQuery(className: "Vorming")
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vorming = Vorming(vorming: object)
                        self.vormingen.append(vorming)
                        print(vorming)
                    }
                }
                self.vormingen2 = self.vormingen
                self.tableView.reloadData()
            }
            println(error)
        })
    }
    
    /*@IBAction func gaTerugNaarOverzichtVormingen(segue: UIStoryboardSegue) {
        // TO DO ouder insteken?
    }*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVorming" {
            let vormingDetailsController = segue.destinationViewController as VormingDetailsTableViewController
            let selectedVorming = vormingen[tableView.indexPathForSelectedRow()!.row]
            vormingDetailsController.vorming = selectedVorming as Vorming
            vormingDetailsController.monitor = self.monitor
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
        cell.textLabel.text = vorming.titel
        cell.detailTextLabel!.text = "Meer informatie"
        return cell
    }
}