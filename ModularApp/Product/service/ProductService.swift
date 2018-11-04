import RxSwift

class ProductService: Service {

    private let apiClient: ApiClient

    required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

    func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return apiClient.request(with: request)
            .map { ($0.resource as! ProductsResource).products }
    }

}
