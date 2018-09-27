import SwiftyJSON

struct PriceResource: Resource {

    private let value: Double
    private let currency: Currency

    init(json: JSON) {
        value = json["value"].doubleValue
        currency = Currency(code: json["currencyIso"].string ?? "GBP", conversionRate: 1.0)
    }

    func formatted() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: value * currency.conversionRate)) ?? ""
    }

}
