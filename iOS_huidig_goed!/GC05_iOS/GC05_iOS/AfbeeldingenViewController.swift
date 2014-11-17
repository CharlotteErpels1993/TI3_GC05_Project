import UIKit

class AfbeeldingenViewController: UICollectionViewController {
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "afbeelding" {
            /*let indexPath = collectionView.indexPathsForSelectedItems()
            let object = collectionView.selectItemAtIndexPath(indexPath?.first as NSIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
            let afbeeldingDetailViewController = segue.destinationViewController as AfbeeldingDetailViewController
            afbeeldingDetailViewController.image = object
            //let indexPath! = self.collectionView.indexPathsForSelectedItems()
            //let object = self.collectionView.cellForItemAtIndexPath(indexPath)*/
            //let index = self.collectionView
            //var view = collectionView
            //self.images[view.indexPathsForSelectedItems()[indexPath.row]]
           // let selected = self.images[collectionView as TableView
            //    indexPathForSelectedRow()!.row]
            let afbeeldingViewController = segue.destinationViewController as AfbeeldingDetailViewController
            var indexPath: NSIndexPath = self.collectionView.indexPathsForSelectedItems()?.last! as NSIndexPath
            var image: UIImage! = self.images[indexPath.row]
            afbeeldingViewController.image = image
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("afbeeldingcell", forIndexPath: indexPath) as AfbeeldingCollectionViewCell
        let image = images[indexPath.row]
        /*for image in images {
            cell.image.image = image
        }*/
        cell.image.image = image
        return cell
    }
}