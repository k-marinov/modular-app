import SwiftyJSON
import Commons

public struct ExchangeRateResource: Resource {

    public let value: Double

    public init(json: JSON) {
        value = json["results"]
            .dictionary?
            .first?.value["val"]
            .double ?? 1.0
    }

}
