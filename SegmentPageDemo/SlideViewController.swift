//
//  SlideViewController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/19.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .white
      
      let titles = ["任务", "日程", "简报", "审批", "请假", "文件", "哈哈哈", "哈哈哈", "哈哈哈哈哈", "哈哈", "哈哈", "哈哈", "哈哈", "哈哈哈"]
      
      var vcs: [UIViewController] = []
      for _ in 0..<titles.count {
        let vc = ContentViewController()
        vcs.append(vc)
      }
      
      let segmentVC = SegmentPageController()
      segmentVC.titles = titles
      segmentVC.childVCs  =  vcs
      segmentVC.segmentType = .slide
      //addChildViewController(segmentVC)
      view.addSubview(segmentVC.view)
      segmentVC.view.snp.makeConstraints { (make) in
        make.leading.trailing.bottom.equalTo(0)
        make.top.equalTo(64)
      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}