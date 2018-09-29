import RxSwift

@testable import MatchesFashionApp

class MockExchangeRateService: ExchangeRateService {

    var isRequestSuccess: Bool = false

    override func findExchangeRate(with request: ExchangeRateRequest) -> Observable<Double> {
        if isRequestSuccess {
            return Observable.just(1.5)
        }
        return Observable.error(ApiError.client)
    }

}
