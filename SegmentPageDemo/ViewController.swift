//
//  ViewController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/17.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  //MARK: - Property
  var _listBar: LCKListBar!
  var _scrollView: UIScrollView!
  var _lists: [String] = ["任务", "日程", "简报", "审批", "请假", "文件", "哈哈哈", "哈哈哈", "哈哈哈哈哈", "哈哈", "哈哈", "哈哈", "哈哈", "哈哈哈"]
  

  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _setupAppearance()
  }
}

extension ViewController: UIScrollViewDelegate {
  
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

extension ViewController {
  
  //MARK: - Appearance
  
  fileprivate func _setupAppearance() {
    
    _setupListBar()
    _setupScrollView()
  }
  
  private func _setupListBar() {
    _listBar = LCKListBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 50))
    _listBar.lists = _lists
    _listBar.listBarItemDidClickClosure = { [weak self](index) in
      guard let strongSelf = self else { return }
      strongSelf._scrollviewScrollToRelatedPageWith(index: index)
    }
    view.addSubview(_listBar)
  }
  
  private func _setupScrollView() {
    _scrollView = UIScrollView(frame: .zero)
    view.addSubview(_scrollView)
    _scrollView.snp.makeConstraints { (make) in
      make.leading.trailing.bottom.equalTo(0)
      make.top.equalTo(_listBar.snp.bottom)
    }
    _scrollView.delegate = self
    _scrollView.isPagingEnabled = true
    _scrollView.showsHorizontalScrollIndicator = true
    _scrollView.contentSize.width = view.bounds.width  * CGFloat(_lists.count)
    _scrollView.contentOffset = .zero
  }
  
  /// Event
  private func _scrollviewScrollToRelatedPageWith(index: Int) {
    let offset = CGPoint(x: view.bounds.width * CGFloat(index), y: _scrollView.frame.origin.y)
    _scrollView.setContentOffset(offset, animated: true)
  }
  
  fileprivate func _listbarScrollToRelatedItemWith(index: Int) {
    _listBar.scrollToCurrentItemWith(index: index)
  }
}

