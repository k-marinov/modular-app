import Foundation

public struct HttpResponse {

    public private(set) var response: HTTPURLResponse?
    public private(set) var data: Data?
    public private(set) var error: Error?

    public init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }

    public func statusCode() -> HttpStatusCode {
        return HttpStatusCode.findOrReturnUndefined(statusCode: response?.statusCode)
    }

}
