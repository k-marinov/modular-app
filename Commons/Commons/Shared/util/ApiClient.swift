import RxSwift

public struct ApiClient {

    private let httpClient: HttpClient

    public init(creatable: Creatable) {
        httpClient = creatable.create()
    }

    public func request(with request: ApiRequest) -> Observable<ApiResponse> {
        return httpClient.request(urlRequest: try! request.asURLRequest())
            .flatMap { newResponse in
                return request.response(from: newResponse)
        }
    }

}
