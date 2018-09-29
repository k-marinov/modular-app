import RxSwift

class ExchangeRateService: Service {

    private let apiClient: ApiClient

    required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

    func findExchangeRate(with request: ExchangeRateRequest) -> Observable<Double> {
        return apiClient.request(with: request)
            .map { ($0.resource as! ExchangeRateResource).value }
    }

}
