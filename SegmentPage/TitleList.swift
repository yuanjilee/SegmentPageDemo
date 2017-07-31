//
//  TitleList.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/17.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

/// TitleList View
///
/// 参数: titles
///
/// @since 6.0.0
/// @author yuanjilee
class TitleList: UIScrollView {
  
  //MARK: - Public
  
  var titles: [String] = [] {
    didSet {
      for list in titles {
        _setItemWith(title: list)
      }
      contentSize = CGSize(width: maxWidth, height: bounds.size.height)
    }
  }
  var segmentType: SegmentType = .equal
  var itemButtons: [UIButton] = []
  var listBarItemDidClickClosure:((_ index: Int) -> Void)?
  var bottomLine: UIView

  
  //MARK: - Commons 
  
  var marginBetweenItems: CGFloat = 10
  

  //MARK: - Property
  
  var maxWidth: CGFloat = 10
  var titleFont: CGFloat = 13
  var itemButtonSelected: UIButton?
  
  
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
  
  convenience init(frame: CGRect, segmentType: SegmentType) {
    
    self.init(frame: frame)
    
    self.segmentType = segmentType
    if segmentType == .equal {
      maxWidth = 0
      marginBetweenItems = 0
    } else {
      maxWidth = 10
      marginBetweenItems = 20
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension TitleList {
  
  //MARK: - Public

  open func scrollToCurrentItemWith(index: Int) {
    let button = itemButtons[index]
    _itemButtonDidClick(sender: button)
  }
  
  public func moveToSelectedIndicator(index: Int) {
    let sender = itemButtons[index]
    
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
      if self.segmentType == .equal {
        return
      } else {
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
  }
  
  //MARK: - Private
  
  fileprivate func _setItemWith(title: String) {
    var itemWidth: CGFloat
    if segmentType == .equal {
      itemWidth = bounds.width / CGFloat(titles.count)
    } else {
      itemWidth = _calculateSizeWith(fontSize: titleFont, text: title).width + 20
    }
    let itemButton = UIButton(frame: CGRect(x: maxWidth, y: 0, width: itemWidth, height: bounds.size.height))
    itemButton.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
    itemButton.setTitle(title, for: UIControlState())
    itemButton.setTitleColor(kTextColor, for: .normal)
    itemButton.setTitleColor(kTextColor, for: .highlighted)
    itemButton.setTitleColor(kDefaultBlueColor, for: .selected)
    itemButton.addTarget(self, action: #selector(_itemButtonDidClick(sender:)), for: .touchUpInside)
    addSubview(itemButton)
    itemButtons.append(itemButton)
    maxWidth += (itemWidth + marginBetweenItems)
    contentSize.width = maxWidth
    
    if itemButtonSelected == nil {
      itemButton.setTitleColor(kDefaultBlueColor, for: .normal)
      itemButtonSelected = itemButton
      bottomLine.frame = CGRect(x: itemButton.frame.minX, y: bounds.size.height-2, width: itemButton.frame.width, height: 2)
    }
    
    debugPrint(contentOffset, contentSize)
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
      if self.segmentType == .equal {
        return
      } else {
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
  }
  
  private func _getIndexWithButton(button: UIButton) -> Int {
    let index = itemButtons.index(of: button)
    return index ?? 0
  }
}
