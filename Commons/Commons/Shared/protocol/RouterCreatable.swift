import UIKit

public protocol RouterCreatable {

    func create<R: Router>(creatable: Creatable) -> R

}

extension RouterCreatable {

    public func create<R: Router>(creatable: Creatable) -> R {
        return R(creatable: creatable)
    }

}
