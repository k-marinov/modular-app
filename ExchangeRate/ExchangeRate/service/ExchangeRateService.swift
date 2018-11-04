import RxSwift
import Commons

open class ExchangeRateService: Service {

    private let apiClient: ApiClient

    public required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

    open func findCurrencyExchangeRate(with request: ExchangeRateRequest) -> Observable<CurrencyExchangeRate> {
        return apiClient.request(with: request)
            .map { CurrencyExchangeRate(rate: ($0.resource as! ExchangeRateResource).value, currency: request.toCurrency) }
    }

}
