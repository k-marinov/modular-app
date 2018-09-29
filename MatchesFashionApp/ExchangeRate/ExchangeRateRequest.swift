/** Currency API
 ** https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD
 **/

import Foundation

class ExchangeRateRequest: ApiRequest {

    private(set) var httpMethod = HttpMethod.get
    private(set) var url: URL!

    init(from fromCode: CurrencyCode, to toCode: CurrencyCode) throws {
        guard let url: URL = buildUrl(from: fromCode, to: toCode) else {
            throw ApiRequestError.invalidUrl
        }
        self.url = url
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ExchangeRateResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

    private func buildUrl(from fromCode: CurrencyCode, to toCode: CurrencyCode) -> URL?  {
        var components = URLComponents(string: "https://free.currencyconverterapi.com")!
        components.path = "/api/v6/convert"
        components.queryItems = [URLQueryItem(name: "q", value: fromCode.rawValue + "_" + toCode.rawValue)]
        return components.url
    }

}
