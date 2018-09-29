@testable import MatchesFashionApp

class MockCreator: Creatable {

    private let serviceMocks: [String: Service.Type] = [
        "\(ProductService.self)": MockProductService.self,
        "\(ExchangeRateService.self)": MockExchangeRateService.self]

    private var mocks: [String: Any] = [String: Any]()

    func addMock(key: String, value: Any) {
        if mocks[key] == nil {
            mocks[key] = value
        }
    }

    func find<Mock>(_ type: Mock.Type) -> Mock {
        return mocks["\(type.self)"] as! Mock
    }

    func create<S: Service>(with creatable: Creatable) -> S {
        let realClassKey: String = "\(S.self)"
        let mockType: Service.Type = mockServiceType(with: creatable, realClassKey: realClassKey)

        addMock(key: "\(mockType)", value: mockType.init(creatable: creatable))
        return mocks["\(mockType)"] as! S
    }

    private func mockServiceType(with creatable: Creatable, realClassKey: String) -> Service.Type {
        let mockServiceType: Service.Type? = serviceMocks[realClassKey]
        if mockServiceType == nil {
            fatalError("Service class \(realClassKey) is not mapped to mock service class"
                + "please add your mock class type to serviceMocks")
        }
        print("mock service type \(mockServiceType!) found")
        return mockServiceType!
    }

}
