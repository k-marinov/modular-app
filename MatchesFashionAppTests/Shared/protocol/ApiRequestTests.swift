import XCTest
import RxSwift

@testable import MatchesFashionApp

class ApiRequestTests: XCTestCase {

    private let disposeBag: DisposeBag = DisposeBag()

    func testAsURLRequest_whenValidUrl_returnsURLRequest() {
        let request: ProductsRequest = ProductsRequest()
        let contentTypeHeaderValue: String? = request.asURLRequest().allHTTPHeaderFields?["Content-Type"]
        let httpMethod: String? = request.asURLRequest().httpMethod
        let cachePolicy: URLRequest.CachePolicy = request.asURLRequest().cachePolicy
        let timeoutInterval: TimeInterval = request.asURLRequest().timeoutInterval

        XCTAssertEqual(contentTypeHeaderValue, "application/json")
        XCTAssertEqual(httpMethod, "GET")
        XCTAssertEqual(cachePolicy, URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
        XCTAssertEqual(timeoutInterval, 30)
    }

    func testResponse_whenHasHttpResponseError_returnsApiErrorNetwork() {
        var apiError: ApiError?
        let request: ProductsRequest = ProductsRequest()
        let response: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: -1)

        let expectation = self.expectation(description: "")
        request.response(from: response)
            .subscribe(onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.network)
    }

    func testResponse_whenHasHttpResponseWithStatusCode400_returnsClientError() {
        var apiError: ApiError?
        let request: ProductsRequest = ProductsRequest()
        let response: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 400)

        let expectation = self.expectation(description: "")
        request.response(from: response)
            .subscribe(onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.client)
    }

    func testResponse_whenHasHttpResponseWithValidData_returnsApiResponse() {
        var apiError: ApiError?
        var apiResponse: ApiResponse?
        let request: ProductsRequest = ProductsRequest()
        let response: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 200)

        let expectation = self.expectation(description: "")
        request.response(from: response)
            .subscribe(onNext: { response in
                apiResponse = response
                expectation.fulfill()
            }, onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertNil(apiError)
        XCTAssertEqual(apiResponse?.resource is ProductsResource, true)
    }

}
