/** Currency API
 ** https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD
 **/

import Foundation

class ExchangeRateRequest: ApiRequest {

    private let fromCode: Currency
    private(set) var httpMethod = HttpMethod.get
    private(set) var toCode: Currency

    init(from fromCode: Currency, to toCode: Currency) {
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

    private func buildUrl(from fromCode: Currency, to toCode: Currency) -> URL  {
        let value: String = fromCode.code + "_" + toCode.code
        var components: URLComponents = URLComponents(string: "https://free.currencyconverterapi.com")!
        components.path = "/api/v6/convert"
        components.queryItems = [URLQueryItem(name: "q", value: value)]
        return components.url!
    }

}
