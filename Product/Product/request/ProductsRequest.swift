import Foundation
import Commons

public struct ProductsRequest: ApiRequest {

    public private(set) var httpMethod = HttpMethod.get

    public func url() -> URL {
        var components: URLComponents = URLComponents(string: "https://www.matchesfashion.com")!
        components.path = "/womens/shop"
        components.queryItems = [URLQueryItem(name: "format", value:"json")]
        return components.url!
    }

    public func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

}
