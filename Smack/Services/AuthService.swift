//
//  AuthService.swift
//  Smack
//
//  Created by Besh Prakash  on 11.08.22.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    
    // MARK: CHECKEDFORLOGIN
    /// Check if users loged in or not
    /// ```
    /// isLoggedIn: Bool -> True or false
    /// get { LOGGED_IN_KEY }
    /// set { LOGGED_IN_KEY }
    /// ```
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        
        get {
            //if defaults.value(forKey: TOKEN_KEY) != nil{
            return  defaults.value(forKey: TOKEN_KEY) as! String
                        
           /*}else{
                return defaults.value(forKey: TOKEN_KEY) as?  String ?? ""
            }*/
        
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            return defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // MARK: RegisterUser
    /// Register New Users
    /// ```
    /// registerUser(email: String, password: String, completion: @escaping CompletionHandler) -> register(email: "besh@arrtsm.com", password: "password", completoin: "success")
    /// ```
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint("User Registration error: ",response.result.error as Any)
            }
        }
    }
    
    // MARK: LoginUser
    /// Login Created users
    /// ```
    ///loginUser(email: String, password: String, completion: @escaping CompletionHandler) -> loginUser("besh@gmail.com","password")
    /// ```
    /// Takes 2 argument i.e., username or email and password
    /// output: token after successful login
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{(response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                    debugPrint(self.authToken)
                }catch let error as NSError {
                    debugPrint(error)
                }
                
            }else{
                completion(false)
                debugPrint("Logged in error: ",response.result.error as Any)
            }
        }
        
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name" : name,
            "email": lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARE_HEADER).responseData { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                
                completion(true)
            }else{
                completion(false)
                debugPrint("Create user error: ",response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARE_HEADER).responseJSON{ (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                // Orginal code
                /*
                 do {
                    let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    
                    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                }catch let error as NSError{
                    debugPrint("User setup error :  \(error)")
                }
                */
                
                completion(true)
            }else{
                completion(false)
                debugPrint("Find by email: ",response.result.error as Any)
            }
        }
        
    }
    
    func setUserInfo(data: Data){
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        }catch let error as NSError{
            debugPrint("User setup error :  \(error)")
        }
        
    }
}



