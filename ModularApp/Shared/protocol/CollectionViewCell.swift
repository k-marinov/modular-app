protocol CollectionViewCell {

    static var identifier: String { get }

    func configureCell(with collectionViewItem: CollectionViewItem)

}
