//
//  demo7ViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/7/6.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class Demo7ViewController: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let backBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        backBtn.setTitle("back", for: .normal)
        // 这里的#selector 不要重名
        backBtn.addTarget(self, action: #selector(backBtnCkick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let pushBtn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        pushBtn.setTitle("push", for: .normal)
        // 这里的#selector 不要重名
        pushBtn.addTarget(self, action: #selector(pushBtnCkick), for: .touchUpInside)
        self.view.addSubview(pushBtn)
    }
    
    // MARK: - 返回按钮
    @objc func backBtnCkick(){
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - push按钮
    @objc func pushBtnCkick(){
        let demo6VC = Demo6ViewController()
        demo6VC.hidesBottomBarWhenPushed = true
        demo6VC.str = "大番薯"
        self.navigationController?.pushViewController(demo6VC, animated: true)
    }


}
