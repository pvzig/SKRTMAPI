//
//  ZewoRTM.swift
//
// Copyright © 2017 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#if os(Linux)
import Dispatch
import Foundation
import SKCore
import WebSocketClient

public class ZewoRTM: RTMWebSocket {
    
    public var delegate: RTMDelegate?
    var webSocket: WebSocket?
    let queue = DispatchQueue(label: "com.launchsoft.slackkit")
    
    public required init() {}
    
    //MARK: - RTM
    public func connect(url: URL) {
        queue.async {
            do {
                try WebSocketClient(url: url, didConnect: { (webSocket) in
                    self.delegate?.didConnect()
                    self.setupSocket(webSocket)
                }).connect()
            } catch let error {
                print("WebSocket client could not connect: \(error)")
            }
        }
    }
    
    public func disconnect() {
        try? webSocket?.close()
    }
    
    public func sendMessage(_ message: String) throws {
        guard webSocket != nil else {
            throw SlackError.rtmConnectionError
        }
        do {
            try webSocket?.send(message)
        } catch let error {
            throw error
        }
    }
    
    // MARK: - WebSocket
    private func setupSocket(_ webSocket: WebSocket) {
        webSocket.onText { (message) in
            self.delegate?.receivedMessage(message)
        }
        webSocket.onClose { (code: CloseCode?, reason: String?) in
            self.delegate?.disconnected()
        }
        webSocket.onPing { (data) in try webSocket.pong() }
        webSocket.onPong { (data) in try webSocket.ping() }
        self.webSocket = webSocket
    }
}
#endif
