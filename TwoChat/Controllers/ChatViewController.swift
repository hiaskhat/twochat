//
//  ChatViewController.swift
//  TwoChat
//
//  Created by Асхат Баймуканов on 25.02.2022.
//


import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "⚡️TwoChat"
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to Firestore, \(e)")
                } else {
                    print("Sucssessfuly saved data")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: false)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - Table View Data Source methods

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //setting different style for sender and not sender
        
        //this is a message from a current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: "yellow")
            cell.label.textColor = UIColor(named: "black")
        }
        
        //this is a message from another user
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: "orange")
            cell.label.textColor = UIColor(named: "grey")
        }
    
        return cell
    }
}
