//
//  BaseViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  let activityIndicatorView = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addActivityView()
  }
  
  func addActivityView() {

    // Add constraints to activityIndicator
    view.addSubview(activityIndicatorView)
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    activityIndicatorView.hidesWhenStopped = true
  }
  
  func showActivityIndicator() {
    activityIndicatorView.startAnimating()
  }
  
  func hideActivityIndicator() {
    activityIndicatorView.stopAnimating()
  }
  
}
