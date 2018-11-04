import RxSwift

enum Currency: Int, CaseIterable {

    case gbp

    case usd

    case eur

    case jpy

    var code: String {
        switch (self.rawValue) {
        case 0:
            return "GBP"
        case 1:
            return "USD"
        case 2:
            return "EUR"
        case 3:
            return "JPY"
        default:
            return ""
        }
    }

    var symbol: String {
        switch (self.rawValue) {
        case 0:
            return "£"
        case 1:
            return "$"
        case 2:
            return "€"
        case 3:
            return "¥"
        default:
            return ""
        }
    }

    static func findOrReturnFallback(code: String?) -> Currency {
        return Currency.allCases
            .filter { $0.code == code }
            .first ?? Currency.gbp
    }

    static func find(index: Int) -> Observable<Currency> {
        if index > -1 && index < Currency.allCases.count {
            return Observable.just(Currency.allCases[index])
        }
        return Observable.empty()
    }

}
