import Foundation
import Commons

public protocol ProductCellRepresentable: CollectionViewItem {

    var name: String { get }

    var designer: String { get }

    var imageUrl: URL? { get }

    func priceFormatted() -> String

}
