//
//  SuperViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/6.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {
    
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //如果KVO、观察者有改变
        NotificationCenter.default.addObserver(self, selector: #selector(isAnimation), name: NSNotification.Name.init(rawValue: "isAnimation"), object: nil)
        
        if self.index == 1 {
            self.tabBarController?.tabBar.frame = CGRect.init(x: self.tabBarController!.tabBar.frame.origin.x, y: self.tabBarController!.tabBar.frame.origin.y + self.tabBarController!.tabBar.frame.size.height, width: self.tabBarController!.tabBar.frame.size.width, height: self.tabBarController!.tabBar.frame.size.height)
        }
        
    }
    
    // 得到监听值
    @objc func isAnimation(notification: Notification) {
        let number: NSNumber = notification.object as! NSNumber
        let num: Int = number.intValue
        
        if num == 0{
            self.index = 1
        }else{
            self.index = 0
            UIView.animate(withDuration: 0.5) {
                self.tabBarController?.tabBar.frame = CGRect.init(x: self.tabBarController!.tabBar.frame.origin.x, y: self.tabBarController!.tabBar.frame.origin.y - self.tabBarController!.tabBar.frame.size.height, width: self.tabBarController!.tabBar.frame.size.width, height: self.tabBarController!.tabBar.frame.size.height)
            }
        }
    }
}
