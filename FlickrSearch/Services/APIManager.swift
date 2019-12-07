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

enum APIError: Error {
  case invalidUrl
}

class APIManager {
  
  // MARK: - Vars
  
  static let shared = APIManager()
  
  // MARK: - Life cycle
  
  private init() { }
  
  // MARK: - Func
  
  func search(_ string: String, callback: PhotosCallback?) {
    
    request(.search(string)) { result in
      
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
  
  // MARK: - Private func
  
  private func request(_ route: FlickrSettings.Route, callback: DataCallback?) {
    
    DispatchQueue.global(qos: .background).async {
      guard let url = URL(string: route.url) else {
        callback?(Result.failure(APIError.invalidUrl))
        return
      }
      
      let request = URLRequest(url: url)
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForResource = 10
      let session = URLSession(configuration: configuration)
      
      let task = session.dataTask(with: request) { (data, response, error) in
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
