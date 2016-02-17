//
//  ServiceManager.swift
//  Appstud
//
//  Created by Tuan Nguyen on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    
    static func requestToGetContacts(success:GetContactsSuccessCallback, failure:FailureCallback?){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let urlPath: String = "\(ROCKSTAR_SERVER_URL)contacts.json"
        let url: NSURL = NSURL(string: urlPath)!
        
        let request: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if data != nil{
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    let contacts = RSContact.mj_objectArrayWithKeyValuesArray(json!["contacts"])
                    
                    success(contacts)
                }
                catch{
                    if failure != nil{
                        failure!("An error occurred.Try again later")
                    }
                }
            }
            else{
                if failure != nil{
                    failure!("An error occurred.Try again later")
                }
            }
        })
    }
    
}
