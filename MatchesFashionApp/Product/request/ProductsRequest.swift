import Foundation

struct ProductsRequest: ApiRequest {

    private(set) var httpMethod = HttpMethod.get

    func url() -> URL {
        var components: URLComponents = URLComponents(string: "http://www.matchesfashion.com")!
        components.path = "/womens/shop"
        components.queryItems = [URLQueryItem(name: "format", value:"json")]
        return components.url!
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

}
