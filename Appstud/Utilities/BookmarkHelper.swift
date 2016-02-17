//
//  BookmarkHelper.swift
//  Appstud
//
//  Created by Tuan Nguyen on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import Foundation

class BookmarkHelper: NSObject {
    static func storeContactList(contacts: NSArray!) {
        let result = NSMutableArray(capacity: contacts.count)
        for contact in contacts {
            let data = NSKeyedArchiver.archivedDataWithRootObject(contact)
            result.addObject(data)
        }
        
        NSUserDefaults.standardUserDefaults().setObject(result, forKey: "contacts")
    }
    
    static func getBookmarkList() -> NSArray? {
        let contactsEncoded = NSUserDefaults.standardUserDefaults().valueForKey("contacts") as? NSArray
        if contactsEncoded == nil {
            return nil;
        }
        
        let result = NSMutableArray(capacity: contactsEncoded!.count)
        for data in contactsEncoded! {
            let contact = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
            if contact != nil {
                result.addObject(contact!)
            }
        }
        
        return result;
    }
}
