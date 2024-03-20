import Foundation

public final class MarvelApi {
    private enum Constants {
        static let host = "gateway.marvel.com"
        static let publicApiKey = "4c43dd559df35e4102ed9be981186419"
        static let privateApiKey = "34910bd2da65fd23a364ce6cdcf370072560a28e"
    }

    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    private static var hashParam: String {
        let timestamp = Date().currentTimeInMillis()
        let tsParam = "ts=\(timestamp)"
        let hashValue = (String(timestamp) + Constants.privateApiKey + Constants.publicApiKey).md5Hash()
        let hashParam = "&hash=\(hashValue)"
        return tsParam + hashParam
    }

    private enum Endpoint {
        case characterComics(id: String)

        var urlRequest: String {
            switch self {
            case .characterComics(let id):
                let apiKeyParam = "apikey=\(Constants.publicApiKey)"
                let queryParameters = "?\(hashParam)&\(apiKeyParam)"
                return "https://" + Constants.host + "/v1/public/characters/\(id)/comics" + queryParameters
            }
        }
    }

    public func getComicsOfCharacter(id: String) {
        client.getData(urlRequest: Endpoint.characterComics(id: id).urlRequest)
    }
}
