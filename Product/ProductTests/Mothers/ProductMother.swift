import Foundation
import SwiftyJSON
import TestHelpers

@testable import Product

class ProductMother {

    class func product() -> ProductResource {
        let data: Data = FileHelper().createData(from: "product-1232802", fileExtension: "json")!
        return ProductResource(json: JSON(data))
    }

    class func productsResource() -> ProductsResource {
        let data: Data = FileHelper().createData(from: "products", fileExtension: "json")!
        return ProductsResource(json: JSON(data))
    }

    class func emptyProductsResource() -> ProductsResource {
        return ProductsResource(json: JSON(emptyProductsJsonData()))
    }

    class func emptyProduct() -> ProductResource {
        return ProductResource(json: JSON("{}".data(using: .utf8)!))
    }

    class func emptyProductsJsonData() -> Data {
        return """
            {"results": []}
        """.data(using: .utf8)!
    }

}
