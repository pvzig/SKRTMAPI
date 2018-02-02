import WebSockets
import HTTP
import Sockets
import TLS
import URI

public typealias WebSocket = WebSockets.WebSocket

public final class WebSocketFactory {
    public static let shared = WebSocketFactory()

    public init() {}

    public func connect(
        to uri: URI,
        protocols: [String]? = nil,
        headers: [HeaderKey: String]? = nil,
        onConnect: @escaping (WebSocket) throws -> Void
        ) throws {

        if uri.scheme.isSecure {
            let tcp = try TCPInternetSocket(
                scheme: "https",
                hostname: uri.hostname,
                port: uri.port ?? 443
            )
            let stream = try TLS.InternetSocket(tcp, TLS.Context(.client))
            try WebSocket.connect(
                to: uri,
                using: stream,
                protocols: protocols,
                headers: headers,
                onConnect: onConnect
            )
        } else {
            let stream = try TCPInternetSocket(
                scheme: "http",
                hostname: uri.hostname,
                port: uri.port ?? 80
            )
            try WebSocket.connect(
                to: uri,
                using: stream,
                protocols: protocols,
                headers: headers,
                onConnect: onConnect
            )
        }
    }

    public func connect(
        to uri: String,
        protocols: [String]? = nil,
        headers: [HeaderKey: String]? = nil,
        onConnect: @escaping (WebSocket) throws -> Void
        ) throws {
        let uri = try URI(uri)
        try connect(
            to: uri,
            protocols: protocols,
            headers: headers,
            onConnect: onConnect
        )
    }
}
