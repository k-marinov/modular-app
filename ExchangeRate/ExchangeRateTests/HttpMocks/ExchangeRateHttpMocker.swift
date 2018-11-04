import OHHTTPStubs
import TestHelpers

class ExchangeRateHttpMocker {

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
        if ExchangeRateHttpMocker.scenario == Scenario.success {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("exchange-rate.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"])
        } else if ExchangeRateHttpMocker.scenario == Scenario.fail {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("empty.json", type(of: self))!,
                statusCode: 400,
                headers: ["Content-Type": "application/json"])
        }
        return OHHTTPStubsResponse(
            fileAtPath: OHPathForFile("empty.json", type(of: self))!,
            statusCode: 500,
            headers: ["Content-Type": "application/json"])
    }

    private func validateScenario() {
        if ExchangeRateHttpMocker.scenario == nil {
            fatalError("ExchangeRateHttpMocker.scenario can not be nil")
        }
    }

    private func isUrlRequestSuccess(with urlRequest: URLRequest) -> Bool {
        let url: String = urlRequest.url!.absoluteURL.absoluteString
        return url.hasPrefix("https://free.currencyconverterapi.com/api/v6/convert?q=USD_GBP")
    }

}
