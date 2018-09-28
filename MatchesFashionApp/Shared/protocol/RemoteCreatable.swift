protocol RemoteCreatable {

    func create<R: Remote>(creatable: Creatable) -> R

}

extension RemoteCreatable {

    func create<R: Remote>(creatable: Creatable) -> R {
        return R(creatable: creatable)
    }

}
