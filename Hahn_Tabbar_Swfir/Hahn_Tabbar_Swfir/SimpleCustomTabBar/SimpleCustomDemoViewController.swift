//
//  SimpleCustomDemoViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/27.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class SimpleCustomDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let thisView = UIView.init(frame: self.view.frame)
        thisView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        self.view.addSubview(thisView)
        
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        backBtn.setTitle("返回", for: UIControl.State.normal)
        backBtn.center = self.view.center
        self.view.addSubview(backBtn)
        backBtn.backgroundColor = UIColor.red
        backBtn.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
    }
    
    // MARK: -返回按钮
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }

}
