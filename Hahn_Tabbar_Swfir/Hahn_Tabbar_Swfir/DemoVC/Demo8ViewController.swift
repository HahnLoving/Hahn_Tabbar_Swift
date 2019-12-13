//
//  Demo8ViewController.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/12/13.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

class Demo8ViewController: SuperViewController
{

    private var tableView: UITableView!
    private var array: NSMutableArray! = NSMutableArray()
    private var oldOffset:CGFloat!
    
    
    deinit {
        self.removeObserver(self, forKeyPath: "isSliding", context: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 设置KVO、观察者
        self.addObserver(self, forKeyPath: "isSliding", options: .new, context: nil)
        
        for i in 0..<100 {
            self.array.add(i)
        }
        
        tableView = UITableView(frame: self.view.bounds, style: .plain);
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }

}

extension Demo8ViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        self.oldOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        // 向下
        if scrollView.contentOffset.y > self.oldOffset {
            
            let number:NSNumber = 0
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "isSliding"), object: number)
            
        }
        // 向上
        else
        {
            let number:NSNumber = 1
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "isSliding"), object: number)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = "No." + String(indexPath.row) + "  (点击返回)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
}
