import RxSwift

@testable import MatchesFashionApp

class MockExchangeRateService: ExchangeRateService {

    var isRequestSuccess: Bool = false
    var isFindExchangeRateCalled: Bool = false

    override func findCurrencyExchangeRate(with request: ExchangeRateRequest) -> Observable<CurrencyExchangeRate> {
        isFindExchangeRateCalled = true
        if isRequestSuccess {
            return Observable.just(CurrencyExchangeRate(rate: 1.5, currency: Currency.gbp))
        }
        return Observable.error(ApiError.client)
    }

}
