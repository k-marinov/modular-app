import SwiftyJSON
import Commons
import ExchangeRate

public struct ProductResource: Resource, ProductCellRepresentable {

    private var price: PriceResource
    public private(set) var name: String
    public private(set) var designer: String
    public private(set) var imageUrl: URL?

    public init(json: JSON) {
        name = json["name"].stringValue
        designer = json["designer"]["name"].stringValue
        price = PriceResource(json: json["price"])
        imageUrl = url(from: json["primaryImageMap"]["medium"]["url"].stringValue)
    }

    public mutating func setCurrencyExchangeRate(rate: CurrencyExchangeRate) -> ProductResource {
        price.setCurrencyExchangeRate(rate: rate)
        return self
    }

    public func priceFormatted() -> String {
        return price.formatted()
    }

    private func url(from url: String) -> URL? {
        return url.hasPrefix("//")
            ? URL(string: "https:\(url)")
            : URL(string: url)
    }

}
