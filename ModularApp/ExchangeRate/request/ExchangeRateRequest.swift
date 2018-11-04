/** Currency API
 ** https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD
 **/

import Foundation

struct ExchangeRateRequest: ApiRequest {

    private let fromCurrency: Currency
    private(set) var httpMethod = HttpMethod.get
    private(set) var toCurrency: Currency

    init(from fromCurrency: Currency, to toCurrency: Currency) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }

    func url() -> URL {
        return buildUrl(from: fromCurrency, to: toCurrency)
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
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
