//
//  Demo1ViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/24.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let backBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        backBtn.setTitle("back", for: .normal)
        // 这里的#selector 不要重名
        backBtn.addTarget(self, action: #selector(backBtnCkick), for: .touchUpInside)
        self.view.addSubview(backBtn)
    }
    
    // MARK: - 返回按钮
    @objc func backBtnCkick(){
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }

}
