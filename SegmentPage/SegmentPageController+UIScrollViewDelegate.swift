//
//  SegmentPageController+UIScrollViewDelegate.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/26.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

extension SegmentPageController: UIScrollViewDelegate {

  //MARK: - UIScrollViewDelegate
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    var newScrollDirection: ScrollDirection = .other
    if (CGFloat(_startPageIndex) * scrollView.bounds.width > scrollView.contentOffset.x) {
      newScrollDirection = .right
    } else if (CGFloat(_startPageIndex) * scrollView.bounds.width < scrollView.contentOffset.x) {
      newScrollDirection = .left
    }
    
    if newScrollDirection != .other {
      let index : Int = newScrollDirection == .left ? _currentPageIndex + 1 : _currentPageIndex - 1
      if index >= 0 && index < childVCs.count {
        _addChildControllerToContentWith(index: index)
      }
    }
  }
  
  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    //
  }
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    _currentPageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    _startPageIndex = _currentPageIndex
    
    _moveToSelectedIndicator(index: _currentPageIndex)
  }
  
}
