//
//  AnimationTabBarViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/3.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit
// 音效框架
import AudioToolbox

class AnimationTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - 控制器的信息
    func setUpTabBar() {
        
        let demo1VC  = Demo1ViewController()
        let demo2VC  = Demo2ViewController()
        let demo3VC  = Demo3ViewController()
        let demo4VC  = Demo4ViewController()
        let demo5VC  = Demo5ViewController()
        
        creatTabbarView(viewController: demo1VC, image: "home_normal", selectImage: "home_highlight", title: "首页", tag: 0)
        creatTabbarView(viewController: demo2VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "附近", tag: 1)
        creatTabbarView(viewController: demo3VC, image: "mycity_normal", selectImage: "mycity_highlight", title: "发布", tag: 2)
        creatTabbarView(viewController: demo4VC, image: "message_normal", selectImage: "message_highlight", title: "聊天", tag: 3)
        creatTabbarView(viewController: demo5VC, image: "account_normal", selectImage: "account_highlight", title: "我的", tag: 4)
        
        self.viewControllers = [
            UINavigationController(rootViewController: demo1VC),
            UINavigationController(rootViewController: demo2VC),
            UINavigationController(rootViewController: demo3VC),
            UINavigationController(rootViewController: demo4VC),
            UINavigationController(rootViewController: demo5VC),
        ];
        
        self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
        self.tabBar.isTranslucent = false
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
    /**
     点击TabBar的时候调用
     */
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.touchAnimation(index: item.tag)
    }
    
    func touchAnimation(index:NSInteger){
        // 得到当前tabbar的下标
        var tabbarbuttonArray:NSMutableArray!
        tabbarbuttonArray = NSMutableArray.init()
        for tabBarButton:UIView in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!){
                tabbarbuttonArray.add(tabBarButton)
            }
        }
        /**
         对当前下标的tabbar使用帧动画
         可以根据UI的具体要求进行动画渲染
         */
        let pulse = CABasicAnimation.init(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        pulse.duration = 0.2
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = 0.7
        pulse.toValue = 1.3
        let thisView = tabbarbuttonArray[index] as! UIView
        thisView.layer.add(pulse, forKey: nil)
        
        self.playSoundEffect(name: "music", type: "wav")
    }
    
    // MARK: - 播放音效的方法
    func playSoundEffect(name:String, type:String) {
        //获取声音地址
        let resoucePath = Bundle.main.path(forResource: name, ofType: type)
        var soundID:SystemSoundID = 0
        //地址转换
        let baseURL = NSURL(fileURLWithPath: resoucePath!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
        
    }
}
