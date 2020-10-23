//
//  ImageProvider.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2020-10-23.
//  Copyright © 2020 Joacim Nidén. All rights reserved.
//

import UIKit

class ImageProvider {
	
	fileprivate let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
	internal var cache = NSCache<NSURL, UIImage>()
	
	func loadImage(from url: URL, completion: @escaping (_ image: UIImage) -> Void) {
		downloadQueue.async {
			guard let image = self.cache.object(forKey: url as NSURL) else {
				self.downloadImage(url: url, completion: completion)
				return
			}
			
			DispatchQueue.main.async {
				completion(image)
			}
		}
	}
	
	private func downloadImage(url: URL, completion: @escaping (_ image: UIImage) -> Void) {
		do{
			let data = try Data(contentsOf: url)

			guard let image = UIImage(data: data) else {
				return
			}
			
			DispatchQueue.main.async {
			   self.cache.setObject(image, forKey: url as NSURL)
			   completion(image)
		   }

	   }catch {
		   print("Could not load URL: \(url): \(error)")
	   }
	}
}
