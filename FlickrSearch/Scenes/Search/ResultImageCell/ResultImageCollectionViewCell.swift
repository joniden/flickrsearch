//
//  ResultImageCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class ResultImageCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Vars
  
  var resultImage: ResultImage?
  let cache = NSCache<NSString, AnyObject>()
  
  static var identifier: String {
    return String(describing: self)
  }
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView?
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView?.contentMode = .scaleAspectFill
    activityIndicatorView.hidesWhenStopped = true
    activityIndicatorView.startAnimating()
  }
  
  func setup(_ resultImage: ResultImage) {
    self.resultImage = resultImage
    getImage()
  }
  
  private func getImage() {
    
    guard let urlString = self.resultImage?.url, let url = URL(string: urlString) else {
      activityIndicatorView.stopAnimating()
      return // No url
    }
    
    // If cache exists, use the cache
    if let cachedImage = cache.object(forKey: url.absoluteString as NSString) as? UIImage {
      self.imageView?.image = cachedImage
      activityIndicatorView.stopAnimating()
    } else {
      DispatchQueue.global(qos: .background).async {
        
        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {          
          DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
          }
          return
        }
       
        // Save cache
        self.cache.setObject(image, forKey: url.absoluteString as NSString)
      
        DispatchQueue.main.async {
          self.imageView?.image = image
          self.resultImage?.data = data
          self.activityIndicatorView.stopAnimating()
        }
      }
    }
  }
  
}
