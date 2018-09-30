import SwiftyJSON

struct PriceResource: Resource {

    private let value: Double
    private(set) var currencyExchangeRate: CurrencyExchangeRate

    init(json: JSON) {
        value = json["value"].doubleValue
        currencyExchangeRate = CurrencyExchangeRate(
            rate: 1.0,
            currency: Currency.findOrReturnFallback(code: json["currencyIso"].string))
    }

    mutating func setCurrencyExchangeRate(rate: CurrencyExchangeRate) {
        currencyExchangeRate = rate
    }

    func formatted() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyExchangeRate.currency.code
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: value * currencyExchangeRate.rate)) ?? ""
    }

}
