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
    var chat: [[String: Any]] = []
    
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chat.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        /*
        let chats = chat[indexPath.row]
        let message = chat["message"] as! String
        cell.pastMessage.text = message
        */
        //cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    @IBAction func sendMessage(_ sender: Any)
    {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage.saveInBackground
            { (success, error) in
                if success
                {
                    print("The message was saved!")
                    self.chatMessageField.text = nil
                }
                else if let error = error
                {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
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
