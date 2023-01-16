//
//  UserDataService.swift
//  Smack
//
//  Created by Besh Prakash  on 15.08.22.
//

import Foundation
// MARK: USERDATASERVICE
/// Implement all services needed for user
/// ```
/// UserDataServices
/// ```
class  UserDataService {
    static let instance = UserDataService()
    public private(set) var id = ""
    public private (set) var avatarColor = ""
    public private (set) var avatarName = ""
    public private (set) var email = ""
    public private (set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    // MARK: STRIN2COLOR
    /// Take string value and return to color
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        // skipped character sets
        let skipped = CharacterSet(charactersIn: "[], ")
        
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard
            let rUwrapped = r,
            let gUwrapped = g,
            let bUwrapped = b,
            let aUwrapped = a else { return defaultColor}
        
        let rfloat = CGFloat(rUwrapped.doubleValue)
        let gfloat = CGFloat(gUwrapped.doubleValue)
        let bfloat = CGFloat(bUwrapped.doubleValue)
        let afloat = CGFloat(aUwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logoutUser(){
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessage()
    }
}
