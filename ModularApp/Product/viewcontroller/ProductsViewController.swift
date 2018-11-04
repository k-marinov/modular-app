import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController, ModelableViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private(set) weak var segmentedControl: UISegmentedControl!

    private(set) lazy var productsViewModel: ProductsViewModel = {
        guard let model = self.viewModel as? ProductsViewModel else {
            fatalError("productViewModel property can not be nil or different type than ProductsViewModel")
        }
        return model
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
        bind()
        productsViewModel.loadProducts()
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func setUp() {
        setUpCollectionView()
        setUpNavigationBarTitle()
    }

    private func bind() {
        segmentedControl.rx.selectedSegmentIndex
            .skip(1)
            .bind(onNext: productsViewModel.updateExchangeRate)
            .disposed(by: disposeBag)
    }

    private func subscribe() {
        productsViewModel.reloadData()
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)

        productsViewModel.isLoading()
            .drive(activityIndicatorView.rx.isLoading)
            .disposed(by: disposeBag)


        productsViewModel.currencies()
            .subscribe(onNext: { [weak self] currencies in
                currencies.forEach {
                    self?.segmentedControl.setTitle($0.code, forSegmentAt: $0.rawValue)
                }
            }).disposed(by: disposeBag)
    }

    private func setUpCollectionView() {
        collectionView.registerCellNib(with: ProductCell.identifier)
        setUpCollectionViewDataSource()
        setUpCollectionViewLayout()
    }

    private func setUpCollectionViewDataSource() {
        collectionView.dataSource = productsViewModel.dataSource
    }

    private func setUpCollectionViewLayout() {
        collectionView.collectionViewLayout = collectionViewFlowLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        collectionView.layoutIfNeeded()
        let numberOfColumns: CGFloat = 2.0
        let length: CGFloat = collectionView.frame.size.width / numberOfColumns
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: length, height: length + (length * 0.5))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }

    private func setUpNavigationBarTitle() {
        navigationItem.title = "Products"
    }

}
