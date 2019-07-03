//
//  TaoBaoCustomTabBar.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/6/28.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

// 声明一个协议clcikDelegate，需要继承NSObjectProtocol
protocol TaoBaoCustomTabBarDelegate: NSObjectProtocol {
    func tabBarDidClickPlusButton(tabBar:TaoBaoCustomTabBar)
}

class TaoBaoCustomTabBar: UITabBar {
    // 声明代理
    weak var myDelegate: TaoBaoCustomTabBarDelegate?
    
    // 懒加载中间的按钮
    lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setImage(UIImage.init(named: "taobao"), for: .normal)
        plusButton.setImage(UIImage.init(named: "taobao"), for: .highlighted)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        plusButton.setTitle("", for: .normal)

        plusButton.frame = CGRect.init(x: 0, y: 0, width: plusButton.imageView!.image!.size.width, height: plusButton.imageView!.image!.size.height + 40)
        plusButton.addTarget(self, action: #selector(TaoBaoCustomTabBar.respondsToPlusButton), for: .touchUpInside)
        return plusButton
    }()

    // MARK: - TaoBaoCustomTabBarDelegate
    @objc func respondsToPlusButton(){
        //和oc不一样的是，Swift中如果简单的调用代理方法, 不用判断代理能否响应
        if myDelegate != nil{
            myDelegate?.tabBarDidClickPlusButton(tabBar: self)
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
        
        // 设置淘宝按钮的位置
        let w = self.frame.width / 5
        let index = 0
        for childView:UIView in self.subviews {
            if childView.isKind(of: NSClassFromString("UITabBarButton")!){

                if index == 0 {
                    var isIphoneX:Bool = false
                    let zeroNum:CGFloat = 0
                    // 判断是否是刘海屏
                    if #available(iOS 11.0, *) {
                        isIphoneX = UIApplication.shared.keyWindow!.safeAreaInsets.bottom > zeroNum
                    }
                    
                    if isIphoneX {
                        self.plusButton.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height - 34)
                    }else{
                        self.plusButton.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height )
                    }
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
