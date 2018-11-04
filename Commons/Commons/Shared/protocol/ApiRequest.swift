import RxSwift

public protocol ApiRequest {

    var httpMethod: HttpMethod { get }

    func url() -> URL

    func asURLRequest() throws -> URLRequest

    func response(from newResponse: HttpResponse) -> ApiResponse

    func response(from newResponse: HttpResponse) -> Observable<ApiResponse>

}

extension ApiRequest {

    public func asURLRequest() -> URLRequest {
        return urlRequest(with: url())
    }

    public func response(from newResponse: HttpResponse) -> Observable<ApiResponse> {
        return Observable<ApiResponse>.create { observer  in
            if newResponse.error == nil {
                let apiResponse: ApiResponse = self.response(from: newResponse)
                if apiResponse.isSuccess() {
                    observer.onNext(apiResponse)
                    observer.onCompleted()
                } else {
                    observer.onError(apiResponse.apiFailError())
                }
            } else {
                observer.onError(ApiError.network)
            }
            return Disposables.create()
        }
    }

    private func urlRequest(with url: URL) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = httpMethod.rawValue
        appendHttpHeaders(toUrlRequest: &urlRequest)
        return urlRequest
    }

    //Added browser user agent in order to prevent getting 403 status code
    private func appendHttpHeaders(toUrlRequest  urlRequest: inout URLRequest) {
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        urlRequest.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36", forHTTPHeaderField: "User-Agent")
    }

}
