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

extension ViewController {
  
  //MARK: - Appearance
  
  fileprivate func _setupAppearance() {
    
    _setupListBar()
    _setupScrollView()
  }
  
  private func _setupListBar() {
    _listBar = LCKListBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 50))
    _listBar.lists = _lists
    view.addSubview(_listBar)
  }
  
  private func _setupScrollView() {
    _scrollView = UIScrollView(frame: .zero)
    view.addSubview(_scrollView)
    _scrollView.snp.makeConstraints { (make) in
      make.leading.trailing.bottom.equalTo(0)
      make.top.equalTo(_listBar.snp.bottom)
    }

    //_scrollView.backgroundColor = .red
    _scrollView.isPagingEnabled = true
    _scrollView.showsHorizontalScrollIndicator = true
    _scrollView.contentSize.width = view.bounds.width  * CGFloat(_lists.count)
  }
}

