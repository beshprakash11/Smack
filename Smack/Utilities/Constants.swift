//
//  Constants.swift
//  Smack
//
//  Created by Besh Prakash  on 10.08.22.
//

import Foundation
import Alamofire

// MARK: CompletionHandler
typealias CompletionHandler = (_ Success: Bool) -> ()

// MARK: URLConstants
let BASE_URL = "http://192.168.178.30:3005/v1/" // "http://192.168.2.126:3005/v1/"

// MARK: ACCOUNT_REGISTER
let URL_REGISTER = "\(BASE_URL)account/register"

// MARK: ACCOUT_LOGIN
let URL_LOGIN = "\(BASE_URL)account/login"

// MARK: USER_ADD
let URL_USER_ADD = "\(BASE_URL)user/add"

// MARK: FIND_USERBY_EMAIL
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"

// MARK: CHANNEL_URL
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

// MARK: CHANNEL_MESSAGES
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

// MARK: Headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]


let BEARE_HEADER = [
    "Authorization" :"Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]

// MARK Serializer
//let RES_SERIALIZER = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))

// MARK: SEGUE_CONSTANT
/// This Utilites section is used to define different identifier used in the application.
/// E.g., TO_LOGIN ==> "toLogin"
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT =  "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// MARK: USERDEFAULTS
/// Define constant required to login and authenticate the users.
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


// MARK: COLORS
let smackPurplePlaceholder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// MARK: NOTIFICATION CONSTANTS
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

// MARK: Channel loaded
let NOTIF_CHANNELS_LOADED = Notification.Name("channelLoaded")

// MARK: Channel selected
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")
