//
//  LaunchViewController.swift
//  SegmentPageDemo
//
//  Created by yuanjilee on 2017/7/19.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
  
  
  @IBOutlet weak var _tableview: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    automaticallyAdjustsScrollViewInsets = false
    _tableview.dataSource = self
    _tableview.delegate = self
    
    // Do any additional setup after loading the view.
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

extension LaunchViewController: UITableViewDataSource, UITableViewDelegate {
  
  //MARK: - UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let titles = ["Equal", "Slide"]
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = titles[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  
  //MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if indexPath.row == 0 {
      let equalVC = EqualViewController()
      equalVC.title = "Equal"
      navigationController?.pushViewController(equalVC, animated: true)
    } else {
      let slideVC = SlideViewController()
      slideVC.title = "Slide"
      navigationController?.pushViewController(slideVC, animated: true)
    }
  }
}
