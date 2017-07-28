//
//  SegmentPageController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/17.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit
import SnapKit

/// To show titleList and segment content viewcontrollers
///
/// @params titles: (required) as titleList datasource
///         childVCs: (required) as segment conetent viewcontrollers
///         segmentType: (optional) default equal type
///
/// @since 6.0.0
/// @author yuanjilee
enum SegmentType: Int {
  case equal
  case slide
}

open class SegmentPageController: UIViewController {
  
  //MARK: - Enum
  
  enum ScrollDirection: Int {
    case left
    case right
    case other
  }
  
  //MARK: - Public
  
  var titles: [String]!
  var childVCs: [UIViewController]!
  var segmentType: SegmentType = .equal
  
  
  //MARK: - Property
  
  var _titleList: TitleList!
  var _scrollView: UIScrollView!
  var _currentPageIndex: Int = 0
  var _startPageIndex: Int = 0
  var _endPageIndex: Int = 0

  //MARK: - Lifecycle
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    _setupAppearance()
  }

  
  open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    let currentPage = Int(_scrollView.contentOffset.x / _scrollView.bounds.width)
    
    // PageScrollView
    _scrollView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height-50)
    _scrollView.contentSize = CGSize(width: _scrollView.frame.width * CGFloat(titles.count), height: _scrollView.frame.height)
    
    for (index,view) in _scrollView.subviews.enumerated() {
      let frame = CGRect(x: size.width * CGFloat(index), y: 0, width: _scrollView.frame.width, height: _scrollView.frame.height)
      view.frame = frame
    }
    _scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * _scrollView.frame.width, y: 0), animated: false)
    
    // TitleListScrollView
    _titleList.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height-50)
    _titleList.contentSize = CGSize(width: _titleList.frame.width * CGFloat(titles.count), height: _titleList.frame.height)
    
    let itemWidth = size.width / CGFloat(titles.count)
    for (index, item) in _titleList.itemButtons.enumerated() {
      item.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: 50)
    }
    
    _titleList.bottomLine.frame.origin.x = CGFloat(_currentPageIndex) * itemWidth
    _titleList.bottomLine.frame.size.width = itemWidth
    
  }
  
  
}

extension SegmentPageController {
  
  //MARK: - Appearance
  
  fileprivate func _setupAppearance() {
    
    _setupListBar()
    _setupScrollView()
    //_setupContentController(vcs: childVCs)
    _addChildControllerToContentWith(index: 0)
  }
  
  private func _setupListBar() {
    _titleList = TitleList(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), segmentType: segmentType)
    view.addSubview(_titleList)
    _titleList.snp.remakeConstraints { (make) in
      make.leading.trailing.equalTo(0)
      make.top.equalTo(topLayoutGuide.snp.bottom)
      make.height.equalTo(50)
    }
    _titleList.titles = titles
    _titleList.listBarItemDidClickClosure = { [weak self](index) in
      guard let strongSelf = self else { return }
      strongSelf._scrollviewScrollToRelatedPageWith(index: index)
      strongSelf._addChildControllerToContentWith(index: index)
    }
  }
  
  private func _setupScrollView() {
    _scrollView = UIScrollView()
    view.addSubview(_scrollView)
    _scrollView.backgroundColor = .yellow
    _scrollView.snp.makeConstraints { (make) in
      make.leading.trailing.bottom.equalTo(0)
      make.top.equalTo(_titleList.snp.bottom)
    }
    _scrollView.layoutIfNeeded()
    _scrollView.delegate = self
    _scrollView.isPagingEnabled = true
    _scrollView.showsHorizontalScrollIndicator = false
    _scrollView.showsVerticalScrollIndicator = false
    _scrollView.contentSize = CGSize(width: _scrollView.bounds.width * CGFloat(titles.count), height: _scrollView.bounds.height)

  }
  
  private func _setupContentController(vcs: [UIViewController]) {
    for vc in vcs {
      addChildViewController(vc)
    }
    _addChildControllerToContentWith(index: 0)
  }
  
  
  //MARK: - Event
  private func _scrollviewScrollToRelatedPageWith(index: Int) {
    var offset = _scrollView.contentOffset
    offset.x = view.bounds.width * CGFloat(index)
    _scrollView.contentOffset = offset
  }
  
  func _listbarScrollToRelatedItemWith(index: Int) {
    _titleList.scrollToCurrentItemWith(index: index)
  }
  
  func _moveToSelectedIndicator(index: Int) {
    _titleList.moveToSelectedIndicator(index: index)
  }
  
  func _addChildControllerToContentWith(index: Int) {
    let vc = childVCs[index]
    
    if vc.parent != nil {
      return
    }
    
    vc.willMove(toParentViewController: self)
    addChildViewController(vc)
    vc.view.frame = CGRect(x: self.view.frame.width * CGFloat(index), y: 0, width: self.view.frame.width, height: self.view.frame.height-50)
    _scrollView.addSubview(vc.view)
    vc.view.tag = index
    vc.didMove(toParentViewController: self)
  }
}

