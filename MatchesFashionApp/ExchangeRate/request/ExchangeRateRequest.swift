/** Currency API
 ** https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD
 **/

import Foundation

class ExchangeRateRequest: ApiRequest {

    private(set) var httpMethod = HttpMethod.get
    private let fromCode: CurrencyCode
    private let toCode: CurrencyCode

    init(from fromCode: CurrencyCode, to toCode: CurrencyCode) {
        self.fromCode = fromCode
        self.toCode = toCode
    }

    func url() -> URL {
        return buildUrl(from: fromCode, to: toCode)
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ExchangeRateResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

    private func buildUrl(from fromCode: CurrencyCode, to toCode: CurrencyCode) -> URL  {
        let value: String = fromCode.rawValue + "_" + toCode.rawValue
        var components: URLComponents = URLComponents(string: "https://free.currencyconverterapi.com")!
        components.path = "/api/v6/convert"
        components.queryItems = [URLQueryItem(name: "q", value: value)]
        return components.url!
    }

}
