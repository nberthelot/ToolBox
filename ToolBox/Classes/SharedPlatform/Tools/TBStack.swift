//
//  TBStack.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 28/11/2017.
//

import Foundation


/*
 Last-in first-out stack (LIFO)
 Push and pop are O(1) operations.
 */
public struct TBStack<T> {

  fileprivate var array = [T]()

  public init() {
    
  }
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func push(_ element: T) {
    array.append(element)
  }
  
  public mutating func pop() -> T? {
    return array.popLast()
  }
  
  public var top: T? {
    return array.last
  }
  
}

extension TBStack: Sequence {
 
  public func makeIterator() -> AnyIterator<T> {
    var curr = self
    return AnyIterator {
      return curr.pop()
    }
  }
  
}
