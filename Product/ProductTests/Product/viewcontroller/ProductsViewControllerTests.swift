import XCTest
import RxSwift
import Nimble
import Commons
import ExchangeRate
import TestHelpers

@testable import Product

class ProductsViewControllerTests: XCTestCase, ViewControllerCreatable {

    private let disposeBag: DisposeBag = DisposeBag()
    private var creator: MockCreator!
    private var viewModel: ProductsViewModel!
    private var viewController: ProductsViewController!

    override func setUp() {
        super.setUp()
        viewController = productsViewController()
    }

    func testViewDidLoad_whenLoaded_loadsProducts() {
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

    func testViewDidLoad_whenLoaded_setsUpCollectionView() {
        _ = viewController.view
        expect(self.viewController.collectionView.dataSource).to(beIdenticalTo(viewModel.dataSource))
    }

    func testViewDidLoad_whenViewDidLoaded_setsUpSegmentedControl() {
        _ = viewController.view
        let numberOfSegments: Int = viewController.segmentedControl.numberOfSegments

        XCTAssertEqual(viewController.segmentedControl.selectedSegmentIndex, 0)
        XCTAssertEqual(numberOfSegments, Currency.allCases.count)
        for index in 0..<numberOfSegments {
            let title: String? = viewController.segmentedControl.titleForSegment(at: index)
            XCTAssertEqual(title, Currency.allCases[index].code)
        }
    }

    func testViewDidLoad_whenLoaded_skipsFirstSegmentedControlEvent() {
        _ = viewController.view
        XCTAssertEqual(creator.find(MockExchangeRateService.self).isFindExchangeRateCalled, false)
    }

    private func productsViewController() -> ProductsViewController {
        creator = MockCreator(mockServices: ProductTestConstants.serviceMocks)
        viewModel = ProductsViewModel(creatable: creator)
        return viewController(
            with: viewModel,
            viewControllerType: ProductsViewController.self)
            as! ProductsViewController
    }

}
