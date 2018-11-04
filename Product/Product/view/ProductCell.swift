import UIKit
import Nuke
import Commons
import Foundation

class ProductCell: UICollectionViewCell, CollectionViewCell {

    static var identifier: String = "\(ProductCell.self)"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var designerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellBorderStyle()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(with collectionViewItem: CollectionViewItem) {
        resetContent()
        setUpContent(with: collectionViewItem)
    }

    private func setUpContent(with collectionViewItem: CollectionViewItem) {
        let representable = collectionViewItem as! ProductCellRepresentable
        setUpName(with: representable)
        setUpDesigner(with: representable)
        setUpPrice(with: representable)
        setUpImage(with: representable)
    }

    private func setUpDesigner(with representable: ProductCellRepresentable) {
        designerLabel.text = representable.designer
    }

    private func setUpName(with representable: ProductCellRepresentable) {
        titleLabel.text = representable.name
    }

    private func setUpPrice(with representable: ProductCellRepresentable) {
        priceLabel.text = representable.priceFormatted()
    }

    private func setUpImage(with representable: ProductCellRepresentable) {
        _ = representable.imageUrl
            .map { imageUrl in
                Nuke.loadImage(with: imageUrl, into: imageView)
        }
    }

    private func setUpCellBorderStyle() {
        contentView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        contentView.layer.borderWidth = 0.3
    }

    private func resetContent() {
        contentView.subviews
            .compactMap { $0 as? UILabel }
            .forEach { $0.text = nil }
        imageView.image = nil
    }

}
