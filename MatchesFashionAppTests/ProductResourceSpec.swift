import Quick
import Nimble

@testable import MatchesFashionApp

class ProductResourceSpec: QuickSpec {

    override func spec() {
        describe("ProductResource") {
            describe("initalizer") {
                var product: ProductResource?

                context("when has valid json") {
                    beforeEach {
                        product = ProductMother.product()
                    }
                    it("return mapped values") {
                        expect(product?.name).to(equal("Floral-print silk-twill maxi dress "))
                    }
                }

                context("when has empty json") {
                    it("return empty values") {

                    }
                }
            }
        }
    }
}
