import XCTest
import RxSwift

@testable import ModularApp

class ExchangeRateServiceTests: XCTestCase {

    private let mocker: ExchangeRateHttpMocker = ExchangeRateHttpMocker()
    private let service: ExchangeRateService = ExchangeRateService(creatable: Creator())
    private let request: ExchangeRateRequest = ExchangeRateRequest(from: Currency.usd, to: Currency.gbp)
    private let disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        mocker.setUpStubs()
    }

    override func tearDown() {
        mocker.removeStubs()
        super.tearDown()
    }

    func testFindExchangeRate_whenStatusCode200_returnsRate() {
        ExchangeRateHttpMocker.scenario = Scenario.success
        var rate: CurrencyExchangeRate?

        let expectation = self.expectation(description: "")
        service.findCurrencyExchangeRate(with: request)
            .subscribe(onNext: { newRate in
                rate = newRate
                expectation.fulfill()
            }, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(rate?.rate, 1.302999)
         XCTAssertEqual(rate?.currency, Currency.gbp)
    }

    func testFindExchangeRate_whenStatusCode400_returnsApiErrorClient() {
        ExchangeRateHttpMocker.scenario = Scenario.fail
        var apiError: ApiError?

        let expectation = self.expectation(description: "")
        service.findCurrencyExchangeRate(with: request)
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
