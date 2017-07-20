//
//  EqualViewController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/19.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

class EqualViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = .white
    let titles = ["任务", "日程", "简报"]
    
    var vcs: [UIViewController] = []
    for i in 0..<titles.count {
      let vc = ContentViewController()
      vc.contentType = ContentViewController.ContentType(rawValue: i)!
      vcs.append(vc)
    }
    
    let segmentVC = SegmentPageController()
    segmentVC.titles = titles
    segmentVC.childVCs  =  vcs
    addChildViewController(segmentVC)
    view.addSubview(segmentVC.view)
    segmentVC.view.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height)
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
