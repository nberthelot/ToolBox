//
//  RotationWithFadeAnimator.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 21/03/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//
import UIKit

public class TBRotationWithFadeInAnimator: NSObject {
  
  var duration = TimeInterval(0.2)
  
  override init() { }
  
  public init(duration: TimeInterval) {
    self.duration = duration
  }
  
}


extension TBRotationWithFadeInAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromView = transitionContext.view(forKey: .from),
      let toView = transitionContext.view(forKey: .to),
      let screenshot = fromView.snapshotView(afterScreenUpdates: true) else {
        return
    }
    
    screenshot.transform = CGAffineTransform(rotationAngle:  -CGFloat.pi / 2 )
    screenshot.frame.origin = CGPoint.zero
    transitionContext.containerView.addSubview(screenshot)
    transitionContext.containerView.insertSubview(toView, belowSubview: screenshot)
    toView.frame = transitionContext.containerView.frame
    
    let animator =  UIViewPropertyAnimator(duration: duration, curve: .easeOut)
    animator.addAnimations {
      screenshot.transform = CGAffineTransform(rotationAngle: 0).concatenating(CGAffineTransform(scaleX: 1.6, y: 1.6))
      screenshot.alpha = 0
    }
    animator.addCompletion { position in
      transitionContext.completeTransition(position == .end)
    }
    animator.startAnimation()
    return
  }
  
}


public class TBRotationWithFadeOutAnimator: NSObject {
  var duration = TimeInterval(0.2)

  override init() { }
  
  public init(duration: TimeInterval) {
    self.duration = duration
  }
  
}

extension TBRotationWithFadeOutAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else {
      return
    }
    toView.frame = transitionContext.containerView.frame
    toView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).concatenating(CGAffineTransform(scaleX: 1.4, y: 1.4))
    toView.alpha = 0
    fromView.alpha = 1
    transitionContext.containerView.addSubview(toView)
    transitionContext.containerView.insertSubview(fromView, belowSubview: toView)
    let animator =  UIViewPropertyAnimator(duration: duration, curve: .easeOut)
    animator.addAnimations {
      toView.transform = .identity
      fromView.alpha = 0
      toView.alpha = 1
    }
    animator.addCompletion { position in
      transitionContext.completeTransition(position == .end)
    }
    animator.startAnimation()
    return
  }
  
}

