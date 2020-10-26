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
  private var resultImage: ResultImage?
  private var presenter: ImageDetailsPresenter?
  private var tapRecognizer: UIGestureRecognizer {
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(recognizer:)))
		recognizer.numberOfTapsRequired = 2
		return recognizer
  }
	
	private var imageView = UIImageView()
	private var scrollView = UIScrollView()
  
  // MARK: - IBOutlets

	@IBOutlet weak var labelViewContainer: UIView!
	@IBOutlet weak var label: UILabel!
	
  // MARK: - IBActions
  
  @IBAction func didPressClose(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
	
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = ImageDetailsPresenter(self)
		
		let vWidth = view.frame.width
		let vHeight = view.frame.height
		
		setupImageView(width: vWidth, height: vHeight)
		setupScrollView(width: vWidth, height: vHeight)
		
    if let id = resultImage?.id {
      showActivityIndicator()
      presenter?.getDetails(id)
    }
  }
  
  // MARK: - Functions
	
	private func setupScrollView(width: CGFloat, height: CGFloat) {
		scrollView.delegate = self
		scrollView.flashScrollIndicators()
		scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
		scrollView.alwaysBounceVertical = false
		scrollView.alwaysBounceHorizontal = false
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 6.0
		scrollView.addGestureRecognizer(tapRecognizer)
		
		view.addSubview(scrollView)
		
		scrollView.addSubview(imageView)
	}
	
	private func setupImageView(width: CGFloat, height: CGFloat) {
		imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
		imageView.clipsToBounds = false
		imageView.contentMode = .scaleAspectFit
		
		// The image comes from previous screen, so we just load it
		if let image = resultImage?.image {
			imageView.image = image
		}
	}
  
  // This one is loaded from SearchViewController
  func setResultImage(_ resultImage: ResultImage?) {
    self.resultImage = resultImage
  }
  
  func updateInformation(_ viewModel: ImageDetailsViewModel) {
    hideActivityIndicator()
		label.attributedText = viewModel.attributedText
		view.bringSubviewToFront(label)
  }
	
	func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
		var zoomRect = CGRect.zero
		zoomRect.size.height = imageView.frame.size.height / scale
		zoomRect.size.width  = imageView.frame.size.width  / scale
		let newCenter = imageView.convert(center, from: scrollView)
		zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
		zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
		return zoomRect
	}
  
	@objc func doubleTap(recognizer: UITapGestureRecognizer) {
		if scrollView.zoomScale == 1 {
			let center = recognizer.location(in: recognizer.view)
			let scale = scrollView.maximumZoomScale
			let zoom = zoomRectForScale(scale: scale, center: center)
			scrollView.zoom(to: zoom, animated: true)
		} else {
			scrollView.setZoomScale(1, animated: true)
		}
  }
	
}

extension ImageDetailsViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
