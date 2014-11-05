import UIKit

class VakantiesTableViewController: UITableViewController {
    var vakanties: [Vakantie] = []
    
    var query = PFQuery(className: "Vakantie")
    
   /* override func viewDidLoad() {
        super.viewDidLoad()
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    var vakantie = Vakantie(vakantie: object as PFObject)
                    self.vakanties.append(vakantie)
                }
            }
        }
    }*/
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toonVakantie" {
            let vakantieDetailsController = segue.destinationViewController as VakantieDetailsTableViewController
            let selectedVakantie = vakanties[tableView.indexPathForSelectedRow()!.row]
            vakantieDetailsController.vakantie = selectedVakantie as Vakantie
        } else if segue.identifier == "registreren" {
            let registratie1ViewController = segue.destinationViewController as Registratie1ViewController
        } else if segue.identifier == "inloggen" {
            let inloggenViewController = segue.destinationViewController as InloggenViewController
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
        //cell.vakantieNaamTxt.Text = vakantie.titel
        //cell.gaVerderTxt.text = "Ik wil op reis!"
        //cell.doelgroepImageView = vakantie.doelgroep
        return cell
    }
}