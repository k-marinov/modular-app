import UIKit

struct ProductRouter: Router, ViewControllerCreatable {

    private let productsViewModel: ProductsViewModel

    init(creatable: Creatable) {
        productsViewModel = ProductsViewModel(creatable: creatable)
    }

    func viewController() -> ProductsViewController {
        return viewController(with: productsViewModel, viewControllerType: ProductsViewController.self) as! ProductsViewController
    }

}
