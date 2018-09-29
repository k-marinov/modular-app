import XCTest
import RxSwift
import Nimble

@testable import MatchesFashionApp

class ProductsViewControllerTests: XCTestCase, ViewControllerCreatable {

    let disposeBag: DisposeBag = DisposeBag()
    var creator: MockCreator!
    var viewModel: ProductsViewModel!
    var viewController: ProductsViewController!

    override func setUp() {
        super.setUp()
        viewController = productsViewController()
    }

    func testViewDidLoad_whenViewControllerIsLoaded_loadsProducts() {
        creator.find(MockProductService.self).isRequestSuccess = true
        let expectation = self.expectation(description: "")
        viewController.productsViewModel
            .reloadData().drive(onNext: { _ in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        _ = viewController.view
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 3)
        XCTAssertEqual(viewController.activityIndicatorView.isAnimating, false)
    }

    func testViewDidLoad_whenViewControllerIsLoaded_setsUpCollectionView() {
        _ = viewController.view
        expect(self.viewController.collectionView.dataSource).to(beIdenticalTo(viewModel.dataSource))
    }

    private func productsViewController() -> ProductsViewController {
        creator = MockCreator()
        viewModel = ProductsViewModel(creatable: creator)
        return viewController(
            with: viewModel,
            viewControllerType: ProductsViewController.self)
            as! ProductsViewController
    }

}
