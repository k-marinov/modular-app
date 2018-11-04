import SwiftyJSON

struct ProductResource: Resource, ProductCellRepresentable {

    private var price: PriceResource
    private(set) var name: String
    private(set) var designer: String
    private(set) var imageUrl: URL?

    init(json: JSON) {
        name = json["name"].stringValue
        designer = json["designer"]["name"].stringValue
        price = PriceResource(json: json["price"])
        imageUrl = url(from: json["primaryImageMap"]["medium"]["url"].stringValue)
    }

    mutating func setCurrencyExchangeRate(rate: CurrencyExchangeRate) -> ProductResource {
        price.setCurrencyExchangeRate(rate: rate)
        return self
    }

    func priceFormatted() -> String {
        return price.formatted()
    }

    private func url(from url: String) -> URL? {
        return url.hasPrefix("//")
            ? URL(string: "https:\(url)")
            : URL(string: url)
    }

}
