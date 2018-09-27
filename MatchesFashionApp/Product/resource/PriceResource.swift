import SwiftyJSON

class PriceResource: Resource {

    private(set) var value: Double
    private(set) var currencyCode: String
    

    required init(json: JSON) {
        value = json["value"].doubleValue
        currencyCode = json["currencyIso"].stringValue
    }

    func formatted() -> String {
        return "£\(value)"
    }

    private func url(from url: String) -> URL? {
        return url.hasPrefix("//")
            ? URL(string: "https:\(url)")
            : URL(string: url)
    }

}
