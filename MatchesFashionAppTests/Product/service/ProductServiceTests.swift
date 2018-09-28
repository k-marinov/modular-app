import XCTest
import RxSwift

@testable import MatchesFashionApp

class ProductServiceTests: XCTestCase {

    private let productsMocker: ProductsHttpMocker = ProductsHttpMocker()
    private let service: ProductService = ProductService(creatable: Creator())
    private let disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        productsMocker.setUpStubs()
    }

    override func tearDown() {
        productsMocker.removeStubs()
        super.tearDown()
    }

    func testFindAllProducts_whenStatusCode200_returnsProducts() {
        ProductsHttpMocker.scenario = ProductsHttpMocker.Scenario.success
        var products: [ProductResource] = [ProductResource]()

        let expectation = self.expectation(description: "")
        service.findAllProducts(with: ProductsRequest())
            .subscribe(onNext: { newProducts in
                products.append(contentsOf: newProducts)
                expectation.fulfill()
            }, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(products.count, 3)
    }

    func testFindAllProducts_whenStatusCode401_returnsApiErrorClient() {
        ProductsHttpMocker.scenario = ProductsHttpMocker.Scenario.fail
        var apiError: ApiError?

        let expectation = self.expectation(description: "")
        service.findAllProducts(with: ProductsRequest())
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.client)
    }

}
