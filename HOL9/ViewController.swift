//
//  ViewController.swift
//  HOL9
//
//  Created by Mark Hawkins on 2/7/20.
//  Copyright © 2020 Revature. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var textView: UITextView!
    @IBOutlet var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //Called when an email was able to be composed. Depending on the action of
    //the email, a different result will occur. It is determined by the switch
    //statement and additional function can be place within it to run those processes
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith didFinishWithResult:MFMailComposeResult, error:Error?) {

        switch didFinishWithResult {
        case .cancelled:
            print("Mail cancelled")
            break
        case .saved:
            print("Mail saved")
            break
        case .sent:
            print("Mail sent")
            break
        case .failed:
            print("Mail failed")
            break
        }

        self.dismiss(animated: true, completion: nil)
    }

    //Funcaiton that a button calls to attempt to send an email.
    @IBAction func actionEmail(_ sender: UIButton) {
        
        //Checks if the device is alloed to send emails
        if MFMailComposeViewController.canSendMail() {
            //Text view from storyboard
            let message:String  = textView.text
            //Instatiate a new mail view controller
            let composePicker = MFMailComposeViewController()
            
            //Apply settings to main view controller
            composePicker.mailComposeDelegate = self
            composePicker.delegate = self
            composePicker.setToRecipients(["support@loginworks.com"])
            composePicker.setSubject("Testing Email")
            composePicker.setMessageBody(message, isHTML: false)
            
            //Have this view present the instantiated mail view controller
            self.present(composePicker, animated: true, completion: nil)
        }
        else {
            //Call the error alert created in this class
            self.showErrorMessage()
        }
    }
    
    //Simple error alert that is presented to the screen
    func showErrorMessage() {
        let alertMessage = UIAlertController(title: "Could Not Send Email", message: "Check if your device has email support", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertMessage.addAction(action)
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
}

