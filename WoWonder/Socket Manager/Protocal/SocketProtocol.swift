//
//  SocketProtocol.swift
//  WoWonder
//
//  Created by Mac on 21/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Set Typing Stutes Delegate
protocol SetTypingstutesDelegate: AnyObject {
    func setTypingstutes(typing: String)
}

//MARK: - Set Typing Stutes Delegate
protocol DoneTypingstutesDelegate: AnyObject {
    func doneTypingstutes(typing: String)
}

//MARK: - Send Massage Delegate
protocol SendMassageDelegate: AnyObject {
    func sendMessages(avatar: String,
                      color: String,
                      id: String,
                      isMedia: String,
                      isRecord: String,
                      message_html: String,
                      message: String,
                      message_id: String,
                      receiver: String,
                      sender: String,
                      time: String,
                      username:String )
}

