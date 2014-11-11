import UIKit
import Foundation

class VakantiesTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var vakanties: [Vakantie] = []
    var vakanties2: [Vakantie] = []
    var ouder: Ouder?
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoekVakanties()
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        zoekGefilterdeVakanties(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVakanties(zoek: String) {
        vakanties2.removeAll(keepCapacity: true)
        for vakantie in vakanties {
            vakanties2.append(vakantie)
        }
        
        //var zoek = zoekbar.text.lowercaseString
        vakanties.removeAll(keepCapacity: true)
        if zoek.isEmpty {
           zoekVakanties()
        } else {
            for vakantie in vakanties2 {
                if (vakantie.titel.lowercaseString.rangeOfString(zoek) != nil) {
                    vakanties.append(vakantie)
                }
            }
        }
        self.tableView.reloadData()
            
    }
    
    func zoekVakanties() {
        vakanties.removeAll(keepCapacity: true)
        var query = PFQuery(className: "Vakantie")
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if(error == nil) {
                if let PFObjects = objects as? [PFObject!] {
                    for object in PFObjects {
                        var vakantie = Vakantie(vakantie: object)
                        self.vakanties.append(vakantie)
                    }
                }
                self.tableView.reloadData()
            }
        })
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
            vakantieDetailsController.ouder = ouder
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
        } else if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vakanties.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vakantieCell", forIndexPath: indexPath) as VakantieCell
        let vakantie = vakanties[indexPath.row]
        cell.gaVerderLabel.text = "Meer details"
        cell.vakantieNaamLabel.text = vakantie.titel
        cell.doelgroepLabel.text = " \(vakantie.doelgroep) jaar "
        return cell
    }
}