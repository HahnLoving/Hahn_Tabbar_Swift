//
//  TabBarViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/24.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    public var isBadge:Bool! = false                                // true是自定义小红点 false是常规的 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpTabBar()
    }
    
    // MARK: - 控制器的信息
    func setUpTabBar() {
        
        let demo1VC  = Demo1ViewController()
        let demo2VC  = Demo2ViewController()
        let demo3VC  = Demo3ViewController()
        let demo4VC  = Demo4ViewController()
        let demo5VC  = Demo5ViewController()
        let demo6VC  = BadgeViewController()
        
        if isBadge {
            creatTabbarView(viewController: demo6VC, image: "home_normal", selectImage: "home_highlight", title: "首页")
        }else{
            creatTabbarView(viewController: demo1VC, image: "home_normal", selectImage: "home_highlight", title: "首页")
        }
        creatTabbarView(viewController: demo2VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "附近")
        creatTabbarView(viewController: demo3VC, image: "mycity_normal", selectImage: "mycity_normal", title: "发布")
        creatTabbarView(viewController: demo4VC, image: "message_normal", selectImage: "message_highlight", title: "聊天")
        creatTabbarView(viewController: demo5VC, image: "account_normal", selectImage: "account_highlight", title: "我的")
        
        self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
        self.tabBar.isTranslucent = false
        
        if isBadge {
            self.viewControllers = [
                UINavigationController(rootViewController: demo6VC),
                UINavigationController(rootViewController: demo2VC),
                UINavigationController(rootViewController: demo3VC),
                UINavigationController(rootViewController: demo4VC),
                UINavigationController(rootViewController: demo5VC),
            ];
        }else{
            self.viewControllers = [
                UINavigationController(rootViewController: demo1VC),
                UINavigationController(rootViewController: demo2VC),
                UINavigationController(rootViewController: demo3VC),
                UINavigationController(rootViewController: demo4VC),
                UINavigationController(rootViewController: demo5VC),
            ];
        }
        
        
    }
    
    // MARK: - TabBar里面的文字图片
    func creatTabbarView(viewController:UIViewController, image:NSString, selectImage:NSString, title:NSString) {
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
        viewController.title = title as String
    }
    
}
