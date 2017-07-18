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

  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _setupAppearance()
  }


}

extension ViewController {
  
  //MARK: - Appearance
  
  fileprivate func _setupAppearance() {
    let listBar = LCKListBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 50))
    listBar.lists = ["任务", "日程", "简报", "审批", "请假", "文件", "哈哈哈", "哈哈哈", "哈哈哈哈哈", "哈哈", "哈哈", "哈哈", "哈哈", "哈哈哈"]
    view.addSubview(listBar)
  }
}

