//
//  String+Extensions.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2020-10-26.
//  Copyright © 2020 Joacim Nidén. All rights reserved.
//

import UIKit

extension String {
	
	func convertHtml() -> NSAttributedString {
		
		guard let data = data(using: .utf8) else {
			return NSAttributedString()
		}
		
		do {

			let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
				.documentType: NSAttributedString.DocumentType.html,
				.characterEncoding: String.Encoding.utf8.rawValue,
			]
			
			let string = try NSMutableAttributedString(data: data,
																								 options: options,
																								 documentAttributes: nil)
			
			let fontOptions: [NSAttributedString.Key: Any] = [
				.foregroundColor: UIColor.white,
				.font: UIFont.systemFont(ofSize: 13)
			]
			
			string.addAttributes(fontOptions,
													 range: NSRange(location: 0, length: string.string.count))
	
			return string
		}catch{
				return NSAttributedString()
		}
	}
}
