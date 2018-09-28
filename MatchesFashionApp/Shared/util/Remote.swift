class Remote {

    private let apiClient: ApiClient

    required init(creatable: Creatable) {
        apiClient = creatable.create(creatable: creatable)
    }

}
