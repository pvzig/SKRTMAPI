//
//  VaporRTM.swift
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
import Foundation
import SKCore
import WebSockets

public class VaporRTM: RTMWebSocket {
    
    public var delegate: RTMDelegate?
    internal var webSocket: WebSocket?

    public required init() {}
    
    //MARK: - RTM
    public func connect(url: URL) {
        do {
            try WebSocket.connect(to: url.absoluteString) { ws in
                self.webSocket = ws
                self.delegate?.didConnect()

                ws.onText = { ws, text in
                    print(text)
                    self.delegate?.receivedMessage(text)
                }
                
                ws.onClose = { _, code, reason, clean in
                    self.delegate?.disconnected()
                }
            }
        } catch let error {
            print("Websocket failed to connect with error: \(error)")
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
}
#endif
