import RxSwift

class ExchangeRateService: Service {

    private let apiClient: ApiClient

    required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

    func findCurrencyExchangeRate(with request: ExchangeRateRequest) -> Observable<CurrencyExchangeRate> {
        return apiClient.request(with: request)
            .map { CurrencyExchangeRate(rate: ($0.resource as! ExchangeRateResource).value, currency: request.toCurrency) }
    }

}
