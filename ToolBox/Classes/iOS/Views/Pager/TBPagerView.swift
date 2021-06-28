//
//  TBPagerView.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 23/08/2017.
//  Copyright © 2017 Nicolas Berthelot. All rights reserved.
//

import Foundation
import UIKit


public class TBPagerView: UIView {
  
  fileprivate var pages = [UIView]()
  fileprivate var pageScrollTimer: Timer?
  
  public weak var delegate: TBPagerViewDelegate?
  public var currentIndex = 0 {
    didSet {
      if oldValue != currentIndex {
        delegate?.pagerView(pagerView: self, pageDidChanged: currentIndex, from: oldValue)
      }
    }
  }
  
  public var animationTime: TimeInterval = 0.3
  public var isInfinite: Bool = false
  public var autoScrollDelay: TimeInterval = 5
  public var transformer: TBPagerViewTransformer = TBPagerViewTransformer()
  
  public var enableAutoScroll = false {
    didSet {
      _ = enableAutoScroll ? startTimer() : stopTimer()
    }
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    prepare()
  }
  
  public func reloadData(index: Int = 0) {
    currentIndex = 0
    guard let delegate = delegate else {
      return
    }
    pages = delegate.pageViewsFor(pagerView: self)
    for (index, v) in pages.enumerated() {
      addSubview(v)
      v.translatesAutoresizingMaskIntoConstraints = false
      v.topAnchor.constraint(equalTo: topAnchor).isActive = true
      v.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
      v.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
      v.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      // set each page ouside the view by default
      transformer.applyTransform(v, progress: -1, fromPager: self, animated: false)
      sendSubviewToBack(v)
      v.tag = index
    }
    
    setToProgress(-CGFloat(index))
    currentIndex = index
    if pages.count > 1 {
        startTimer()
    }
  }
  
}

extension TBPagerView {
  
  fileprivate func prepare() {
    layer.rasterizationScale = UIScreen.main.scale
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
    panGestureRecognizer.delegate = self
    addGestureRecognizer(panGestureRecognizer)
  }
  
}

// MARK: - GESTURE
extension TBPagerView {
  
  @objc func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
    guard pages.count > 1 else { return }
    let translation = recognizer.translation(in: recognizer.view!.superview!)
    var progress = translation.x / frame.width
    
    if isInfinite == false {
      progress = min(CGFloat(currentIndex), progress)
      progress = max(progress, CGFloat(currentIndex - pages.count + 1))
    }
    
    switch recognizer.state {
    case .began:
      layer.shouldRasterize = true
      stopTimer()
    case .changed:
      setToProgress(progress)
    case .ended: fallthrough
    case .cancelled: fallthrough
    case .failed:
      endedPanGesture(recognizer, progress: progress)
    default: break
    }
  }
  
  fileprivate func endedPanGesture(_ recognizer: UIPanGestureRecognizer, progress: CGFloat) {
    layer.shouldRasterize = false
    var targetProgress: CGFloat = round(progress)
    var newIndex = mod((currentIndex - Int(targetProgress)), pages.count)
    // Check velocity to force page navigation
    if newIndex == currentIndex {
      let velocity = recognizer.velocity(in: self).x
      if abs(velocity) > 700 {
        targetProgress += velocity > 0 ? 1 : -1
      }
    }
    
    if isInfinite == false {
      targetProgress = min(CGFloat(currentIndex), targetProgress)
      targetProgress = max(targetProgress, CGFloat(currentIndex - pages.count + 1))
    }
    
    newIndex = mod((currentIndex - Int(targetProgress)), pages.count)
    let animationDuration = TimeInterval(abs(targetProgress - progress)) * animationTime
    self.setToProgress(targetProgress, animated: true, duration: animationDuration)
    self.currentIndex = newIndex
    startTimer()
  }
  
  func setToProgress(_ progress: CGFloat, animated: Bool = false, duration: TimeInterval = 0.3) {
    for i in 0..<pages.count {
      setToProgress(progress, factor: currentIndex - i, animated: animated, duration: duration)
    }
  }
  
  fileprivate func setToProgress(_ progress: CGFloat, factor: Int, animated: Bool = false, duration: TimeInterval = 0) {
    let pagesCount = pages.count
    let localProgress = progress + CGFloat(factor)
    let progessPage = capProgess(localProgress)
    let pageIndex = mod((currentIndex + factor), pagesCount)
    
    let v = pages[pageIndex]
    
    transformer.applyTransform(v, progress: progessPage, fromPager: self, animated: animated, duration: duration)
    if animated == true {
      layer.shouldRasterize = true
    }
  }
  
}

// MARK: - GESTURE DELEGATE
extension TBPagerView: UIGestureRecognizerDelegate {
  
  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
      return true
    }
    let velocity = panGesture.velocity(in: self)
    return abs(velocity.y) < abs(velocity.x)
  }
  
}

// MARK: - TOOLS
extension TBPagerView {
  
  public func goToPrevious(animated: Bool = true) {
    guard isInfinite == true || currentIndex > 0 else {
      return
    }
    stopTimer()
    setToProgress(1, animated: animated)
    currentIndex = self.mod(self.currentIndex - 1, self.pages.count)
    startTimer()
  }
  
  public func goToNext(animated: Bool = true) {
    guard pages.isEmpty == false else {
        return
    }
    
    guard isInfinite == true || currentIndex < (pages.count - 1) else {
      return
    }
    
    stopTimer()
    setToProgress(-1, animated: animated)
    currentIndex = self.mod(self.currentIndex + 1, self.pages.count)
    startTimer()
  }
  
  func mod(_ a: Int, _ n: Int) -> Int {
    let r = a % n
    return r >= 0 ? r : r + n
  }
  
  fileprivate func capProgess(_ progress: CGFloat)  -> CGFloat {
    let cap : CGFloat = CGFloat(pages.count)
    return progress - cap * round(progress / cap)
  }
  
  public func index(for view: UIView) -> Int {
    return pages.firstIndex(of: view) ?? 0
  }
  
  public func page(at index: Int) -> UIView? {
    guard index >= 0 && index < pages.count else {
      return nil
    }
    return pages[index]
  }
  
  public func currentPage() -> UIView? {
    return page(at: currentIndex)
  }

}

// MARK: - TIMER
extension TBPagerView {
  
  public func startTimer() {
    guard enableAutoScroll else {
      stopTimer()
      return
    }
    let time = autoScrollDelay
    stopTimer()
    pageScrollTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(self.scrollTimerDidFire) , userInfo: nil, repeats: false)
    RunLoop.main.add(pageScrollTimer!, forMode: RunLoop.Mode.common)
    delegate?.pagerViewTimerDidStart(pagerView: self)
  }
  
 public func stopTimer() {
    pageScrollTimer?.invalidate()
    pageScrollTimer = nil
    delegate?.pagerViewTimerDidStop(pagerView: self)
  }
  
  @objc func scrollTimerDidFire() {
    goToNext()
    startTimer()
  }
}

