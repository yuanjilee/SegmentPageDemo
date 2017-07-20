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

class SegmentPageController: UIViewController {
  
  //MARK: - Public
  
  var titles: [String]!
  var childVCs: [UIViewController]!
  var segmentType: SegmentType = .equal
  
  
  //MARK: - Property
  
  var _titleList: TitleList!
  var _scrollView: UIScrollView!
  

  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _setupAppearance()
  }
}

extension SegmentPageController: UIScrollViewDelegate {
  
  //MARK: - UIScrollViewDelegate
  
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    //
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    _listbarScrollToRelatedItemWith(index: index)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
  }
}

extension SegmentPageController {
  
  //MARK: - Appearance
  
  fileprivate func _setupAppearance() {
    
    _setupListBar()
    _setupScrollView()
    _setupContentController(vcs: childVCs)
  }
  
  private func _setupListBar() {
    _titleList = TitleList(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50), segmentType: segmentType)
    _titleList.titles = titles
    _titleList.listBarItemDidClickClosure = { [weak self](index) in
      guard let strongSelf = self else { return }
      strongSelf._scrollviewScrollToRelatedPageWith(index: index)
      strongSelf._addChildControllerToContentWith(index: index)
    }
    //_listBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    view.addSubview(_titleList)
  }
  
  private func _setupScrollView() {
    _scrollView = UIScrollView(frame: CGRect(x: 0, y: _titleList.frame.maxY, width: view.bounds.width, height: view.bounds.height))
    view.addSubview(_scrollView)
    _scrollView.delegate = self
    _scrollView.isPagingEnabled = true
    _scrollView.showsHorizontalScrollIndicator = true
    _scrollView.contentSize.width = view.bounds.width  * CGFloat(titles.count)
    _scrollView.contentOffset = .zero
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
  
  fileprivate func _listbarScrollToRelatedItemWith(index: Int) {
    _titleList.scrollToCurrentItemWith(index: index)
  }
  
  private func _addChildControllerToContentWith(index: Int) {
    let vc = childViewControllers[index]
    _scrollView.addSubview(vc.view)
    vc.view.frame = CGRect(x: _scrollView.bounds.width * CGFloat(index), y: 0, width: _scrollView.frame.width, height: _scrollView.frame.height)
  }
}

