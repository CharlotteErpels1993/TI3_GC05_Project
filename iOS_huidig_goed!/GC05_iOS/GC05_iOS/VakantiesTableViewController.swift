import UIKit

class VakantiesTableViewController: UITableViewController {
    var vakanties: [Vakantie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoekVakanties()
    }
    
    func zoekVakanties() {
        vakanties.removeAll()
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
        } else if segue.identifier == "registreren" {
            let registratie1ViewController = segue.destinationViewController as Registratie1ViewController
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
        cell.gaVerderLabel.text = "Ik wil deze reis!"
        cell.vakantieNaamLabel.text = vakantie.titel
        // TO DO cell.doelgroepImage = vakantie.doelgroep
        return cell
    }
}