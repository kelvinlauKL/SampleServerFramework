//
//  URLRequest+init.swift
//  SampleServerFramework
//
//  Created by Kelvin Lau on 2016-12-22.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import Foundation

extension URLRequest {
  init<A>(resource: Resource<A>) {
    self.init(url: resource.url)
    httpMethod = resource.method.method
    if case let .post(data) = resource.method {
      httpBody = data
    }
  }
}
