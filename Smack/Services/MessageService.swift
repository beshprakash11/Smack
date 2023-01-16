//
//  MessageService.swift
//  Smack
//
//  Created by Besh Prakash  on 18.08.22.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannel = [String]()
    
    //currently selected channel
    var selectedChannel: Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARE_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let name = item["name"].stringValue
                            let channelDescription = item["descripton"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                    
                }catch let error as NSError{
                    debugPrint(error as Any)
                }
            }else {
                completion(false)
                debugPrint("Find all channel error: ", response.result.error as Any)
            }
        }
        
        
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARE_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessage()
                
                guard let data = response.data else { return }
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                            
                        }
                        debugPrint(self.messages)
                        completion(true)
                        
                    }
                }catch let error as NSError{
                    debugPrint("Message loading error 1: \(error)")
                }
                
            }else{
                debugPrint("Message loading error x: ",response.result.error as Any)
                completion(false)
            }
        }
    }
    func clearMessage(){
        messages.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
}
