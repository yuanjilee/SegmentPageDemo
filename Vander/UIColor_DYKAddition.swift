//
//  UIColor_DYKAddition.swift
//  Worktile_iPhone
//
//  Created by Frank Lin on 11/2/15.
//  Copyright © 2015 Frank Lin. All rights reserved.
//

import UIKit

extension UIColor {
  
  //MARK: - Hex
  
  public convenience init(hexRGB: Int) {
    self.init(red:CGFloat((hexRGB >> 16) & 0xff) / 255.0,
      green:CGFloat((hexRGB >> 8) & 0xff) / 255.0,
      blue:CGFloat(hexRGB & 0xff) / 255.0,
      alpha: 1.0)
  }
  
  public func colorImage() -> UIImage? {
    let rect = CGRect.init(x: 0, y: 0, width: 1, height: 0.5)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(self.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  
  //MARK: - RGB
  
  public convenience init(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat=1) {
    self.init(red: R/255, green: G/255, blue: B/255, alpha: A)
  }
  
  //MARK: - Random
  class func randomColor() -> UIColor {
    return UIColor(R: CGFloat(arc4random_uniform(256)), G: CGFloat(arc4random_uniform(256)), B: CGFloat(arc4random_uniform(256)))
  }
}
