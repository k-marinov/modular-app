import RxSwift
import Commons

open class ProductService: Service {

    private let apiClient: ApiClient

    public required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

    open func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return apiClient.request(with: request)
            .map { ($0.resource as! ProductsResource).products }
    }

}
