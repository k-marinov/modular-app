protocol UtilityCreatable {

    func create(creatable: Creatable) -> ApiClient

    func create() -> HttpClient

}

extension UtilityCreatable {

    func create(creatable: Creatable) -> ApiClient {
        return ApiClient(creatable: creatable)
    }

    func create() -> HttpClient {
        return HttpClient()
    }

}
