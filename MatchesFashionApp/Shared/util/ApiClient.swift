import RxSwift

class ApiClient {

    private let httpClient: HttpClient

    required init(creatable: Creatable) {
        httpClient = creatable.create()
    }

    func request(with request: ApiRequest) -> Observable<ApiResponse> {
        return httpClient.request(urlRequest: try! request.asURLRequest())
            .flatMap { newResponse in
                return request.response(from: newResponse)
        }
    }

}
