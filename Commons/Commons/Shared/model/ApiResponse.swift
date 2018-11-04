import SwiftyJSON

public struct ApiResponse {

    public private(set) var resource: Resource?
    public private(set) var httpStatusCode: HttpStatusCode!
    private var successHttpStatusCode: HttpStatusCode!

    public init<RESOURCE: Resource>(
        resourceType: RESOURCE.Type,
        httpResponse: HttpResponse,
        successHttpStatusCode: HttpStatusCode) {
        self.resource = createResource(resourceType: resourceType, data: httpResponse.data)
        self.httpStatusCode = httpResponse.statusCode()
        self.successHttpStatusCode = successHttpStatusCode
    }

    private func createResource<RESOURCE: Resource>(resourceType: RESOURCE.Type, data: Data?) -> Resource? {
        if hasData(withData: data) {
            return RESOURCE(json: JSON(data!))
        }
        return nil
    }

    private func hasData(withData data: Data?) -> Bool {
        if let data: Data = data, data.count > 0 {
            return true
        }
        return false
    }

    public func isSuccess() -> Bool {
        return successHttpStatusCode == httpStatusCode
    }

    public func apiFailError() -> ApiError {
        if hasClientError() {
            return ApiError.client
        } else if hasServerError() {
            return ApiError.server
        }
        return ApiError.unknown
    }

    private func hasClientError() -> Bool {
        return HttpStatusCode.clientErrorsGroup.contains(httpStatusCode.rawValue)
    }

    private func hasServerError() -> Bool {
        return HttpStatusCode.serverErrorsGroup.contains(httpStatusCode.rawValue)
    }

}
