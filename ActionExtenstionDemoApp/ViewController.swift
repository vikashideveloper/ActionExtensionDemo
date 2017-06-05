//
//  ViewController.swift
//  ActionExtenstionDemoApp
//
//  Created by Vikash Kumar on 11/05/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lbl: UILabel!
    
    let stringToShare = "Hi, This is test string to share."
    var activityVC : UIActivityViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = stringToShare
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func shareButtonAction(sender: UIButton) {
        activityVC = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType, result, items, error) in
        
            if let type = activityType {
                print("Activity Type : \(type)")
            }
            
            print("Is Success : \(result ? "Yes" : "No")")
            
            if let items = items {
                print("Response Items : \(items)")
                if let item = items.first as? NSExtensionItem {
                    if let textData = item.userInfo?[NSExtensionItemAttributedContentTextKey] as? Data {
                        let string = NSString(data: textData, encoding:String.Encoding.utf8.rawValue)
                        print(string)
                    }
                }
            }
            
            if let err = error {
                print("Error : \(err.localizedDescription)")
            }
        }
        
        
        self.present(activityVC, animated: true, completion: nil)
    }
}

