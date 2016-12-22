//
//  HttpMethod.swift
//  MBCKit
//
//  Created by Kelvin Lau on 2016-12-21.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import Foundation

/// An enum that defines the supported http methods for our backend.
///
/// - get: A `GET` request.
/// - post: A `POST` request. Contains an associated value for the body data.
enum HttpMethod<Body> {
  case get
  case post(Body)
}

extension HttpMethod {
  
  /// Returns the `String` representation of the `HttpMethod`.
  var method: String {
    switch self {
    case .get: return "GET"
    case .post: return "POST"
    }
  }
  
  /// Handles the serialization of data for the various cases.
  ///
  /// - Parameter f: The closure that contains the logic to transform some generic data to what the backend may expect.
  /// - Returns: An `HttpMethod` correctly formatted with the correct body data.
  func map<B>(f: (Body) -> B) -> HttpMethod<B> {
    switch self {
    case .get: return .get
    case .post(let body):
      return .post(f(body))
    }
  }
}
