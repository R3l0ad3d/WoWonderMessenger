//
//  GroupViewController.swift
//  WoWonder
//
//  Created by UnikaApp on 14/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import Async
import UIKit

extension ChatUserLIstViewController {
    
    //MARK: - fetchGroupRequest Call
    func groupViewFetchData(){
        if groupfetchSatus!{
            groupfetchSatus = false
//            //
        }else{
            log.verbose("will not show Hud more...")
        }
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.fetchGroups(session_Token: sessionToken, type: "get_list", limit: 10
                , completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("userList = \(success?.data ?? nil)")
                                self.refreshControl.endRefreshing()
                                if (success?.data?.isEmpty)!{
                                    self.groupTableView.isHidden = true
                                    self.refreshControl.endRefreshing()
                                } else {
                                    self.groupTableView.isHidden = false
                                    self.groupsArray = (success?.data) ?? []
                                    
                                    for index in 0..<self.groupsArray.count {
                                        let group_id = self.groupsArray[index]
                                        self.GroupChat(groupId: group_id.groupID ?? "")
                                    }
                                    self.refreshControl.endRefreshing()
                                }
                                self.fetchGroupRequest()
                            }
                            
                        })
                    }else if sessionError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                                log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            }
                        })
                    }else if serverError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                                log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            }
                            
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                                log.error("error = \(error?.localizedDescription ?? "")")
                            }
                        })
                    }
            })
        })
    }
    
    //MARK: - fetchGroupRequest Call
    private func fetchGroupRequest(){
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupRequestManager.instance.fetchGroupRequest(session_Token: sessionToken, fetchType: "group_chat_requests", offset: 1, setOnline: 1) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(String(describing: success?.groupChatRequests ?? nil))")
                            self.groupChatRequestArray = success?.groupChatRequests ?? []
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            }
        })
    }
    
    //MARK: - GroupChat fetchData
     func GroupChat(groupId: String) {
        let sessionID = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.getGroupChats(group_Id: groupId, session_Token: sessionID, type: "fetch_messages", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    
                    Async.main({
                        self.dismissProgressDialog { [self] in
                            log.debug("userList = \(success?.data?.messages?.count ?? nil)")

                            self.groupsArrayMessage.append((success?.data)!)
                            self.groupTableView.reloadData()
                            
                        }
                    })
                } else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            
                        }
                    })
                } else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                } else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            })
        })
    }
}
