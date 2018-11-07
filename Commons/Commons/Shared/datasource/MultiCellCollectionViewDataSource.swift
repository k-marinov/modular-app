import UIKit
import RxSwift

public class MultiCellCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    public private(set) var items: [CollectionViewItem] = [CollectionViewItem]()
    private var cellConfigurations =  [String: CellConfiguration]()

    public init(configuration: DataSourceConfiguration) {
        cellConfigurations = configuration.cellConfigurations
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: CollectionViewItem = items[indexPath.row]
        let configuration: CellConfiguration = cellConfigurations[item.id]!
        return cell(
            with: item,
            cellType: configuration.cellType,
            indexPath: indexPath,
            identifier: configuration.reuseIdentifier,
            collectionView: collectionView)
    }

    public func appendOnce(contentsOf newItems: [CollectionViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

    public func count() -> Int {
        return items.count
    }

    func cell<CELL: CollectionCell>(
        with item: CollectionViewItem,
        cellType: CELL.Type, indexPath: IndexPath,
        identifier: String,
        collectionView: UICollectionView) -> UICollectionViewCell {

        let cell: CELL = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CELL
        cell.configureCell(with: item)
        return cell as CollectionCell
    }

}
