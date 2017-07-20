//
//  SegmentPageController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/17.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit
import SnapKit

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
  
  var _listBar: TitleList!
  var _scrollView: UIScrollView!
  var _lists: [String] = ["任务", "日程", "简报", "审批", "请假", "文件", "哈哈哈", "哈哈哈", "哈哈哈哈哈", "哈哈", "哈哈", "哈哈", "哈哈", "哈哈哈"]
  

  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _lists = titles
    
    
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
    _listBar = TitleList(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50), segmentType: segmentType)
    _listBar.lists = _lists
    _listBar.listBarItemDidClickClosure = { [weak self](index) in
      guard let strongSelf = self else { return }
      strongSelf._scrollviewScrollToRelatedPageWith(index: index)
      strongSelf._addChildControllerToContentWith(index: index)
    }
    //_listBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    view.addSubview(_listBar)
  }
  
  private func _setupScrollView() {
    _scrollView = UIScrollView(frame: CGRect(x: 0, y: _listBar.frame.maxY, width: view.bounds.width, height: view.bounds.height))
    view.addSubview(_scrollView)
    _scrollView.delegate = self
    _scrollView.isPagingEnabled = true
    _scrollView.showsHorizontalScrollIndicator = true
    _scrollView.contentSize.width = view.bounds.width  * CGFloat(_lists.count)
    _scrollView.contentOffset = .zero
  }
  
  private func _setupContentController(vcs: [UIViewController]) {
    for vc in vcs {
      addChildViewController(vc)
    }
    _addChildControllerToContentWith(index: 0)
  }
  
  // Event
  private func _scrollviewScrollToRelatedPageWith(index: Int) {
    var offset = _scrollView.contentOffset
    offset.x = view.bounds.width * CGFloat(index)
    _scrollView.contentOffset = offset
  }
  
  fileprivate func _listbarScrollToRelatedItemWith(index: Int) {
    _listBar.scrollToCurrentItemWith(index: index)
  }
  
  private func _addChildControllerToContentWith(index: Int) {
    let vc = childViewControllers[index]
    _scrollView.addSubview(vc.view)
    vc.view.frame = CGRect(x: _scrollView.bounds.width * CGFloat(index), y: 0, width: _scrollView.frame.width, height: _scrollView.frame.height)
  }
}

