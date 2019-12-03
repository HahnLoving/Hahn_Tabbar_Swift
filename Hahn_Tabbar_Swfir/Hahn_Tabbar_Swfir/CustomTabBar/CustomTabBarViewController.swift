//
//  CustomTabBarViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/28.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate, CustomTabBarDelegate {
    
    var customTabBar1 = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTabBar = CustomTabBar()
        // 取消tabBar的透明效果
        customTabBar.isTranslucent = false
        // 设置tabBar的代理
        customTabBar.myDelegate = self
        self.customTabBar1 = customTabBar
        self.setValue(customTabBar, forKey: "tabBar")
        
        self.customTabBar1.datePickBlock = {str in
            print(str)
        }
        self.customTabBar1.dictDataBlock = { dict in
            print(dict)
        }
        
        self.setUpTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - 控制器的信息
    func setUpTabBar() {
        
        let demo1VC  = Demo1ViewController()
        let demo2VC  = Demo2ViewController()
//        let demo4VC  = Demo4ViewController()
//        let demo5VC  = Demo5ViewController()
        
        creatTabbarView(viewController: demo1VC, image: "home_normal", selectImage: "home_highlight", title: "首页", tag: 1)
        creatTabbarView(viewController: demo2VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "附近", tag: 2)
//        creatTabbarView(viewController: demo4VC, image: "message_normal", selectImage: "message_highlight", title: "聊天", tag: 3)
//        creatTabbarView(viewController: demo5VC, image: "account_normal", selectImage: "account_highlight", title: "我的", tag: 4)
        
        self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
        self.tabBar.isTranslucent = false
        
        self.viewControllers = [
            UINavigationController(rootViewController: demo1VC),
            UINavigationController(rootViewController: demo2VC),
//            UINavigationController(rootViewController: demo4VC),
//            UINavigationController(rootViewController: demo5VC),
        ];
        
        self.delegate = self
    }
    
    // MARK: - TabBar里面的文字图片
    func creatTabbarView(viewController:UIViewController, image:NSString, selectImage:NSString, title:NSString, tag:NSInteger) {
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
        viewController.title = title as String
        viewController.tabBarItem.tag = tag
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        self.customTabBar1.plusButton.isSelected = false

        return true
    }
    
    // MARK: -- CustomTabBarDelegate
    func tabBarDidClickPlusButton() {
        /**
         definesPresentationContext这一属性决定了那个父控制器的View，
         将会以优先于UIModalPresentationCurrentContext这种呈现方式来展现自己的View。
         如果没有父控制器设置这一属性，那么展示的控制器将会是根视图控制器

         modalPresentationStyle可以设置模态是否隐藏

         */
        self.customTabBar1.plusButton.isSelected = true
        
        let vc = SimpleCustomDemoViewController()
        self.definesPresentationContext = true
        vc.view.backgroundColor = UIColor.clear
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
    
}

