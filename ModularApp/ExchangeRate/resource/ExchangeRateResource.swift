import SwiftyJSON
import Commons

struct ExchangeRateResource: Resource {

    let value: Double

    init(json: JSON) {
        value = json["results"]
            .dictionary?
            .first?.value["val"]
            .double ?? 1.0
    }

}
