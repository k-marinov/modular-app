import XCTest
import RxSwift

@testable import MatchesFashionApp

class ProductsViewModelTests: XCTestCase {

    let disposeBag: DisposeBag = DisposeBag()
    var creator: MockCreator!
    var viewModel: ProductsViewModel!
    var isLoading: RxCollector<Bool>!
    var reloadData: RxCollector<Void>!
    var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        creator = MockCreator()
        viewModel = ProductsViewModel(creatable: creator)
        isLoading = RxCollector<Bool>().collect(from: viewModel.isLoading().asObservable())
        reloadData = RxCollector<Void>().collect(from: viewModel.reloadData().asObservable())
    }

    func testLoadProducts_whenSuccess_updatesUi() {
        creator.find(MockProductService.self).isRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertFalse(isLoading.results.isEmpty)
        XCTAssertEqual(isLoading.results, [true, false])
        XCTAssertEqual(reloadData.results.count, 1)
    }

    func testLoadProducts_whenSuccess_loadsDataSource() {
        creator.find(MockProductService.self).isRequestSuccess = true
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewModel.dataSource.count(), 3)
    }

    func testLoadProducts_whenFails_updatesUi() {
        creator.find(MockProductService.self).isRequestSuccess = false
        resetCollectors()

        let expectation = self.expectation(description: "")
        viewModel.loadProducts()
            .subscribe(onError: { error in
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(viewModel.dataSource.count(), 0)
        XCTAssertEqual(isLoading.results, [true, false])
        XCTAssertEqual(reloadData.results.count, 0)
    }

    private func resetCollectors() {
        isLoading.removeAll()
        reloadData.removeAll()
    }

}
