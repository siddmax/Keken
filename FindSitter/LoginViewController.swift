//
//  LoginViewController.swift
//  FindSitter
//
//  Created by Siddharth Sharma on 4/23/15.
//  Copyright (c) 2015 Siddharth Sharma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func pressedFBLogin(sender: UIButton) {
    PFFacebookUtils.logInWithPermissions(["public_profile", "user_about_me", "user_birthday"], block: {
      user, error in
      
      if user == nil {
        println("Nope, user canceled facebook login.")
        let alertController = UIAlertController(title: "Error Logging In",
          message: "You failed to login because you don't have facebook installed or facebook permissions for the app!",
          preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
          // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
          // ...
        }
        return
      }
      else if user.isNew {
        println("User signed up and loggin in through facebook")
        FBRequestConnection.startWithGraphPath("/me?fields=picture,first_name,birthday,gender",
          completionHandler: {
            connection, result, error in
            var rDict = result as NSDictionary
            user["firstName"] = rDict["first_name"]
            user["gender"] = rDict["gender"]
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            user["birthday"] = dateFormatter.dateFromString(rDict["birthday"] as String)
            
            let pictureURL = ((rDict["picture"] as NSDictionary) ["data"] as NSDictionary) ["url"] as String
            let url = NSURL(string: pictureURL)
            let request = NSURLRequest(URL: url!)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
              response, data, error in
              let imageFile = PFFile(name: "avatar.jpg", data: data)
              user["picture"] = imageFile
              user.saveInBackgroundWithBlock(nil)
            })
        })
      }
      else {
        println("User logged in through facebook")
      }
      
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
      self.presentViewController(vc!, animated: true, completion: nil)
    })
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
