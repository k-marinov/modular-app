public protocol UtilityCreatable {

    func create(creatable: Creatable) -> ApiClient

    func create() -> HttpClient

}

extension UtilityCreatable {

    public func create(creatable: Creatable) -> ApiClient {
        return ApiClient(creatable: creatable)
    }

    public func create() -> HttpClient {
        return HttpClient()
    }

}
