//
//  CustomTabBar.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/28.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

// 声明一个协议clcikDelegate，需要继承NSObjectProtocol
protocol CustomTabBarDelegate: NSObjectProtocol {
    func tabBarDidClickPlusButton()
}

// 定义一个闭包类型(block)
typealias dateBlock = (String)->()
typealias dictBlock = (NSMutableDictionary)->()

class CustomTabBar: UITabBar {
    // 声明代理
    weak var myDelegate: CustomTabBarDelegate?
    // 声明一个block变量
    var datePickBlock: dateBlock?
    var dictDataBlock: dictBlock?
    
    // 懒加载中间的按钮
    lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setImage(UIImage.init(named: "post_normal"), for: .normal)
        plusButton.setImage(UIImage.init(named: "post_normal"), for: .highlighted)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        plusButton.setTitle("发布", for: .normal)
        plusButton.setTitleColor(UIColor.gray, for: .normal)
//        plusButton.setTitleColor(UIColor.init(red: 255.0/255, green: 204.0/255, blue: 13.0/255, alpha: 1), for: .selected)
        
        let buttonImg: UIImage? = plusButton.image(for: .normal)
        // 暂时没有找到计算字符串长度的方法
//        var titleWidth: CGFloat? = NSString(string: plusButton.titleLabel?.text).size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)]).width
        let titleWidth = self
        plusButton.titleEdgeInsets = UIEdgeInsets.init(top: buttonImg!.size.height, left: -buttonImg!.size.height, bottom: -15, right: 0)
        plusButton.imageEdgeInsets = UIEdgeInsets.init(top: -15, left: 0, bottom: 0, right: -20)

        
        plusButton.frame = CGRect.init(x: 0, y: 0, width: plusButton.imageView!.image!.size.width, height: plusButton.imageView!.image!.size.height + 40)
        plusButton.addTarget(self, action: #selector(CustomTabBar.respondsToPlusButton), for: .touchUpInside)
        return plusButton
    }()

    // MARK: - CustomTabBarDelegate
    @objc func respondsToPlusButton(){
        //和oc不一样的是，Swift中如果简单的调用代理方法, 不用判断代理能否响应
        if myDelegate != nil{
            myDelegate?.tabBarDidClickPlusButton()
        }
    }
 
    // MARK: - 重写父类方法必须写
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 添加按钮
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.plusButton)
    }
    
    // MARK: - 重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // block 传递
        var dict:NSMutableDictionary!
        dict = [
            "name":"hzl"
        ]
        if self.datePickBlock != nil {
            self.datePickBlock!("参数")
        }
        if self.dictDataBlock != nil {
            self.dictDataBlock!(dict)
        }
        
        // 设置中间的按钮的位置
        let x = self.frame.width * 0.5
        let y = self.frame.height * 0.1
        self.plusButton.center = CGPoint.init(x: x, y: y)
        
//        let w = self.frame.width / 5
        let w = self.frame.width / 3
        var index = 0
        for childView:UIView in self.subviews {
            if childView.isKind(of: NSClassFromString("UITabBarButton")!){
                
                var isIphoneX:Bool = false
                let zeroNum:CGFloat = 0
                // 判断是否是刘海屏
                if #available(iOS 11.0, *) {
                    isIphoneX = UIApplication.shared.keyWindow!.safeAreaInsets.bottom > zeroNum
                }
                
                if isIphoneX {
                    childView.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height - 34)
                }else{
                    childView.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height )
                }
                

                index+=1
//                if index == 2{
//                    index+=1
//                }
                
                if index == 1{
                    index+=1
                }

            }
        }
    }
    
    // MARK: - 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.plusButton)
            /// 判断新的点是否在按钮上
            if self.plusButton.point(inside: onButton, with: event){
                return plusButton
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
    
}
