import UIKit

class ProductsViewController: UIViewController, ModelableViewController {

    private(set) lazy var productViewModel: ProductsViewModel = {
        guard let model = self.viewModel as? ProductsViewModel else {
            fatalError("productViewModel property can not be nil or different type than ProductsViewModel")
        }
        return model
    }()
    var viewModel: ViewModel!

}
