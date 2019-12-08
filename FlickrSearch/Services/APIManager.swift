//
//  APIManager.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

typealias DataCallback = ((Result<Data, Error>) -> Void)
typealias PhotosCallback = ((Result<ResponsePhotosAPIModel, Error>) -> Void)
typealias PhotoDetailCallback = ((Result<PhotoDetailAPIModel?, Error>) -> Void)

enum APIError: Error {
  case invalidUrl
}

class APIManager {
  
  // MARK: - Vars
  
  static let shared = APIManager()
  
  private let allowedDiskSize = 100 * 1024 * 1024
  private lazy var cache: URLCache = {
      return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "requestCache")
  }()
  
  // To handle the cache, have a custom urlSession
  private var urlSession: URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    configuration.timeoutIntervalForResource = 30
    configuration.urlCache = cache
    return URLSession(configuration: configuration)
  }
  
  // MARK: - Life cycle
  
  private init() { }
  
  // MARK: - Func
  
  func search(string: String, page: Int, callback: PhotosCallback?) {
    
    request(.search(string, page)) { result in
      
      switch result {
      case .success(let data):
        do {
          let photos = try JSONDecoder().decode(ResponsePhotosAPIModel.self, from: data)
          callback?(Result.success(photos))
        } catch let error {
          callback?(Result.failure(error))
        }
      case .failure(let error):
        callback?(Result.failure(error))
      }
    }
  }
  
  func details(_ photoId: String, callback: PhotoDetailCallback?) {
    request(.info(photoId)) { result in
      switch result {
      case .success(let data):
        do {
          let info = try JSONDecoder().decode(ResponsePhotoInfoAPIModel.self, from: data)
          callback?(Result.success(info.photo))
        } catch let error {
           callback?(Result.failure(error))
        }
      case .failure(let error):
        callback?(Result.failure(error))
      }
    }
  }
  
  // MARK: - Private func
  
  private func request(_ route: FlickrSettings.Route, callback: DataCallback?) {
    
    DispatchQueue.global(qos: .background).async {
      guard let url = URL(string: route.url) else {
        callback?(Result.failure(APIError.invalidUrl))
        return
      }
      
      let request = URLRequest(url: url)
      
      if let cachedData = self.cache.cachedResponse(for: request) {
        callback?(.success(cachedData.data))
      } else {
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
          if let error = error {
            callback?(Result.failure(error))
          } else if let data = data {
            callback?(Result.success(data))
          }
        }
        task.resume()
      }
    }
  }
}
