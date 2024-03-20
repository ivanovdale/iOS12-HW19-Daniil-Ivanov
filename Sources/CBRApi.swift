import Foundation

public final class CBRApi {
    private enum Constants {
        static let host = "www.cbr.ru"
        static let fakeHost = "www.cb.ru"
    }

    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    private enum Endpoint {
        case currencyExchangeList(dateString: String)
        case fakeResource
        case hostNotFound
        case currencyExchangeListWithBadParameter

        var urlRequest: String {
            switch self {
            case .currencyExchangeList(let dateString):
                let queryParameters = "?date_req=\(dateString)"
                return "https://" + Constants.host + "/scripts/XML_daily.asp" + queryParameters
            case .fakeResource:
                return "https://" + Constants.host + "/sc/XML_daily.asp"
            case .hostNotFound:
                return "https://" + Constants.fakeHost + "/sc/XML_daily.asp"
            case .currencyExchangeListWithBadParameter:
                let queryParameters = "?date_req=01/01/1970"
                return "https://" + Constants.host + "/scripts/XML_daily.asp" + queryParameters
            }
        }
    }

    public func getCurrencyExchangeList(dateString: String) {
        client.getData(urlRequest: Endpoint.currencyExchangeList(dateString: dateString).urlRequest, encoding: .windowsCP1251)
    }

    public func getFakeResource() {
        client.getData(urlRequest: Endpoint.fakeResource.urlRequest, encoding: .windowsCP1251)
    }

    public func getHostNotFound() {
        client.getData(urlRequest: Endpoint.hostNotFound.urlRequest, encoding: .windowsCP1251)
    }

    public func getCurrencyExchangeListWithBadParameter() {
        client.getData(urlRequest: Endpoint.currencyExchangeListWithBadParameter.urlRequest, encoding: .windowsCP1251)
    }

}
