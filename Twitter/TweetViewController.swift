//
//  TweetViewController.swift
//  Twitter
//
//  Created by Stephanie Santana on 2/26/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var characterCount: UILabel!
    
    @IBOutlet weak var charLabel: UILabel!
    @IBAction func cancel(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet\(error)")
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
                self.dismiss(animated: true, completion: nil)
            }
        
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        
        tweetTextView.delegate = self


        // Do any additional setup after loading the view.
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        characterCount.text = String(characterLimit - newText.characters.count)
        
        // TODO: Update Character Count Label
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
}
