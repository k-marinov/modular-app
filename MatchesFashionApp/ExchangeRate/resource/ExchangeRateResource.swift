import SwiftyJSON

struct ExchangeRateResource: Resource {

    private let rate: Double

    init(json: JSON) {
        rate = 0.0
    }

}
