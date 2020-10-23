//
//  ImageDetailsViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class ImageDetailsViewController: BaseViewController {
  
  // MARK: - Vars
  var resultImage: ResultImage?
  private var presenter: ImageDetailsPresenter?
  private var gestureRecognizer: UIGestureRecognizer {
    return UITapGestureRecognizer(target: self, action: #selector(didTapImage))
  }
  
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
    
    if let id = resultImage?.id {
      showActivityIndicator()
      presenter?.getDetails(id)
    }
    
    imageView.addGestureRecognizer(gestureRecognizer)
    
    // The image comes from previous screen, so we just load id
    /*if let data = resultImage?.data {
      imageView.image = UIImage(data: data)
    }*/
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let vc = segue.destination as? ImageZoomViewController else {
      return
    }
    
    vc.image = imageView.image
  }
  
  // MARK: - Functions
  
  // This one is loaded from SearchViewController
  func setResultImage(_ resultImage: ResultImage?) {
    self.resultImage = resultImage
  }
  
  func updateInformation(_ viewModel: ImageDetailsViewModel) {
    hideActivityIndicator()
    modalNavigationItem.title = viewModel.title
    infoLabel.attributedText = viewModel.attributedText
  }
  
  @objc func didTapImage() {
    performSegue(withIdentifier: "showZoom", sender: self)
  }
}
