//
//  TodoTests.swift
//  SampleServerFramework
//
//  Created by Kelvin Lau on 2016-12-22.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import XCTest
@testable import SampleServerFramework

class TodoTests: XCTestCase {
  func testTodosSyncLoading() {
    let todos = Webservice().syncLoad(resource: Todo.all)
    XCTAssertNotNil(todos, "todos was nil")
  }
  
  func testTodosLoading() {
    let asyncExpectation = expectation(description: "longRunningFunction")
    
    Webservice().load(resource: Todo.all) { result in
      guard let todos = result else { return XCTAssertNotNil(result) }
      XCTAssertEqual(todos.count, 200)
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 5) { error in
      XCTAssertNil(error, "Something went horribly wrong.")
    }
  }
}
