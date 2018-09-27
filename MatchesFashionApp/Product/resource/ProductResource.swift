import SwiftyJSON

class ProductResource: Resource {

    private(set) var name: String
    private(set) var designerName: String

    required init(json: JSON) {
        name = json["name"].stringValue
        designerName = json["designer"]["name"].stringValue
    }

}
