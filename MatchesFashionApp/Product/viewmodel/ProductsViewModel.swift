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

    private func updateExchangeRate(index: Int) -> Observable<Void> {
        return Currency.find(index: index)
            .flatMap { [weak self] toCurrency -> Observable<Void> in
                guard let `self` = self else { return Observable.empty() }
                let request = ExchangeRateRequest(from: Currency.gbp, to: toCurrency)

                return self.exchangeRateService.findCurrencyExchangeRate(with: request)
                    .map { [weak self] newRate in
                        self?.reloadTableView(newRate: newRate)
                    }.do(onError: { [weak self] error in
                        self?.onLoadProgressEnded()
                        }, onCompleted: { [weak self] in
                            self?.onLoadProgressEnded()
                        }, onSubscribe: { [weak self] in
                            self?.onLoadProgressStarted()
                    }).map { _ in return () }
        }
    }

    func loadProducts() -> Observable<Void> {
        return self.productService.findAllProducts(with: ProductsRequest())
            .do(onNext: { [weak self] newProducts in
                self?.dataSource.appendOnce(contentsOf: newProducts)
                }, onError: { [weak self] error in
                    self?.onLoadProgressEnded()
                }, onCompleted: {  [weak self] in
                    self?.onLoadProductsCompleted()
                }, onSubscribe: { [weak self] in
                    self?.onLoadProgressStarted()
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

    private func onLoadProductsCompleted() {
        onLoadProgressEnded()
        reload.onNext(())
    }

    private func onLoadProgressStarted() {
        loadProgress.onNext(true)
    }

    private func onLoadProgressEnded() {
        loadProgress.onNext(false)
    }

}
