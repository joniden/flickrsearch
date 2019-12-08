//
//  PaginationView.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class PaginationView: UIView {
  
  // MARK: - Vars
  
  var didPressNext: ((Int) -> ())?
  var didPressBack: ((Int) -> ())?
  
  var identifier: String {
    return String(describing: type(of: self))
  }
  
  private var currentPage = 0 {
    didSet {
      backButton.isEnabled = currentPage > 1
    }
  }
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var paginationInfo: UILabel!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var backButton: UIButton!
  
  // MARK: - IBActions
  
  @IBAction func didPressBack(_ sender: UIButton) {
    if currentPage > 0 {
      let prevPage = currentPage - 1
      didPressBack?(prevPage)
    }
  }
  
  @IBAction func didPressNext(_ sender: UIButton) {
    let nextPage: Int = currentPage + 1
    didPressNext?(nextPage)
  }
  
  // MARK: - Life cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: - Private func
  
  private func setup() {
    Bundle.main.loadNibNamed(identifier, owner:self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  func setCurrentInfo(currentPage: Int, totalPages: Int) {
    self.currentPage = currentPage
    paginationInfo.text = "\(currentPage)/\(totalPages)"
  }

}
