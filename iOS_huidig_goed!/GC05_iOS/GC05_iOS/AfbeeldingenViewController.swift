import UIKit

class AfbeeldingenViewController: UICollectionViewController {
    var images: [UIImage] = []
    
    //
    //Naam: viewDidLoad
    //
    //Werking: - zorgt ervoor dat de tool bar verborgen wordt
    //
    //Parameters:
    //
    //Return:
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }
    
    //
    //Naam: prepareForSegue
    //
    //Werking: - maakt de volgende view met opgegeven identifier (stelt soms attributen van de volgende view op)
    //
    //Parameters:
    //  - segue: UIStoryboardSegue
    //  - sender: AnyObject?
    //
    //Return:
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "afbeelding" {
            let afbeeldingViewController = segue.destinationViewController as AfbeeldingDetailViewController
            var indexPath: NSIndexPath = self.collectionView?.indexPathsForSelectedItems().last! as NSIndexPath
            var image: UIImage! = self.images[indexPath.row]
            afbeeldingViewController.image = image
            afbeeldingViewController.images = self.images
            afbeeldingViewController.nummer = indexPath.row
        }
    }
    
    //
    //Naam: collectionView
    //
    //Werking: - stelt de aantal items in per section
    //
    //Parameters:
    //  - collectionView: UICollectionView
    //  - numberOfItemsInSection section: Int
    //
    //Return: het aantal items in een section
    //
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //Naam: collectionView
    //
    //Werking: - zorgt ervoor dat elke cell wordt ingevuld met de juiste gegevens
    //
    //Parameters:
    //  - collectionView: UICollectionView
    //  - cellForItemAtIndexPath indexPath: NSIndexPath
    //
    //Return: een UICollectionViewCell met de juiste gegevens
    //
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("afbeeldingcell", forIndexPath: indexPath) as AfbeeldingCollectionViewCell
        let image = images[indexPath.row]
        cell.image.image = image
        return cell
    }
}

