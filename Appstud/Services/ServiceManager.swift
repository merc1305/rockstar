//
//  ServiceManager.swift
//  Appstud
//
//  Created by Tuan Nguyen on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    
    static func requestToGetContacts(success:GetContactsSuccessCallback, failure:FailureCallback){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = "\(ROCKSTAR_SERVER_URL)/contact.json"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let jsonData = NSData(url)
            if jsonData != nil {
                let jsonDict = NSJSONSerialization.dataWithJSONObject(jsonData, options: .kNilOptions)
                if jsonDict != nil {
                    
                }
            }
        }
    }
    
}
