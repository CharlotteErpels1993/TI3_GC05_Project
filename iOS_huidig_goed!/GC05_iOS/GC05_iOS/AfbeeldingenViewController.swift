import UIKit

class AfbeeldingenViewController: UICollectionViewController {
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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