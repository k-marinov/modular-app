import XCTest

@testable import ModularApp

class MatchesFashionAppRouterTests: XCTestCase {

    func testSetUpRoot_returnsProductsViewControllerAsRoot() {
        let router = AppRouter(creatable: Creator())
        let window = router.setUpRoot(to: UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 640)))
        let controller = (window.rootViewController as? UINavigationController)?.children[0]

        XCTAssertTrue(controller is ProductsViewController)
        XCTAssertTrue(window.rootViewController is UINavigationController)
    }

}
