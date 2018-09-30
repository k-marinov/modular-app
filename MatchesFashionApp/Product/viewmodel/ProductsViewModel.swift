import RxCocoa
import RxSwift

class ProductsViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()
    private let productService: ProductService
    private let exchangeRateService: ExchangeRateService
    private let loadProgress: PublishSubject<Bool> = PublishSubject<Bool>()
    private let reload: PublishSubject<Void> = PublishSubject<Void>()
    private(set) var dataSource = CollectionViewDataSource<ProductResource, ProductCell>()

    required init(creatable: Creatable) {
        productService = creatable.create(creatable: creatable)
        exchangeRateService = creatable.create(creatable: creatable)
    }

    func updateExchangeRate(index: Int) {
        updateExchangeRate(index: index)
            .subscribe()
            .disposed(by: disposeBag)
    }

    func updateExchangeRate(index: Int) -> Observable<CurrencyExchangeRate> {
        return Currency.find(index: index)
            .flatMap { [weak self] toCurrency -> Observable<CurrencyExchangeRate> in
                guard let `self` = self else { return Observable.empty() }
                let request = ExchangeRateRequest(from: Currency.gbp, to: toCurrency)
                return self.exchangeRateService.findCurrencyExchangeRate(with: request)
                    .map { [weak self] newRate in
                        self?.reloadTableView(newRate: newRate)
                        return newRate
                }
        }
    }

    private func reloadTableView(newRate: CurrencyExchangeRate) {
        updateAllProducts(newRate: newRate)
        reload.onNext(())
    }

    private func updateAllProducts(newRate: CurrencyExchangeRate) {
        let updated = dataSource.items
            .compactMap { ($0 as? ProductResource) }
            .map { product -> ProductResource in
                var updated: ProductResource = product
                return updated.setCurrencyExchangeRate(rate: newRate)
        }
        dataSource.appendOnce(contentsOf: updated)
    }

    func loadProducts() -> Observable<Void> {
        return self.productService.findAllProducts(with: ProductsRequest())
            .do(onNext: { [weak self] newProducts in
                self?.dataSource.appendOnce(contentsOf: newProducts)
                }, onError: { [weak self] error in
                    self?.onLoadProductsCompletedWithError()
                }, onCompleted: {  [weak self] in
                    self?.onLoadProductsCompleted()
                }, onSubscribe: { [weak self] in
                    self?.onLoadProductsStarted()
            }).map { _ in return () }
    }

    func currencies() -> Observable<[Currency]> {
        return Observable<[Currency]>.just(Currency.allCases)
    }

    func isLoading() -> Driver<Bool> {
        return loadProgress.asObservable()
            .asDriver(onErrorJustReturn: false)
    }

    func reloadData() -> Driver<Void> {
        return reload.asDriver(onErrorJustReturn: ())
    }

    private func onLoadProductsStarted() {
        loadProgress.onNext(true)
    }

    private func onLoadProductsCompleted() {
        loadProgress.onNext(false)
        reload.onNext(())
    }

    private func onLoadProductsCompletedWithError() {
        loadProgress.onNext(false)
    }

}
