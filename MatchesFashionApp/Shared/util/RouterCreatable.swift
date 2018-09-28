protocol RouterCreatable {

    func create<R: Router>(creatable: Creatable) -> R

}

extension RouterCreatable {

    func create<R: Router>(creatable: Creatable) -> R {
        return R(creatable: creatable)
    }

}
