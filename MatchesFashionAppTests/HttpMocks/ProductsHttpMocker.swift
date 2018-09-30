import OHHTTPStubs

class ProductsHttpMocker {

    static var scenario: Scenario!

    func setUpStubs() {
        stubHttpResponse()
        OHHTTPStubs.setEnabled(true)
    }

    func removeStubs() {
        OHHTTPStubs.setEnabled(false)
        OHHTTPStubs.removeAllStubs()
    }

    private func stubHttpResponse() {
        stub(condition: { request -> Bool in
            return self.isUrlRequestSuccess(with: request)
        }, response: { _ -> OHHTTPStubsResponse in
            return self.response()
        })
    }

    private func response() -> OHHTTPStubsResponse {
        validateScenario()

        if ProductsHttpMocker.scenario == Scenario.success {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("products.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"])
        } else if ProductsHttpMocker.scenario == Scenario.fail {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("empty.json", type(of: self))!,
                statusCode: 404,
                headers: ["Content-Type": "application/json"])
        }
        return OHHTTPStubsResponse(
            fileAtPath: OHPathForFile("empty.json", type(of: self))!,
            statusCode: 500,
            headers: ["Content-Type": "application/json"])
    }

    private func validateScenario() {
        if ProductsHttpMocker.scenario == nil {
            fatalError("ProductsHttpMocker.scenario can not be nil")
        }
    }

    private func isUrlRequestSuccess(with urlRequest: URLRequest) -> Bool {
        let url: String = urlRequest.url!.absoluteURL.absoluteString
        return url.hasPrefix("https://www.matchesfashion.com/womens/shop?format=json")
    }

}
