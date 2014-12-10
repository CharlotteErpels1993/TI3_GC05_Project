import UIKit

class FeedbackTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var zoekbar: UISearchBar!
    @IBOutlet var addButton: UIBarButtonItem!
    
    var feedbacken: [Feedback] = []
    var feedbacken2: [Feedback] = []
    //var vakantieId: String?
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        
        ParseData.deleteFeedbackTable()
        ParseData.vulFeedbackTableOp()
        var feedbackenResponse = ParseData.getAlleFeedback()
        
        if feedbackenResponse.1 == nil {
            self.feedbacken = feedbackenResponse.0
            self.feedbacken2 = self.feedbacken
            self.tableView.reloadData()
            feedbacken2.sort({ $0.vakantie!.titel < (String($1.score!)) })
            feedbacken2.sort({ $0.vakantie!.titel < (String($1.score!)) })
        } else {
            foutBoxOproepen("Oeps", "Er is nog geen feedback.", self)
        }
        
        if PFUser.currentUser() == nil {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        zoekbar.showsScopeBar = true
        zoekbar.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.toolbarHidden = true
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        setTitleCancelButton(searchBar)
        zoekGefilterdeFeedback(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        zoekGefilterdeFeedback(searchBar.text)
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
        searchBar.showsCancelButton = true
        setTitleCancelButton(searchBar)
        zoekGefilterdeFeedback(searchText.lowercaseString)
    }
    
    func zoekGefilterdeFeedback(zoek: String) {
        feedbacken2 = feedbacken.filter { $0.vakantie!.titel!.lowercaseString.rangeOfString(zoek) != nil }
        if zoek.isEmpty {
            self.feedbacken2 = feedbacken
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add" {
            let geefFeedback1ViewController = segue.destinationViewController as GeefFeedback1ViewController
            //geefFeedbackViewController.vakantie = self.vakantieId
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacken2.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedbackCell", forIndexPath: indexPath) as FeedbackCell
        let feedback = feedbacken2[indexPath.row]
        cell.vakantieNaam.text = feedback.vakantie!.titel!
        cell.feedback.text = feedback.waardering!
        cell.score.text = "\(feedback.score!)/5"
        
        return cell
    }
    
    /*func setMenuToggleBarButtonItem() {
        var rightImage: UIImage = UIImage(named: "menu")!
        var rightItem: UIBarButtonItem = UIBarButtonItem(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: "toggle")
        self.navigationItem.leftBarButtonItem = rightItem
    }
    
    func toggle() {
        toggleSideMenuView()
    }*/
    
    @IBAction func refresh(sender: UIRefreshControl) {
        var parseData = ParseData()
        ParseData.deleteAllTables()
        ParseData.createDatabase()
        self.refreshControl?.endRefreshing()
        viewDidLoad()
    }
}