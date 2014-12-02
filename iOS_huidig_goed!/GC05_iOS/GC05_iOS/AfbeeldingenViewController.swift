import UIKit

class AfbeeldingenViewController: UICollectionViewController {

    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "afbeelding" {
            let afbeeldingViewController = segue.destinationViewController as AfbeeldingDetailViewController
            var indexPath: NSIndexPath = self.collectionView.indexPathsForSelectedItems()?.last! as NSIndexPath
            var image: UIImage! = self.images[indexPath.row]
            afbeeldingViewController.image = image
            afbeeldingViewController.images = self.images
            afbeeldingViewController.nummer = indexPath.row
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("afbeeldingcell", forIndexPath: indexPath) as AfbeeldingCollectionViewCell
        let image = images[indexPath.row]
        cell.image.image = image
        return cell
    }
}

