import UIKit

class VakantiesTableViewController: UITableViewController {
    var vakanties: [Vakantie] = []
    
    //class override func viewDidLoad() {
        // TO DO
    //}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie
        } else if segue.identifier == "registreren" {
            let registratie1ViewController = segue.destinationViewController as Registratie1ViewController
        } else /*if segue.identifier == "inloggen"*/ {
            let inloggenViewController = segue.destinationViewController as InloggingViewController
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vakanties.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vakantieCell", forIndexPath: indexPath) as UITableViewCell
        let vakantie = vakanties[indexPath.row]
        cell.textLabel.text = vakantie.titel
        cell.detailTextLabel!.text = "Bekijk vakantie"
        return cell
    }
}
