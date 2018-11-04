import Commons
import ExchangeRate

@testable import Product

class ProductTestConstants {

    static let serviceMocks: [String: Service.Type] = [
        "\(ProductService.self)": MockProductService.self,
        "\(ExchangeRateService.self)": MockExchangeRateService.self]

}
