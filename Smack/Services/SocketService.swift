//
//  SocketService.swift
//  Smack
//
//  Created by Besh Prakash  on 22.08.22.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
       self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
       self.socket = manager.defaultSocket
       super.init()
    }
    /*
    override init(){
        super.init()
    }
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)*/
    
    
    
    func establishedConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)// "newChannel" from nodejs api
        completion(true)
        
    }
    
    
    // all called form the node api
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated"){ (dataArray, ack) in
            guard
                let channelName = dataArray[0] as? String,
                let channelDesc = dataArray[1] as? String,
                let channelId = dataArray[2] as? String
            
            else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) ->Void ){
        socket.on("messageCreated") { (dataArray, ack) in
            guard
                let msgBody = dataArray[0] as? String,
                let channelId = dataArray[2] as? String,
                let userName = dataArray[3] as? String,
                let userAvatar = dataArray[4] as? String,
                let userAvatarColor = dataArray[5] as? String,
                let id = dataArray[6] as? String,
                let timeStamp = dataArray[7] as? String
            else { return }
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            completion(newMessage)
            /*if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                
                
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else{
                completion(true)
            }*/
                    
        }
    }
    
    func getTypingUser(_ completionHandler: @escaping(_ typingUsers: [String: String]) -> Void){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            
            completionHandler(typingUsers)
        }
    }

}
