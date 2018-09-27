import Quick
import Nimble

@testable import MatchesFashionApp

class ProductsResourceSpec: QuickSpec {

    override func spec() {

        describe("ProductsResource") {
            describe("initalizer") {
                var resource: ProductsResource?

                context("when has valid json") {
                    beforeEach {
                        resource = ProductMother.productsResource()
                    }

                    it("return count") {
                        expect(resource?.products.count).to(equal(3))
                    }
                }

                context("when has empty json") {
                    beforeEach {
                        resource = ProductMother.emptyProductsResource()
                    }

                    it("return empty") {
                        expect(resource?.products).to(beEmpty())
                    }
                }
            }
        }
    }

}
