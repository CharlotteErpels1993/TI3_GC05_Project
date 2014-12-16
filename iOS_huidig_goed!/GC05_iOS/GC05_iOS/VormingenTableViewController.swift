import UIKit

class VormingenTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var vormingen: [Vorming] = []
    var vormingen2: [Vorming] = []
    
    @IBAction func toggle(sender: AnyObject) {
        searchBarCancelButtonClicked(zoekbar)
        toggleSideMenuView()
    }
    
    @IBOutlet weak var zoekbar: UISearchBar!
    
    @IBAction func gaTerugNaarVormingTableView(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        
        self.vormingen = LocalDatastore.getLocalObjects(Constanten.TABLE_VORMING) as [Vorming]
        self.vormingen2 = self.vormingen
        self.tableView.reloadData()
        
        vormingen2.sort({ $0.titel < $1.titel })
        vormingen.sort({ $0.titel < $1.titel })
        
        /*var vormingenResponse = ParseData.getAlleVormingen()
        
        if vormingenResponse.1 == nil {
            self.vormingen = vormingenResponse.0
            self.vormingen2 = self.vormingen
            self.tableView.reloadData()
            
            vormingen2.sort({ $0.titel < $1.titel })
            vormingen.sort({ $0.titel < $1.titel })
        }*/
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        hideSideMenuView()
        setTitleCancelButton(searchBar)
        zoekGefilterdeVormingen(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeVormingen(searchBar.text)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func setTitleCancelButton(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        var cancelButton: UIButton?
        var topView: UIView = searchBar.subviews[0] as UIView
        for subView in topView.subviews {
            cancelButton = subView as? UIButton
        }
        
        cancelButton?.setTitle("Annuleer", forState: UIControlState.Normal)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        hideSideMenuView()
        searchBar.showsCancelButton = true
        setTitleCancelButton(searchBar)
        zoekGefilterdeVormingen(searchText.lowercaseString)
    }
    
    func zoekGefilterdeVormingen(zoek: String) {
        vormingen2 = vormingen.filter {$0.titel?.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.vormingen2 = vormingen
        }
        self.tableView.reloadData()
        
    }
    
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
    
    @IBAction func refresh(sender: UIRefreshControl) {
        LocalDatastore.getTableReady(Constanten.TABLE_VORMING)
        
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}