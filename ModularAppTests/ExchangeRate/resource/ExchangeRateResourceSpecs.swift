import Quick
import Nimble

@testable import ModularApp

class ExchangeRateResourceSpec: QuickSpec {

    override func spec() {
        describe("ProductResource") {

            describe("initalizer") {
                var resource: ExchangeRateResource?

                fcontext("when has valid json") {
                    beforeEach {
                        resource = ExchangeRateMother.usdToGbpExchangeRate()
                    }

                    it("return mapped values") {
                        expect(resource?.value).to(beCloseTo(0.76746, within: 0.000001))
                    }
                }

                context("when has empty json") {
                    beforeEach {
                        resource = ExchangeRateMother.emptyExchangeRate()
                    }

                    it("return default property values") {
                        expect(resource?.value).to(equal(1))
                    }
                }
            }
        }
    }

}

