import SwiftyJSON
import Foundation

@testable import ExchangeRate

class ExchangeRateMother {

    class func usdToGbpExchangeRate() -> ExchangeRateResource {
        return ExchangeRateResource(json: JSON(usdToGbpJsonData()))
    }

    class func emptyExchangeRate() -> ExchangeRateResource {
        let data: Data = "{}".data(using: .utf8)!
        return ExchangeRateResource(json: JSON(data))
    }

    private class func usdToGbpJsonData() -> Data {
        return """
            {
                "query": {
                "count": 1
            },
            "results": {
                "USD_GBP": {
                    "id": "USD_GBP",
                    "val": 0.76746,
                    "to": "GBP",
                    "fr": "USD"
                    }
                }
            }
            """.data(using: .utf8)!
    }

}
