//
//  Webserivce.swift
//  MBCKit
//
//  Created by Kelvin Lau on 2016-12-21.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

/// `Webservice` contains methods for retrieving and posting to a backend server.
final class Webservice {
  static let baseURLString = "https://jsonplaceholder.typicode.com/"
    
  /// `syncLoad` synchronously makes network calls. Meant to be used for testing purposes only. Use `load` to deal with asynchronous network calls.
  ///
  /// - Parameter resource: A `Resource` type, which contains information on where to find the resource and how to convert it into a native model object.
  /// - Returns: The type that is requested by `syncLoad`. For example, you could make a call like `let todos = syncLoad<[Todo]>(resource: Todo.all)` to retrieve all the objects from the `Todo` resource.
  func syncLoad<A>(resource: Resource<A>) -> A? {
    let data = try? Data(contentsOf: resource.url)
    let result = data.flatMap(resource.parse)
    return result
  }
  
  /// `load` asynchronously retrieves a `Resource`.
  ///
  /// - Parameters:
  ///   - resource: A `Resource` type, which contains information on where to find the resource and how to convert it into a native model object.
  ///   - completion: A closure that gives back the type requested. For example, `load<[Todo]>
  func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
    let request = URLRequest(resource: resource)
    URLSession.shared.dataTask(with: request) { data, _, _ in
      completion(data.flatMap(resource.parse))
    }.resume()
  }
}
