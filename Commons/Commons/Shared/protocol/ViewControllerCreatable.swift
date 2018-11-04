import UIKit

public protocol ViewControllerCreatable {

    func viewController<VC: UIViewController> (with viewModel: ViewModel, viewControllerType: VC.Type) -> UIViewController

}

extension ViewControllerCreatable {

    public func viewController<VC: UIViewController>(with viewModel: ViewModel, viewControllerType: VC.Type) -> UIViewController {
        var controller = viewController(with: viewControllerType) as? ModelableViewController
        if controller == nil {
            fatalError("viewControllerType=\(viewControllerType) does not inherit ModelableViewController protocol")
        }
        controller!.viewModel = viewModel
        return controller as! VC
    }

    private func viewController<VC: UIViewController>(with type: VC.Type) -> UIViewController {
        let split = "\(type)".split(separator: ".").last ?? ""

        let name: String = String(describing: split)
        let storyboardBundle = Bundle(for: type)

        let storyboard: UIStoryboard = UIStoryboard(name: name, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: name) as! VC
    }

}
