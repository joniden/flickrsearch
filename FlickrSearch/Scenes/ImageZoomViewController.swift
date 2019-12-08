//
//  ImageZoomViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {
  
  var image: UIImage?
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageView: UIImageView!

  @IBAction func didPressClose(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 6.0
    
    imageView.image = image
    
  }

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return imageView
  }
}
