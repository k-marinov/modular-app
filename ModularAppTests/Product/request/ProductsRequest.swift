import XCTest
import Commons

@testable import ModularApp

class ProductsRequestTests: XCTestCase {

    func testHttpRequestUrl_whenHasValue_returnsUrl() {
        let expectedUrl: URL? = URL(string: "https://www.matchesfashion.com/womens/shop?format=json")

        XCTAssertEqual(ProductsRequest().url(), expectedUrl)
    }

    func testHttpMethod_whenHasValue_returnsHttpMethodGet() {
        XCTAssertEqual(ProductsRequest().httpMethod, HttpMethod.get)
    }

    func testResource_whenHasValidData_returnsProductsResource() {
        let httpResponse: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 200)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.resource is ProductsResource, true)
    }

    func testResource_whenHasEmptyData_returnsNil() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertNil(response.resource)
    }

    func testIsSuccess_whenHttpResponseCodeIsEqualToSuccessCode_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), true)
    }

    func testIsSuccess_whenHasStatusCode401_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 401)
        let response: ApiResponse = ProductsRequest().response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), false)
    }

}
