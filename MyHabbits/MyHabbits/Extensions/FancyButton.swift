//
//  FancyButton.swift
//  FancyButtons
//
//  Created by Ульяна Цимбалистая on 01.02.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

// Кастомные атрибуты для кнопочек
@IBDesignable
class FancyButton: UIButton {
    // Радиус углов
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // Ширина границы
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    // Цвет границы
    @IBInspectable var borderColor: UIColor = .black{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // Расстояние надписи от границ кнопки
    
    @IBInspectable var titleLeftPadding : CGFloat = 0.0{
        didSet{
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    
    @IBInspectable var titleTopPadding : CGFloat = 0.0{
        didSet{
            titleEdgeInsets.top = titleTopPadding
        }
    }
    
    @IBInspectable var titleRightPadding : CGFloat = 0.0{
        didSet{
            titleEdgeInsets.right = titleRightPadding
        }
    }
    
    @IBInspectable var titleBottomPadding : CGFloat = 0.0{
        didSet{
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    
    // Расстояние от картинки до границы

    @IBInspectable var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    
    @IBInspectable var imageTopPadding: CGFloat = 0.0 {
           didSet {
               imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    
    @IBInspectable var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
    
    // Градиент
    @IBInspectable var enableGradientBackground: Bool = false
    @IBInspectable var gradientColor1: UIColor = UIColor.black
    @IBInspectable var gradientColor2: UIColor = UIColor.white
    
    @IBInspectable var enableImageRightAligned: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if enableImageRightAligned,
            let imageView = imageView {
                imageEdgeInsets.left = self.bounds.width - imageView.bounds.width - imageRightPadding
            }
        
        if enableGradientBackground {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
