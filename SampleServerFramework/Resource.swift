//
//  Resource.swift
//  MBCKit
//
//  Created by Kelvin Lau on 2016-12-21.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import Foundation

/// A lightweight struct that encapsulates the logic to retrieve data and turning it into a native model object from a `URL`.
struct Resource<A> {
  
  /// The `URL` where the the data presides.
  let url: URL
  
  let method: HttpMethod<Data>
  
  /// A closure that is responsible for handling some data and changing it to the expected type.
  let parse: (Data) -> A?
}

extension Resource {
  
  /// `Init` method for parsing `JSON`.
  ///
  /// - Parameters:
  ///   - url: The `URL` where you can find the data.
  ///   - parseJSON: A closure that contains the logic to change `Data` into an native model object.
  init(url: URL, method: HttpMethod<Any> = .get, parseJSON: @escaping (Any) -> A?) {
    self.url = url
    self.method = method.map { json in
      try! JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    self.parse = { data in
      let json = try? JSONSerialization.jsonObject(with: data, options: [])
      return json.flatMap(parseJSON)
    }
  }
}
