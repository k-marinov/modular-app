import Foundation

struct ProductsRequest: ApiRequest {

    private(set) var httpMethod = HttpMethod.get
    private(set) var url: URL!

    init() throws {
        guard let url: URL = buildUrl() else {
            throw ApiRequestError.invalidUrl
        }
        self.url = url
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

    private func buildUrl() -> URL?  {
        var components = URLComponents(string: "http://matchesfashion.com")!
        components.path = "/womens/shop"
        components.queryItems = [URLQueryItem(name: "format", value:"json")]
        return components.url
    }

}
