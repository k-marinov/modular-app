import UIKit

protocol ViewControllerCreatable {

    func viewController<VC: UIViewController> (with viewModel: ViewModel, viewControllerType: VC.Type) -> UIViewController

    func viewController<VC: UIViewController>(with type: VC.Type) -> UIViewController

}

extension ViewControllerCreatable {

    func viewController<VC: UIViewController>(with viewModel: ViewModel, viewControllerType: VC.Type) -> UIViewController {
        var controller = viewController(with: viewControllerType) as! ModelableViewController
        controller.viewModel = viewModel
        return controller as! VC
    }

    func viewController<VC: UIViewController>(with type: VC.Type) -> UIViewController {
        let name: String = String(describing: type)
        let storyboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name) as! VC
    }

}
