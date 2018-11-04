import Commons

public class MockCreator: Creatable {

    public required init(mockServices: [String: Service.Type]) {
        mocks = mockServices
    }

    private var mocks: [String: Any] = [String: Any]()

    public func addMock(key: String, value: Any) {
        if mocks[key] == nil {
            mocks[key] = value
        }
    }
    
    public func find<Mock>(_ type: Mock.Type) -> Mock {
        return mocks["\(type.self)"] as! Mock
    }

    public func create<SERVICE>(creatable: Creatable) -> SERVICE {
        let realClassKey: String = "\(SERVICE.self)"
        let mockType = mockServiceType(with: realClassKey)
        addMock(key: "\(mockType)", value: mockType.init(creatable: creatable))
        return mocks["\(mockType)"] as! SERVICE
    }

    private func mockServiceType(with realClassKey: String) -> Service.Type {
        let mockServiceType: Service.Type? = mocks[realClassKey] as? Service.Type
        if mockServiceType == nil {
            fatalError("Service class \(realClassKey) is not mapped to mock service class"
                + " please add your mock class type to serviceMocks")
        }
        return mockServiceType!
    }

}
