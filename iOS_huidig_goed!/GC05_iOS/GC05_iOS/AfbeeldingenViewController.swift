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
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as AfbeeldingCollectionViewCell
        //cell.image.image = UIImage(named: afb)
        return cell
    }
}