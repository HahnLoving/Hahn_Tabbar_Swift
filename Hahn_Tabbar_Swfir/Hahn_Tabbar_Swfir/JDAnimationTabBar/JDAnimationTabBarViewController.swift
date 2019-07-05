//
//  JDAnimationTabBarViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/6.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class JDAnimationTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - 控制器的信息
    func setUpTabBar() {
        
        let demo1VC  = Demo7ViewController()
        let demo2VC  = Demo2ViewController()
        let demo3VC  = Demo3ViewController()
        let demo4VC  = Demo4ViewController()
        let demo5VC  = Demo5ViewController()
        
        creatTabbarView(viewController: demo1VC, image: "home_normal", selectImage: "home_highlight", title: "首页", tag: 1)
        creatTabbarView(viewController: demo2VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "附近", tag: 2)
        creatTabbarView(viewController: demo3VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "你好", tag: 3)
        creatTabbarView(viewController: demo4VC, image: "message_normal", selectImage: "message_highlight", title: "聊天", tag: 4)
        creatTabbarView(viewController: demo5VC, image: "account_normal", selectImage: "account_highlight", title: "我的", tag: 5)
        
        self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
        self.tabBar.isTranslucent = false
        
        self.viewControllers = [
            UINavigationController(rootViewController: demo1VC),
            UINavigationController(rootViewController: demo2VC),
            UINavigationController(rootViewController: demo3VC),
            UINavigationController(rootViewController: demo4VC),
            UINavigationController(rootViewController: demo5VC),
        ];
        
    }
    
    // MARK: - TabBar里面的文字图片
    func creatTabbarView(viewController:UIViewController, image:NSString, selectImage:NSString, title:NSString, tag:NSInteger) {
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
        viewController.title = title as String
        viewController.tabBarItem.tag = tag
        
    }
    

}
