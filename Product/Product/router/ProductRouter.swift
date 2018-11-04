import UIKit
import Commons

public struct ProductRouter: Router, ViewControllerCreatable {

    private let productsViewModel: ProductsViewModel

    public init(creatable: Creatable) {
        productsViewModel = ProductsViewModel(creatable: creatable)
    }


    public func viewController() -> ProductsViewController {
        return viewController(
            with: productsViewModel,
            viewControllerType: ProductsViewController.self) as! ProductsViewController
    }

}
