//
//  ProfileViewController.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var user: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userImageView.clipsToBounds = true
        
        // Setup UIImagePickerController
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        
        // Get current user data
        self.user = UserProfile.currentUser()
        
        // Set current user data
        if let image = self.user?.userImage{
            self.userImageView.image = image
        }
        
        self.usernameTextField.text = self.user?.userFullName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation Bar Button Method
    */

    @IBAction func saveProfileButtonTapped(sender: AnyObject) {
        self.view.endEditing(true)
        
        self.user = UserProfile()
        self.user?.userFullName = self.usernameTextField.text
        self.user?.userImage = self.userImageView.image
        self.user?.save()
    }
    
    /*
    // MARK: - Button Method
    */
    @IBAction func changeUserImageAction(sender: AnyObject) {
        if let _ = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo){
            self.imagePicker.sourceType = .Camera
            self.imagePicker.cameraDevice = .Front
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        else{
            UIAlertView(title: "Error", message: "We do not support this function cause your device has no camera", delegate: nil, cancelButtonTitle: "Close").show()
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.changeDisplayPhoto(image)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // close the keyboard on Enter
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    /*
    // MARK: - Private Method
    */
    
    private func changeDisplayPhoto(img: UIImage){
        UIView.transitionWithView(self.userImageView,
            duration: 0.5, options: .TransitionCrossDissolve,
            animations: { () -> Void in
            self.userImageView.image = img
            }, completion: nil)
    }
}
