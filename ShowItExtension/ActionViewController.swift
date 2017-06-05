//
//  ActionViewController.swift
//  ShowItExtension
//
//  Created by Vikash Kumar on 11/05/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        let item = self.extensionContext?.inputItems[0] as! NSExtensionItem
        let provider = item.attachments![0] as! NSItemProvider
        if provider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) {
           provider.loadItem(forTypeIdentifier: kUTTypePlainText as String, options: nil, completionHandler: { (item, error) in
            if let item = item as? String {
                self.lbl.text = item
            }
           })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        let changedText = lbl.text! + "\n:- Changed by ShowIt Extension."
        let item = NSExtensionItem()
        item.attributedContentText = NSAttributedString(string: changedText)

        self.extensionContext!.completeRequest(returningItems: [item], completionHandler: nil)
    }

}
