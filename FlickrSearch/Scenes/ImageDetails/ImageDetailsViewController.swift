//
//  ImageDetailsViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {
  
  // MARK: - Vars
  var image: UIImage?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var infoWrapperView: UIView!
  @IBOutlet weak var infoLabel: UILabel! 

  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    imageView.image = image
  }
  
  func setImage(_ image: UIImage?) {
    self.image = image
  }
}
