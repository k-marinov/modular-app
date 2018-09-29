import XCTest

@testable import MatchesFashionApp

class ExchangeRateRequestTests: XCTestCase {

    func testHttpRequestUrl_whenHasValue_returnsUrl() {
        let expectedUrl: URL? = URL(string: "https://free.currencyconverterapi.com/api/v6/convert?q=GBP_USD")
        XCTAssertEqual(ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd).url(), expectedUrl)
    }

    func testHttpMethod_whenHasValue_returnsHttpMethodGet() {
        XCTAssertEqual(ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd).httpMethod, HttpMethod.get)
    }

    func testResource_whenHasValidData_returnsExchangeRateResource() {
        let httpResponse: HttpResponse = HttpResponseMother.httpResponse(withStatusCode: 200)
        let response: ApiResponse = ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd)
            .response(from: httpResponse)

        XCTAssertEqual(response.resource is ExchangeRateResource, true)
    }

    func testResource_whenHasEmptyData_returnsNil() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd)
            .response(from: httpResponse)

        XCTAssertNil(response.resource)
    }

    func testIsSuccess_whenHttpResponseCodeIsEqualToSuccessCode_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 200)
        let response: ApiResponse = ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd)
            .response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), true)
    }

    func testIsSuccess_whenHasStatusCode401_returnsTrue() {
        let httpResponse: HttpResponse = HttpResponseMother.emptyHttpResponse(withStatusCode: 401)
        let response: ApiResponse = ExchangeRateRequest(from: CurrencyCode.gbp, to: CurrencyCode.usd)
            .response(from: httpResponse)

        XCTAssertEqual(response.isSuccess(), false)
    }

}
