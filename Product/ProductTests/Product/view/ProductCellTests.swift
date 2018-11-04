import XCTest
import TestHelpers

@testable import Product

class ProductCellTests: XCTestCase {

    var cell: ProductCell!

    override func setUp() {
        super.setUp()
        cell = NibCreator.createNib(ofClass: ProductCell.self) as? ProductCell
    }

    func testConfigureCell_whenHasContent_setsLabelText() {
        let product: ProductResource = ProductMother.productsResource().products.first!
        cell.configureCell(with: product)

        XCTAssertEqual(cell.designerLabel.text, "Gucci")
        XCTAssertEqual(cell.priceLabel.text, "£3,550")
        XCTAssertEqual(cell.titleLabel.text, "Floral-print silk-twill maxi dress ")
    }

    func testIdentifier_returnsProductCell() {
        XCTAssertEqual(ProductCell.identifier, "ProductCell")
    }

}
