import Foundation

public struct OpenAIAPIError: Decodable, Error {
    public let code: String?
    public let message: String
    public let param: String?
    public let type: String

    private enum CodingKeys: String, CodingKey {
        case error
    }

    private enum ErrorKeys: String, CodingKey {
        case code, message, param, type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let errorContainer = try container.nestedContainer(keyedBy: ErrorKeys.self, forKey: .error)

        code = try errorContainer.decodeIfPresent(String.self, forKey: .code)
        message = try errorContainer.decode(String.self, forKey: .message)
        param = try errorContainer.decodeIfPresent(String.self, forKey: .param)
        type = try errorContainer.decode(String.self, forKey: .type)
    }
}
