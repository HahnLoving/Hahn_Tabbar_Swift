//
//  UITabBar+HahnBadge.swift
//  Hahn_Tabbar_Swfir
//
//  Created by Hahn on 2019/12/2.
//  Copyright © 2019 Hahn. All rights reserved.
//

import UIKit

extension UITabBar {
    /**
     tabbar  tag
     */
    private var badgeTag:Int! {
        get{
            return 1000
        }
        set{
            
        }
    }
    
    /**
    运行时对应的key值
    */
    private struct AssociatedKeys {
        static var kBadgeSize:String! = "kBadgeSize"
        static var kBadgeColor:String! = "kBadgeColor"
        static var kBadgeImage:String! = "kBadgeImage"
        static var kBadgePoint:String! = "kBadgePoint"
        static var kBadgeValue:String! = "kBadgeValue"
    }
    
    
    /**
    运行时注释
    objc_setAssociatedObject 相当于 setValue:forKey 进行关联value对象

    objc_getAssociatedObject 用来读取对象

    objc_AssociationPolicy  属性 是设定该value在object内的属性，即 assgin, (retain,nonatomic)...等

     objc_removeAssociatedObjects 函数来移除一个关联对象，或者使用objc_setAssociatedObject函数将key指定的关联对象设置为nil。
    
    key：要保证全局唯一，key与关联的对象是一一对应关系。必须全局唯一。通常用@selector(methodName)作为key。
    value：要关联的对象。
    policy：关联策略。有五种关联策略。
    OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
    OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
    OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
    OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
    OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
    
    */
    
    
    // 小红点size
    public var badgeSize:CGSize! {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kBadgeSize) as? CGSize
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kBadgeSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 小红点图片
    public var badgeImage:UIImage! {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kBadgeImage) as? UIImage
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kBadgeImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 小红点颜色
    public var badgeColor:UIColor! {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kBadgeColor) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kBadgeColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 小红点的x、y值
    public var badgePoint:CGPoint! {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kBadgePoint) as? CGPoint
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kBadgePoint, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 小红点的数字
    public var badgeValue:String! {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kBadgeValue) as? String
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kBadgeValue, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK:-显示小红点
    public func showBadgeOnItemIndex(index:Int){
        // 移除
        self.removeRedPointOnIndex(index: index, animation: false)
        
        // 防止是空的
        if self.badgeColor == nil {
            self.badgeColor = UIColor()
            self.badgeColor = UIColor.red
        }
        
        if self.badgePoint == nil {
            self.badgePoint = CGPoint()
            self.badgePoint = CGPoint.zero
        }
        
        if self.badgeSize == nil {
            self.badgeSize = CGSize.zero
        }
        
        if self.badgeImage == nil {
            self.badgeImage = UIImage()
        }
        
        if self.badgeValue == nil {
            self.badgeValue = String()
        }
        
        // 小红点背景默认值大小设置
        if __CGSizeEqualToSize(self.badgeSize, CGSize.zero) {
            self.badgeSize = CGSize(width: 12, height: 12)
        }
        
        
        let badgeView = UIView()
        badgeView.backgroundColor = self.badgeColor
        badgeView.layer.cornerRadius = self.badgeSize.width / 2
        badgeView.tag = badgeTag + 1
        
        let barButtonView = self.getBarButttonViewWithIndex(index: index)
        //（图片的imageView）
        var iconView = UIView()
        for swappableImageView in barButtonView.subviews {
            
            if swappableImageView.isKind(of: UIImageView.self) {
                iconView = swappableImageView
                break
            }
            
        }
        
        // 小红点背景默认值Point设置
        if __CGPointEqualToPoint(self.badgePoint, CGPoint.zero) {
            let iconViewSize = iconView.frame.size
            badgeView.frame = CGRect(x: iconViewSize.width - self.badgeSize.width / 2, y: -self.badgeSize.width / 2, width: self.badgeSize.width, height: self.badgeSize.height)
        }else{
            badgeView.frame = CGRect(x: self.badgePoint.x, y: self.badgePoint.y, width: self.badgeSize.width, height: self.badgeSize.height)
        }
        
        // 添加图片到小红点上
        let imageview = UIImageView(frame: badgeView.bounds)
        imageview.image = self.badgeImage
        if self.badgeImage != nil {
            self.backgroundColor = UIColor.red
        }
        badgeView.addSubview(imageview)
        
        if self.badgeValue != nil {
            let badgeLabel = UILabel(frame: badgeView.bounds)
            badgeLabel.text = self.badgeValue
            badgeLabel.textAlignment = .center
            badgeLabel.font = UIFont.systemFont(ofSize: 13)
            badgeLabel.textColor = UIColor.white
            badgeView.addSubview(badgeLabel)
        }
        
        iconView.addSubview(badgeView)
    }
    
    // MARK:-隐藏小红点
    public func hiddenRedPointOnIndex(index:Int, animation:Bool){
        self.removeRedPointOnIndex(index: index, animation: animation)
    }
    
    private func removeRedPointOnIndex(index:Int, animation:Bool) {
        let barButtonView = self.getBarButttonViewWithIndex(index: index)
        
        for swapView in barButtonView.subviews {
            
            if swapView.isKind(of: UIImageView.self) {
                
                for view1 in swapView.subviews {
                    
                    if view1.tag == (badgeTag + 1) {
                        
                        if animation {
                            UIView.animate(withDuration: 0.2, animations: {
                                view1.transform = CGAffineTransform(translationX: 2, y: 2)
                                view1.alpha = 0
                            }) { (finished) in
                                view1.removeFromSuperview()
                            }
                        }else{
                            view1.removeFromSuperview()
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // 获取barButtonView
    private func getBarButttonViewWithIndex(index:Int) -> UIView {

        if let itemss = self.items {
            let item = itemss[index]
            let barButtonView = item.value(forKey: "view")
            return barButtonView as! UIView
        }
        
        let vw = UIView()
        return vw
    }
    
}
