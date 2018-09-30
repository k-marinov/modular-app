import RxSwift

struct ApiClient {

    private let httpClient: HttpClient

    init(creatable: Creatable) {
        httpClient = creatable.create()
    }

    func request(with request: ApiRequest) -> Observable<ApiResponse> {
        return httpClient.request(urlRequest: try! request.asURLRequest())
            .flatMap { newResponse in
                return request.response(from: newResponse)
        }
    }

}
