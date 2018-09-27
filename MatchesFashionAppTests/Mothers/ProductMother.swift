import Foundation
import SwiftyJSON

@testable import MatchesFashionApp

class ProductMother {

    class func product() -> ProductResource {
        let data: Data = FileHelper().createData(from: "product-1232802", ofType: "json")!
        return ProductResource(json: JSON(data))
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
