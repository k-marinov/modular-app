import SwiftyJSON

public struct CurrencyExchangeRate {

    public let rate: Double
    public let currency: Currency

    public init(rate: Double, currency: Currency) {
        self.rate = rate
        self.currency = currency
    }

}
