import UIKit

struct AppRouter: Router {

    private let productRouter: ProductRouter

    init(creatable: Creatable) {
        productRouter = creatable.create(creatable: creatable)
    }

    func setUpRoot(to window: UIWindow) -> UIWindow {
        window.rootViewController = navigationController(rootViewController: productRouter.viewController())
        window.makeKeyAndVisible()
        return window
    }

    private func navigationController(rootViewController: UIViewController) -> UINavigationController {
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        controller.navigationBar.tintColor = UIColor.gray
        return controller
    }

}
