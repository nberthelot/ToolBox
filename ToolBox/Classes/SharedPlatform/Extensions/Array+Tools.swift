//
//  Array+tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 20/07/2017.
//
//

import Foundation

public enum ArrayTransformationSteps<Element> {
  case insert(position: Int, value: Element)
  case delete(position: Int, value: Element)
  case replace(position: Int, value: Element)
}

extension Array {
  
  public mutating func x_moveItem(from: Int, to: Int) {
    precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indexes")
    insert(remove(at: from), at: to)
  }
    
}

extension Array where Element: Equatable {
  
  public func x_containsOne(of types: [Element]) -> Bool {
    for type in types {
      if self.contains(type) {
        return true
      }
    }
    return false
  }
}

extension Array where Element: Equatable {
  
  public func x_transformations(fromArray: Array<Element>) -> Array<ArrayTransformationSteps<Element>> {
    let sourceSeries = fromArray
    let newSeries = self
    var res = Array<ArrayTransformationSteps<Element>>()
    var tmpSeries = sourceSeries
    
    //removeAll unused
    for (index, series) in tmpSeries.enumerated().reversed() {
      if newSeries.index(of: series) == nil {
        res.append(ArrayTransformationSteps<Element>.delete(position: index, value: series))
        tmpSeries.remove(at: index)
      }
    }
    
    for (index, series) in newSeries.enumerated() {
      if let oldIndex = tmpSeries.index(of: series) {
        if index != oldIndex {
          res.append(ArrayTransformationSteps<Element>.delete(position: oldIndex, value: series))
          res.append(ArrayTransformationSteps<Element>.insert(position: index, value: series))
          tmpSeries.x_moveItem(from: oldIndex, to: index)
        }
      }
      else {
        tmpSeries.insert(series, at: index)
        res.append(ArrayTransformationSteps<Element>.insert(position: index, value: series))
      }
    }
    return res
  }
  
}

extension MutableCollection {
  /// Shuffles the contents of this collection.
  public mutating func x_shuffle() {
    let c = count
    guard c > 1 else { return }

    for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      guard d != 0 else { continue }
      let i = index(firstUnshuffled, offsetBy: d)
      self.swapAt(firstUnshuffled, i)
    }
  }
  
}

extension Sequence {
  
  public func x_shuffled() -> [Iterator.Element] {
    var result = Array(self)
    result.x_shuffle()
    return result
  }
  
}

extension Dictionary {
  
  public mutating func x_merge(with dictionary: Dictionary) {
    dictionary.forEach { updateValue($1, forKey: $0) }
  }
  
  public func x_merged(with dictionary: Dictionary) -> Dictionary {
    var dict = self
    dict.x_merge(with: dictionary)
    return dict
  }
  
}

