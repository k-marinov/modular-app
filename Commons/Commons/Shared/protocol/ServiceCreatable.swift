public protocol ServiceCreatable {

    func create<S: Service>(creatable: Creatable) -> S

}

extension ServiceCreatable {

    public func create<S: Service>(creatable: Creatable) -> S {
        return S(creatable: creatable)
    }

}
