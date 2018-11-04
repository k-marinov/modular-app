/** Currency API
 ** https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD
 **/

import Foundation
import Commons

public struct ExchangeRateRequest: ApiRequest {

    private let fromCurrency: Currency
    public private(set) var httpMethod = HttpMethod.get
    public private(set) var toCurrency: Currency

    public init(from fromCurrency: Currency, to toCurrency: Currency) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }

    public func url() -> URL {
        return buildUrl(from: fromCurrency, to: toCurrency)
    }

    public func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ExchangeRateResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

    private func buildUrl(from fromCurrency: Currency, to toCurrency: Currency) -> URL  {
        let value: String = fromCurrency.code + "_" + toCurrency.code
        var components: URLComponents = URLComponents(string: "https://free.currencyconverterapi.com")!
        components.path = "/api/v6/convert"
        components.queryItems = [URLQueryItem(name: "q", value: value)]
        return components.url!
    }

}
