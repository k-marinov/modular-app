import Quick
import Nimble

@testable import ModularApp

class ProductResourceSpec: QuickSpec {

    override func spec() {
        describe("ProductResource") {

            describe("initalizer") {
                var resource: ProductResource?
                context("when has valid json") {
                    var imageUrl: URL?

                    beforeEach {
                        resource = ProductMother.product()
                        imageUrl = URL(string: "https://assetsprx.matchesfashion.com/img/product/1232802_1_medium.jpg")
                    }

                    it("return mapped values") {
                        expect(resource?.name).to(equal("Floral-print silk-twill maxi dress "))
                        expect(resource?.designer).to(equal("Gucci"))
                        expect(resource?.priceFormatted()).to(equal("£3,550"))
                        expect(resource?.imageUrl).to(equal(imageUrl))
                    }
                }

                context("when has empty json") {
                    beforeEach {
                        resource = ProductMother.emptyProduct()
                    }

                    it("return default property values") {
                        expect(resource?.name).to(beEmpty())
                        expect(resource?.designer).to(beEmpty())
                        expect(resource?.priceFormatted()).to(equal("£0"))
                        expect(resource?.imageUrl).to(beNil())
                    }
                }
            }
        }
    }

}
