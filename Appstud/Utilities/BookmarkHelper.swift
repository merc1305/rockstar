//
//  BookmarkHelper.swift
//  Appstud
//
//  Created by Tuan Nguyen on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import Foundation

class BookmarkHelper: NSObject {
    private static func storeContactList(contacts: NSArray!) {
        let result = NSMutableArray(capacity: contacts.count)
        for contact in contacts {
            let data = NSKeyedArchiver.archivedDataWithRootObject(contact)
            result.addObject(data)
        }
        
        NSUserDefaults.standardUserDefaults().setObject(result, forKey: "contacts")
    }
    
    static func addContact(contact: RSContact){
        let contacts = getBookmarkList()
        let bookmarkList : NSMutableArray?
        if contacts != nil {
            bookmarkList = NSMutableArray(array: contacts!)
        }
        else{
            bookmarkList = NSMutableArray(capacity: 1)
        }
        
        bookmarkList!.addObject(contact)
        storeContactList(bookmarkList)
    }
    
    static func removeContact(contact: RSContact) {
        let contacts = getBookmarkList()
        let bookmarkList : NSMutableArray?
        if contacts != nil {
            bookmarkList = NSMutableArray(array: contacts!)
            for object in bookmarkList!{
                let ct = object as! RSContact
                if ct.firstName == contact.firstName && ct.lastName == contact.lastName {
                    bookmarkList?.removeObject(ct)
                    break
                }
            }

            storeContactList(bookmarkList)
        }
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
