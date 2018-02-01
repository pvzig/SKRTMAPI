import Foundation
import Sockets
import HTTP
import WebSockets

public class VaporEngineRTM: RTMWebSocket {
    public var delegate: RTMDelegate?

    public required init(){}

    private var websocket: WebSocket?

    public func connect(url: URL) {

        let headers: [HeaderKey: String] = ["Authorized": "Bearer exampleBearer"]
        do {
            let scheme = url.scheme!
            let hostname = url.host!
            let port = Port(url.port!)
            let socket = try TCPInternetSocket(scheme: scheme, hostname: hostname, port: port)
            let uri = "\(scheme):\(hostname)"
            try WebSocket.background(to: uri, using: socket, headers: headers) { (websocket: WebSocket) throws -> Void in

                self.websocket = websocket

                self.delegate?.didConnect()

                websocket.onText = { ws, text in
                    self.delegate?.receivedMessage(text)
                }

                websocket.onClose = { ws in
                    self.delegate?.disconnected()
                }
            }
        } catch {
            print("Error connecting to \(url): \(error)")
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
        try self.websocket?.send(message)
    }
}
