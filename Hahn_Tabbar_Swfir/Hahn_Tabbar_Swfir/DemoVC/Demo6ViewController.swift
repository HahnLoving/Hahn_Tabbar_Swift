//
//  Demo6ViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/6.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class Demo6ViewController: UIViewController {
    
    var str:String!
    
    // MARK: - 类似OC dealloc
    deinit {
        self.removeObserver(self, forKeyPath: "isAnimation", context: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        // 设置KVO、观察者
        self.addObserver(self, forKeyPath: "isAnimation", options: .new, context: nil)
        let str1 = "\(self.str as! String)"
        print(str1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let number:NSNumber = 0

        // 对KVO、观察者发送信息
//        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "isAnimation"), object: number)
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "isAnimation"), object: number)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let number:NSNumber = 1
        // 对KVO、观察者发送信息
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "isAnimation"), object: number)
    }
}
