//
//  SocketIOHelper.swift
//  WoWonder
//
//  Created by Mac on 20/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import SocketIO
import SwiftEventBus
import WowonderMessengerSDK
import UIKit

//class SocketMangaer {
//
//    //MARK: - varible;'s
//    var socket =  SocketIOClient()
//
//    //MARK: - Let Value
//    static let sharedInstance = SocketMangaer()
//    let socketManager = SocketManager(socketURL: URL(string: "https://demo.wowonder.com:449")!, config: [.log(true), .compress])
//    var delegate: SetTypingstutesDelegate?
//    var sendDelegate: SendMassageDelegate?
//    var doneTypingstutesDelegate: DoneTypingstutesDelegate?
//
//    init() {
//        self.socket = socketManager.defaultSocket
//        if self.checkSocketConnection() {}
//        self.setupSocketEvents()
//    }
//
//
//    //MARK: - checkSocketConnection
//    func checkSocketConnection() -> Bool {
//        let socketConnectionStatus = socket?.status
//        switch socketConnectionStatus {
//        case .connected:
//            return true
//        case .connecting, .disconnected, .notConnected, .none:
//            return false
//        }
//    }
//bolshuthayche
//    //MARK: - EstablishConnection
//    func establishConnection() {
//        socket?.connect()
//
//        socket?.once(clientEvent: .connect) {data, _ in
//            print("socket connected \(data)")
//            self.setupSocketEvents()
//        }
//
//        self.socket?.on(clientEvent: .ping) {_, _ in
//            print("socket ping client id === \(String(describing: self.socket?.sid))")
//        }
//
//        self.socket?.on(clientEvent: .pong) {_, ack in
//            print("socket pong ack === \(ack.debugDescription)")
//        }
//
//        self.socket?.on(clientEvent: .error) {data, _ in
//            print("socket error === \(data)")
//        }
//
//        self.socket?.on(clientEvent: .statusChange, callback: { (data, _) in
//            print("socket status change === \(data)")
//            if self.socket?.status == .notConnected || self.socket?.status == .disconnected {
//                self.establishConnection()
//            }
//        })
//    }
//
//    // MARK: - Socket Observors
//    func setupSocketEvents() {
//        socket?.on(clientEvent: .connect) {_, _ in
//            print("Connected")
//        }
//
//        socket?.on("typing") { (data, _) in
//            guard let dataInfo = data.first else { return }
//            print("Database => \(dataInfo) ")
//        }
//    }
//
//    //MARK: - SendTyping
//    func sendTypingStatusSocketCall(recipentID: String, userID: String ,completionBlock: @escaping () ->()) {
//        let data = [
//            API.SOCKET_PARAMS.recipient_id: recipentID,
//            API.SOCKET_PARAMS.user_id: userID, ] as [String : Any]
//        self.socketManager.emitAll("typing", data)
//        completionBlock()
//    }
//
//    func sendMessageSocketCall(to_id: String, from_id: String, username: String, msg: String, color: String, isSticker: Bool, completionBlock: @escaping () ->()) {
//        let data = [API.SOCKET_PARAMS.to_id: to_id,
//                    API.SOCKET_PARAMS.from_id: from_id,
//                    API.SOCKET_PARAMS.username: username,
//                    API.SOCKET_PARAMS.msg: msg,
//                    API.SOCKET_PARAMS.color: color,
//                    API.SOCKET_PARAMS.isSticker: isSticker] as [String : Any]
//        self.socketManager.emitAll("typing", data)
//    }
//
//    //MARK: - CloseConnection
//    func closeConnection() {
//        socket?.disconnect()
//    }
//}


class SocketHelper {
    
    static let shared = SocketHelper()
    var socket: SocketIOClient!
    
    let manager = SocketManager(socketURL: URL(string: "https://demo.wowonder.com:449")!, config: [.log(true), .compress])
    
    private init() {
        socket = manager.defaultSocket
    }
    
    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        
        self.socket?.on(clientEvent: .error) {data, _ in
            print("socket error === \(data)")
        }
        socket.connect()
    }
    
    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }
    
    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
    }
    
    func emit(emitName: String ,params: [String : Any]) {
        SocketHelper.shared.socket.emit(emitName, params)
    }
    
    func responseSocket(socketType: String, completion: @escaping (Any) -> Void) {
        SocketHelper.shared.socket.on(socketType) { (response, emitter) in
            completion(response)
        }
    }
    
    func seenMessages(recipient_id: String, user_id: String, current_user_id: String) {
        let Data = ["recipient_id":recipient_id,
                    "user_id":user_id,
                    "current_user_id":current_user_id]
        SocketHelper.shared.socket.emit("seen_messages", Data)
    }
}
