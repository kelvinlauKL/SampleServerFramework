//
//  Todo.swift
//  MBCKit
//
//  Created by Kelvin Lau on 2016-12-21.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

struct Todo {
  static let url = URL(string: Webservice.baseURLString + "todos")!
  
  let id: Int!
  let title: String
  let userId: Int
  let completed: Bool
  
  init(title: String, userId: Int, completed: Bool) {
    self.title = title
    self.userId = userId
    self.completed = completed
    self.id = nil
  }
}

extension Todo {
  init?(dictionary: JSONDictionary) {
    guard let id = dictionary["id"] as? Int, let title = dictionary["title"] as? String, let userId = dictionary["userId"] as? Int, let completed = dictionary["completed"] as? Bool else { return nil }
    self.id = id
    self.title = title
    self.userId = userId
    self.completed = completed
  }
}

extension Todo {
  static let all = Resource<[Todo]>(url: url, parseJSON: { json in
    guard let dictionaries = json as? [JSONDictionary] else { return nil }
    return dictionaries.flatMap(Todo.init)
  })
}
