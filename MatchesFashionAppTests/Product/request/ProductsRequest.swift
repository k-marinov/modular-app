import XCTest

@testable import MatchesFashionApp

class ProductsRequestTests: XCTestCase {

    func testHttpRequestUrl_whenHasValue_returnsUrl() {
        let expectedUrl: URL? = URL(string: "http://matchesfashion.com/womens/shop?format=json")
        XCTAssertEqual(try! ProductsRequest().url, expectedUrl)
    }

    func testHttpMethod_whenHasValue_returnsHttpMethodGet() {
        XCTAssertEqual(try! ProductsRequest().httpMethod, HttpMethod.get)
    }

    func testResource_whenHasValidData_returnsMarvelCharactersResource() {
        let httpResponse: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.resource is ProductsResource, true)
    }

    func testResource_whenHasEmptyData_returnsNil() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductsRequest().response(from: httpResponse)

        XCTAssertNil(response.resource)
    }

    func testIsSuccess_whenHttpResponseCodeIsEqualToSuccessCode_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = try! ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), true)
    }

    func testIsSuccess_whenHasStatusCode401_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 401)
        let response: ApiResponse = try! ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), false)
    }

}
