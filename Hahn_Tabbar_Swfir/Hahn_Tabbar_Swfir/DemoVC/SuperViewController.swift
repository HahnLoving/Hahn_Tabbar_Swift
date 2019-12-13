//
//  SuperViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/6.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

// 屏幕尺寸
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

class SuperViewController: UIViewController {
    
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //如果KVO、观察者有改变
        // 京东tabbar
        NotificationCenter.default.addObserver(self, selector: #selector(isAnimation), name: NSNotification.Name.init(rawValue: "isAnimation"), object: nil)
        
        // 滑动隐藏Tabbar
        NotificationCenter.default.addObserver(self, selector: #selector(isSliding), name: NSNotification.Name.init(rawValue: "isSliding"), object: nil)
        
        if self.index == 1 {
            self.tabBarController?.tabBar.frame = CGRect.init(x: self.tabBarController!.tabBar.frame.origin.x, y: self.tabBarController!.tabBar.frame.origin.y + self.tabBarController!.tabBar.frame.size.height, width: self.tabBarController!.tabBar.frame.size.width, height: self.tabBarController!.tabBar.frame.size.height)
        }
        
    }
    
    // 京东tabbar 得到监听值
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
    
    // 滑动隐藏Tabbar得到监听值
    @objc func isSliding(notification: Notification) {
        let number: NSNumber = notification.object as! NSNumber
        let num: Int = number.intValue
        
        if num == 0{

            UIView.animate(withDuration: 0.5) {
                
                self.tabBarController?.tabBar.frame = CGRect.init(x: self.tabBarController!.tabBar.frame.origin.x, y: SCREEN_HEIGHT + self.tabBarController!.tabBar.frame.size.height, width: self.tabBarController!.tabBar.frame.size.width, height: self.tabBarController!.tabBar.frame.size.height)
             
                self.navigationController?.navigationBar.frame = CGRect.init(x: self.navigationController!.navigationBar.frame.origin.x, y: 0 - self.navigationController!.navigationBar.frame.size.height, width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)
                
                
            }
            
        }else{

            UIView.animate(withDuration: 0.5) {
                
                self.tabBarController?.tabBar.frame = CGRect.init(x: self.tabBarController!.tabBar.frame.origin.x, y: SCREEN_HEIGHT - self.tabBarController!.tabBar.frame.size.height, width: self.tabBarController!.tabBar.frame.size.width, height: self.tabBarController!.tabBar.frame.size.height)
                
                
                self.navigationController?.navigationBar.frame = CGRect.init(x: self.navigationController!.navigationBar.frame.origin.x, y: 0 + self.navigationController!.navigationBar.frame.size.height, width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)
                
            }
        }
    }
}
