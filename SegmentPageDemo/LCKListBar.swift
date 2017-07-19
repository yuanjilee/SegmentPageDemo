//
//  LCKListBar.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/17.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

/// 头列表
///
/// 参数: lists
///
/// @since 6.0.0
/// @author yuanjilee
class LCKListBar: UIScrollView {
  
  //MARK: - Public
  
  var listBarItemDidClickClosure:((_ index: Int) -> Void)?
  
  
  //MARK: - Commons 
  
  let marginBetweenItems: CGFloat = 10
  

  //MARK: - Property
  
  var maxWidth: CGFloat = 10
  var titleFont: CGFloat = 13
  
  var lists: [String] = [] {
    didSet {
      for list in lists {
        _setItemWith(title: list)
      }
      contentSize = CGSize(width: maxWidth, height: bounds.size.height)
    }
  }
  let bottomLine: UIView
  var itemButtonSelected: UIButton?
  var _buttons: [UIButton] = []
  
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    
    bottomLine = UIView()
    bottomLine.backgroundColor = kDefaultBlueColor
    
    super.init(frame: frame)
    
    showsHorizontalScrollIndicator = false
    backgroundColor = UIColor(R: 238, G: 238, B: 238)
    
    bottomLine.frame = CGRect(x: 0, y: bounds.size.height-2, width: 30, height: 2)
    addSubview(bottomLine)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension LCKListBar {
  
  //MARK: - Public

  open func scrollToCurrentItemWith(index: Int) {
    let button = _buttons[index]
    _itemButtonDidClick(sender: button)
  }
  
  //MARK: - Private
  
  fileprivate func _setItemWith(title: String) {
    let itemWidth = _calculateSizeWith(fontSize: titleFont, text: title).width + 20
    let itemButton = UIButton(frame: CGRect(x: maxWidth, y: 0, width: itemWidth, height: bounds.size.height))
    //itemButton.backgroundColor = .red
    itemButton.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
    itemButton.setTitle(title, for: UIControlState())
    itemButton.setTitleColor(kTextColor, for: .normal)
    itemButton.setTitleColor(kTextColor, for: .highlighted)
    itemButton.setTitleColor(kDefaultBlueColor, for: .selected)
    itemButton.addTarget(self, action: #selector(_itemButtonDidClick(sender:)), for: .touchUpInside)
    addSubview(itemButton)
    _buttons.append(itemButton)
    maxWidth += (itemWidth + marginBetweenItems)
    contentSize.width = maxWidth
    
    if itemButtonSelected == nil {
      itemButton.setTitleColor(kDefaultBlueColor, for: .normal)
      itemButtonSelected = itemButton
      bottomLine.frame = CGRect(x: itemButton.frame.minX, y: bounds.size.height-2, width: itemButton.frame.width, height: 2)
    }
  }
  
  private func _calculateSizeWith(fontSize: CGFloat, text: String) -> CGSize {
    let size: CGSize = (text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:bounds.size.height), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)], context: nil).size
    return size
  }
  
  @objc
  private func _itemButtonDidClick(sender: UIButton) {
    if itemButtonSelected != sender { // switch item selector
      itemButtonSelected?.setTitleColor(kTextColor, for: .normal)
      sender.setTitleColor(kDefaultBlueColor, for: .normal)
      itemButtonSelected = sender
      
      debugPrint(_getIndexWithButton(button: sender))
      // more action with linded tab VC
      listBarItemDidClickClosure?(_getIndexWithButton(button: sender))
    }
    
    // animation during switch action
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
      var frame = self.bottomLine.frame
      frame.origin.x = sender.frame.minX
      frame.size.width = sender.frame.width
      self.bottomLine.frame = frame
    }) { (finished: Bool) in
      // current offset
      var offsetX = sender.center.x - self.bounds.width * 0.5
      if offsetX < 0 {
        offsetX = 0
      }
      // max offset
      let maxOffsetX = self.contentSize.width - self.bounds.width
      if offsetX > maxOffsetX {
        offsetX = maxOffsetX
      }
      self.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
  }
  
  private func _getIndexWithButton(button: UIButton) -> Int {
    let index = _buttons.index(of: button)
    return index ?? 0
  }
}

