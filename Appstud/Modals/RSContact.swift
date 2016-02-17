//
//  RSContact.swift
//  Appstud
//
//  Created by Tuan Nguyen on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//  Modified by Toan Nguyen
//

import UIKit
import Foundation

class RSContact: NSObject ,NSCopying{
    var firstName : String?
    var lastName : String?
    var image : String?
    var status : String?
    var isBookmark: Bool?
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]!{
        let fields = ["firstName":"firstname",
            "lastName" : "lastname","image" : "hisface"]
        return fields;
    }
    
    func profileImage () -> String {
        return "\(ROCKSTAR_SERVER_URL)\(image!)"
    }
    
//    override func mj_newValueFromOldValue(oldValue: AnyObject!, property: MJProperty!) -> AnyObject! {
//        if property.name == "hisface" {
//            return "\(ROCKSTAR_SERVER_URL)\(oldValue)"
//        }
//        
//        return oldValue;
//    }
    
    // MARK: Conform to NSCopying protocol
    func copyWithZone(zone:NSZone) -> AnyObject {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self);
        let copyInstance: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data);
        return copyInstance!;
    }
    
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        self.firstName  = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName  = aDecoder.decodeObjectForKey("lastName") as? String
        self.image  = aDecoder.decodeObjectForKey("image") as? String
        self.status  = aDecoder.decodeObjectForKey("status") as? String
        self.isBookmark  = aDecoder.decodeObjectForKey("isBookmark") as? Bool
    }

    func encodeWithCoder(aCoder: NSCoder) {
        if let firstName = self.firstName{
            aCoder.encodeObject(firstName, forKey: "firstName")
        }
        
        if let lastName = self.lastName{
            aCoder.encodeObject(lastName, forKey: "lastName")
        }
        if let image = self.image{
            aCoder.encodeObject(image, forKey: "image")
        }
        
        if let status = self.status{
            aCoder.encodeObject(status, forKey: "status")
        }
        
        if let isBookmark = self.isBookmark{
            aCoder.encodeObject(isBookmark, forKey: "isBookmark")
        }
    }
}
