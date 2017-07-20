//
//  ContentViewController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/19.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
  
  enum ContentType: Int {
    case one
    case two
    case three
  }
  
  var contentType: ContentType = .one
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    view.backgroundColor = UIColor.randomColor()
    debugPrint("ContentViewController init")
    
    switch contentType {
    case .one:
      view.backgroundColor = .yellow
      break
    case .two:
      view.backgroundColor = .green
    case .three:
      view.backgroundColor = .red
      break
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
