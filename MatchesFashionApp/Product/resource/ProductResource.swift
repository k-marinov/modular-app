import SwiftyJSON

class ProductResource: Resource {

    private(set) var name: String

    required init(json: JSON) {
        name = json["name"].stringValue
    }

}
