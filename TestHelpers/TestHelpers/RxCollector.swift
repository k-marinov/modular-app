import RxSwift

public class RxCollector<T> {

    private var disposeBag: DisposeBag = DisposeBag()
    public private(set) var results: [T] = [T]()
    public private(set) var error: Error?

    public init() { 
    }

    public func collect(from observable: Observable<T>) -> RxCollector {
        observable.asObservable()
            .subscribe(onNext: { (new) in
                self.results.append(new)
            }).disposed(by: disposeBag)
        return self
    }

    public func removeAll() {
        results.removeAll()
    }

}
