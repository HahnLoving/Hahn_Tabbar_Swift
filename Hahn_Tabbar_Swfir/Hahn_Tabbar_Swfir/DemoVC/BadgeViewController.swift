//
//  BadgeViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/12/2.
//  Copyright © 2019 Hahn. All rights reserved.
//


import UIKit

class BadgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let backBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        backBtn.setTitle("back", for: .normal)
        // 这里的#selector 不要重名
        backBtn.addTarget(self, action: #selector(backBtnCkick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let canleBtn = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        canleBtn.setTitle("取消全部小红点", for: .normal)
        // 这里的#selector 不要重名
        canleBtn.addTarget(self, action: #selector(canleBtnCkick), for: .touchUpInside)
        self.view.addSubview(canleBtn)
        
        self.tabBarController?.tabBar.badgeSize = CGSize(width: 10, height: 10)
        
        self.tabBarController?.viewControllers?[0].tabBarItem.badgeValue = "1"
        
        self.showRedPoint()
    }
    
    // 小红点
    func showRedPoint() {
        let badgePoint = CGPoint(x: 25, y: -3)
        self.tabBarController?.tabBar.badgePoint = badgePoint
        self.tabBarController?.tabBar.badgeSize = CGSize(width: 20, height: 20)
        self.tabBarController?.tabBar.badgeColor = UIColor.red
        self.tabBarController?.tabBar.badgeValue = "1"
        self.tabBarController?.tabBar.showBadgeOnItemIndex(index: 1)
        
        let badgePoint1 = CGPoint(x: 25, y: -3)
        self.tabBarController?.tabBar.badgePoint = badgePoint1
        self.tabBarController?.tabBar.badgeSize = CGSize(width: 20, height: 20)
        self.tabBarController?.tabBar.badgeColor = UIColor.red
        self.tabBarController?.tabBar.badgeImage = UIImage(named: "demo")
        self.tabBarController?.tabBar.showBadgeOnItemIndex(index: 2)
        
        let badgePoint2 = CGPoint(x: 25, y: -3)
        self.tabBarController?.tabBar.badgePoint = badgePoint2
        self.tabBarController?.tabBar.badgeSize = CGSize(width: 10, height: 10)
        self.tabBarController?.tabBar.badgeColor = UIColor.red
        self.tabBarController?.tabBar.badgeValue = ""
        self.tabBarController?.tabBar.badgeImage = UIImage(named: "")
        self.tabBarController?.tabBar.showBadgeOnItemIndex(index: 3)
    }
    
    // MARK: - 返回按钮
    @objc func backBtnCkick(){
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 取消小红点
    @objc func canleBtnCkick(){
        self.tabBarController?.viewControllers?[0].tabBarItem.badgeValue = nil
        
        self.tabBarController?.tabBar.hiddenRedPointOnIndex(index: 1, animation: true)
        self.tabBarController?.tabBar.hiddenRedPointOnIndex(index: 2, animation: true)
        self.tabBarController?.tabBar.hiddenRedPointOnIndex(index: 3, animation: false)
    }

}
