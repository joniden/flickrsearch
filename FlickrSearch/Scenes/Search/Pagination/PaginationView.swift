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
  
  var didPressNext: (() -> ())?
  var didPressBack: (() -> ())?
  
  var identifier: String {
    return String(describing: type(of: self))
  }
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var paginationInfo: UILabel!
  @IBOutlet weak var contentView: UIView!
  
  // MARK: - IBActions
  
  @IBAction func didPressBack(_ sender: UIButton) {
    didPressBack?()
  }
  
  @IBAction func didPressNext(_ sender: UIButton) {
    didPressNext?()
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
    paginationInfo.text = "\(currentPage)/\(totalPages)"
  }

}
