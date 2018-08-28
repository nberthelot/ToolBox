//
//  TBPagerViewDelegate.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 13/10/2017.
//

import Foundation

public protocol TBPagerViewDelegate: class {
  func pageViewsFor(pagerView: TBPagerView) -> [UIView]
  func pagerView(pagerView: TBPagerView, pageDidChanged index: Int, from oldIndex: Int)
  func pagerViewTimerDidStop(pagerView: TBPagerView)
  func pagerViewTimerDidStart(pagerView: TBPagerView)
}

extension TBPagerViewDelegate {
  public func pagerView(pagerView: TBPagerView, pageDidChanged index: Int, from oldIndex: Int) { }
  public func pagerViewTimerDidStop(pagerView: TBPagerView) { }
  public func pagerViewTimerDidStart(pagerView: TBPagerView) { }
}
