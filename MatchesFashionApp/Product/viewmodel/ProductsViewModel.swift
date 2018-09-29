import RxCocoa
import RxSwift

class ProductsViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()
    private let productService: ProductService
    private let exchangeRateService: ExchangeRateService

    private let loadProgress: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let reload: PublishSubject<Void> = PublishSubject<Void>()

    private(set) var dataSource: CollectionViewDataSource = CollectionViewDataSource<ProductResource, ProductCell>()

    required init(creatable: Creatable) {
        productService = creatable.create(creatable: creatable)
        exchangeRateService = creatable.create(creatable: creatable)
    }

    func loadProducts() -> Observable<Void> {
        return productService.findAllProducts(with: ProductsRequest())
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

    func isLoading() -> Driver<Bool> {
        return loadProgress.asDriver()
    }

    func reloadData() -> Driver<Void> {
        return reload.asDriver(onErrorJustReturn: ())
    }

    private func onLoadProductsStarted() {
        loadProgress.accept(true)
    }

    private func onLoadProductsCompleted() {
        loadProgress.accept(false)
        reload.onNext(())
    }

    private func onLoadProductsCompletedWithError() {
        loadProgress.accept(false)
    }

}
