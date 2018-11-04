import RxSwift
import Commons
import ExchangeRate

@testable import Product

open class MockExchangeRateService: ExchangeRateService {

    var isRequestSuccess: Bool = false
    var isFindExchangeRateCalled: Bool = false

    override open func findCurrencyExchangeRate(with request: ExchangeRateRequest) -> Observable<CurrencyExchangeRate> {
        isFindExchangeRateCalled = true
        if isRequestSuccess {
            return Observable.just(CurrencyExchangeRate(rate: 1.5, currency: Currency.usd))
        }
        return Observable.error(ApiError.client)
    }

}
