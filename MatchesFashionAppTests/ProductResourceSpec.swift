import Quick
import Nimble

@testable import MatchesFashionApp

class ProductResourceSpec: QuickSpec {

    override func spec() {
        describe("ProductResource") {
            describe("initalizer") {
                var product: ProductResource?
                var imageUrl: URL?

                context("when has valid json") {
                    beforeEach {
                        product = ProductMother.product()
                        imageUrl = URL(string: "https://assetsprx.matchesfashion.com/img/product/1232802_1_medium.jpg")
                    }

                    it("return mapped values") {
                        expect(product?.name).to(equal("Floral-print silk-twill maxi dress "))
                        expect(product?.designerName).to(equal("Gucci"))
                        expect(product?.priceFormatted()).to(equal("£3550.0"))
                        expect(product?.imageUrl).to(equal(imageUrl))
                    }
                }

                context("when has empty json") {
                    beforeEach {
                        product = ProductMother.emptyProduct()
                    }

                    it("return default property values") {
                        expect(product?.name).to(beEmpty())
                        expect(product?.designerName).to(beEmpty())
                        expect(product?.priceFormatted()).to(equal("£0.0"))
                        expect(product?.imageUrl).to(beNil())
                    }
                }
            }
        }
    }

}
