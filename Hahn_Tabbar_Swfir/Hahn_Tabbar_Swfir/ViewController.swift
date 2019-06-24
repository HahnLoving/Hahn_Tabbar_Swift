//
//  ViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/24.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    // tableView
    @IBOutlet weak var tableView: UITableView!
    
    // 懒加载的数据源
    /**
     swift懒加载只会在首次使用的时候创建一次，之后再次使用或者新赋值都不会去重新创建了，而是就保存新设置的值
     */
    lazy var dataArray1:[String] = {
        let arr = ["系统TabBar","自定义TabBar"]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell==nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        cell?.textLabel?.text = self.dataArray1[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let tabBar = TabBarViewController()
            self.present(tabBar, animated: true, completion: nil)
        }else if indexPath.row == 1{
            // 测试
            let tabBar = TabBarViewController()
            self.present(tabBar, animated: true, completion: nil)
        }
    }
}

