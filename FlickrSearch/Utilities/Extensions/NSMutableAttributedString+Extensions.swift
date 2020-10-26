//
//  NSMutableAttributedString+Extensions.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
  
  func addTitle(_ title: String) {
    let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
    let string = NSAttributedString(string: title + "\n", attributes: boldAttribute)
    self.append(string)
  }
  
  func addBody(_ body: String = "") {

		if body == "" {
			let string = NSAttributedString(string: "\n\n")
			self.append(string)
		} else {
			let htmlString = body.convertHtml()
			self.append(htmlString)
		}
  }
	

}
