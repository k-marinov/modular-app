import SwiftyJSON
import Commons

struct ProductsResource: Resource {

    private(set) var products: [ProductResource] = [ProductResource]()

    init(json: JSON) {
        let newProducts: [ProductResource] = json["results"].arrayValue
            .compactMap { ProductResource(json: $0) }
        if !newProducts.isEmpty {
            products.append(contentsOf: newProducts)
        }
    }

}
