//
//  TBFadeWithBlurAnimator.swift
//  ToolBox
//
//  Created by Paride on 24/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

public protocol TBViewControllerWithBlurredViewProtocol: class {
  var blurredView: UIVisualEffectView! { get set }
}

//MARK: - PRESENT
public class FadeInWithBlurAnimator : NSObject {
  let duration = 0.2
}

extension FadeInWithBlurAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let toVC = transitionContext.viewController(forKey: .to) as? TBViewControllerWithBlurredViewProtocol,
      let toView = transitionContext.view(forKey: .to) else {
        return
    }
    let containerView = transitionContext.containerView
    toVC.blurredView.effect = UIBlurEffect(style: .dark)
    toView.alpha = 0
    toVC.blurredView.alpha = 0
    containerView.addSubview(toView)
    UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveEaseOut],
                   animations: {
                    toView.alpha = 1
                    toVC.blurredView.alpha = 1
    },
                   completion: { finish in
                    transitionContext.completeTransition(finish)
    })
  }
  
}

//MARK: - DISMISS
public class TBFadeOutWithBlurAnimator : NSObject {
  let duration = 0.3
}

extension TBFadeOutWithBlurAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromVC = transitionContext.viewController(forKey: .from) as? TBViewControllerWithBlurredViewProtocol,
      let fromView = transitionContext.view(forKey: .from) else {
        return
    }
    _ = transitionContext.containerView
    UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveEaseOut],
                   animations: {
                    fromView.alpha = 0
                    fromVC.blurredView.alpha = 0
    },
                   completion: { finish in
                    transitionContext.completeTransition(finish)
    })
  }
  
}
