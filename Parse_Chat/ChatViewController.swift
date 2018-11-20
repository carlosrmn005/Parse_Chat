//
//  ChatViewController.swift
//  Parse_Chat
//
//  Created by macstudent on 10/11/18.
//  Copyright © 2018 Carlos Roman. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chat: [[String: Any]] = []
    var chatContents = [PFObject]()
    
    let User = PFUser.current()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        
        onTimer()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chatContents.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let chatrow = chatContents[indexPath.row]
        let text = chatrow["text"] as? String
        
        //cell.chatMessageLabel.text = chatMessage
        
        if let user = chatrow["username"] as? String {
            // User found! update username label with username
            cell.userNameLabel.text = user
        } else {
            // No user found, set default username
            cell.userNameLabel.text = "🤖"
        }
        
        cell.chatMessageLabel.text = text
        
        return cell
    }
    
    @IBAction func sendMessage(_ sender: Any)
    {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["username"] = (PFUser.current()?.username)
        
        chatMessage.saveInBackground
        { (success, error) in
            if success
            {
                print("The message was saved!")
                self.chatMessageField.text = ""
            }
            else if let error = error
            {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        //self.chatMessageField.text = nil
    }
    
    func refresh()
    {
        // construct query
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("User")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let object = objects
            {
                // do something with the array of object returned by the call
                self.chatContents = object
                self.tableView.reloadData()
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    @objc func onTimer()
    {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        refresh()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
