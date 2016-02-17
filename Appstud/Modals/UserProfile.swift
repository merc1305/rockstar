//
//  UserProfile.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class UserProfile: NSObject , NSCoding {
    
    var userFullName: String?
    var userImage: UIImage?
    
    // MARK: Conform to NSCopying protocol
    func copyWithZone(zone: NSZone) -> AnyObject {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        let copyInstance: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        return copyInstance!;
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.userFullName  = aDecoder.decodeObjectForKey("userFullName") as? String
        self.userImage  = aDecoder.decodeObjectForKey("userImage") as? UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let userFullName = self.userFullName{
            aCoder.encodeObject(userFullName, forKey: "userFullName")
        }
        if let userImage = self.userImage{
            aCoder.encodeObject(userImage, forKey: "userImage")
        }
    }
    
    // MARK: current user
    static func currentUser() -> UserProfile?{
        var user : UserProfile? = nil
        let data = NSUserDefaults.standardUserDefaults().valueForKey("currentUser") as! NSData?
        if(data != nil){
            user = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! UserProfile?
        }
        
        return user;
    }
    
    // MARK: - Utility methods
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "currentUser")
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("currentUser")
    }


}
