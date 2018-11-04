import RxSwift
import Commons

@testable import ModularApp

class MockProductService: ProductService {

    var isRequestSuccess: Bool = false

    override func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        if isRequestSuccess {
            return Observable.just(ProductMother.productsResource().products)
        }
        return Observable.error(ApiError.client)
    }

}
