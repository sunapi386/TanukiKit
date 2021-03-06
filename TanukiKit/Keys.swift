import Foundation
import RequestKit

// MARK: request

public extension TanukiKit {
    public func postPublicKey(session: RequestKitURLSession = NSURLSession.sharedSession(), publicKey: String, title: String, completion: (response:Response<String>) -> Void) {
        let router = PublicKeyRouter.PostPublicKey(publicKey, title, configuration)
        router.loadJSON(session, expectedResultType: [String: AnyObject].self) { json, error in
            if let error = error {
                completion(response: Response.Failure(error))
            } else {
                if let _ = json {
                    completion(response: Response.Success(publicKey))
                }
            }
        }
    }
}

enum PublicKeyRouter: Router {
    case PostPublicKey(String, String, Configuration)

    var configuration: Configuration {
        switch self {
        case .PostPublicKey(_, _, let config): return config
        }
    }

    var method: HTTPMethod {
        switch self {
        case .PostPublicKey:
            return .POST
        }
    }

    var encoding: HTTPEncoding {
        switch self {
        case .PostPublicKey:
            return .FORM
        }
    }

    var path: String {
        switch self {
        case .PostPublicKey:
            return "user/keys"
        }
    }

    var params: [String: AnyObject] {
        switch self {
        case .PostPublicKey(let publicKey, let title, _):
            return ["title": title, "key": publicKey]
        }
    }
}
