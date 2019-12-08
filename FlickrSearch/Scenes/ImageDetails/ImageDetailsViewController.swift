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
  var resultImage: ResultImage?
  private var presenter: ImageDetailsPresenter?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var infoWrapperView: UIView!
  @IBOutlet weak var infoLabel: UILabel! 
  @IBOutlet weak var modalNavigationItem: UINavigationItem!
  
  // MARK: - IBActions
  
  @IBAction func didPressClose(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = ImageDetailsPresenter(self)
    
    if let id = resultImage?.imageId {
      presenter?.getDetails(id)
    }
    
    // The image comes from previous screen, so we just load id
    if let data = resultImage?.imageData {
      imageView.image = UIImage(data: data)
    }
  }
  
  // This one is loaded from SearchViewController
  func setResultImage(_ resultImage: ResultImage?) {
    self.resultImage = resultImage
  }
  
  func updateInformation(_ viewModel: ImageDetailsViewModel) {
    modalNavigationItem.title = viewModel.title
    infoLabel.attributedText = viewModel.attributedText
  }
  
  // MARK: - Alert
  
  func showAlert(_ string: String) {
    print(string)
  }
}
