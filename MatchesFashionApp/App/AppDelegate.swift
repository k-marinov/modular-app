import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appRouter: AppRouter = AppRouter(creatable: Creator())
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if isProductionEnabled() {
            _ = appRouter.setUpRoot(to: window!)
        }
        return true
    }

    private func isProductionEnabled() -> Bool {
        return !ProcessInfo.processInfo.arguments.contains("TEST_MODE_ENABLED")
    }

}
