class ProductsRequest: ApiRequest {

    func httpRequestUrl() -> String {
        return "http://matchesfashion.com/womens/shop?format=json"
    }

    func httpMethod() -> HttpMethod {
        return HttpMethod.get
    }

    func response(from newResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(
            resourceType: ProductsResource.self,
            httpResponse: newResponse,
            successHttpStatusCode: HttpStatusCode.ok)
    }

}
