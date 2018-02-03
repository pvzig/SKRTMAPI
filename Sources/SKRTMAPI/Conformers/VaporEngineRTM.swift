import Foundation
import Sockets
import HTTP
import TLS
import URI
import WebSockets

public class VaporEngineRTM: RTMWebSocket {
    public var delegate: RTMDelegate?

    public required init(){}

    private var websocket: WebSocket?

    public func connect(url: URL) {

        let headers: [HeaderKey: String] = ["Authorized": "Bearer exampleBearer"]
        let protocols: [String]? = nil
        do {
            let uri = try! URI(url.absoluteString)
            if uri.scheme.isSecure {
                let tcp = try TCPInternetSocket(
                    scheme: "https",
                    hostname: uri.hostname,
                    port: uri.port ?? 443
                )
                let stream = try TLS.InternetSocket(tcp, TLS.Context(.client))
                try WebSocket.background(
                    to: uri,
                    using: stream,
                    protocols: protocols,
                    headers: headers,
                    onConnect: didConnect
                )
            } else {
                let stream = try TCPInternetSocket(
                    scheme: "http",
                    hostname: uri.hostname,
                    port: uri.port ?? 80
                )
                try WebSocket.background(
                    to: uri,
                    using: stream,
                    protocols: protocols,
                    headers: headers,
                    onConnect: didConnect
                )
            }
        } catch {
            print("Error connecting to \(url.absoluteString): \(error)")
        }
    }

    func didConnect(websocket: WebSocket) throws -> Void {
        self.websocket = websocket

        self.delegate?.didConnect()

        websocket.onText = { ws, text in
            self.delegate?.receivedMessage(text)
        }

        websocket.onClose = { ws in
            self.delegate?.disconnected()
        }

        websocket.onPing = { ws, data in
            try ws.pong(data)
        }

        websocket.onPong = { ws, data in
            try ws.ping(data)
        }
    }

    public func disconnect() {
        do {
            try self.websocket?.close()
        } catch {
            print("Error disconnecting from \(self.websocket.debugDescription): \(error)")
        }
    }

    public func sendMessage(_ message: String) throws {
        guard let websocket = websocket else { throw SlackError.rtmConnectionError }
        try websocket.send(message)
    }
}
