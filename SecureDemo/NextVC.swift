//
//  NextVC.swift
//  SecureDemo
//
//  Created by avinash on 22/04/24.
//

import UIKit

class NextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
  
    }


}
