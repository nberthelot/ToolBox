//
//  TBVideoLooperView.swift
//  ToolBox
//
//  Created by Paride on 03/04/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import AVFoundation

public class TBLoopPlayer: AVPlayer {
  
  override public init() {
    super.init()
  }
  
  override public init(playerItem item: AVPlayerItem?) {
    super.init(playerItem: item)
    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),
                                           name: .AVPlayerItemDidPlayToEndTime, object: currentItem)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc public func playerDidFinishPlaying(note: NSNotification) {
    seek(to: kCMTimeZero)
    play()
  }
  
}

public final class TBVideoLooperView: UIImageView {
  
  public var identifier: String
  public var url: URL!
  public var playerView: TBPlayerView!
  
  public var player: AVPlayer? {
    return playerView.player
  }
  
  public var videoLayer: AVPlayerLayer {
    return playerView.playerLayer
  }
  
  public var urlAsset: AVURLAsset? {
    return player?.currentItem?.asset as? AVURLAsset
  }
  
  public init(frame: CGRect, url: URL, identifier: String = String()) {
    self.url = url
    self.identifier = identifier
    super.init(frame: frame)
    playerView = TBPlayerView(frame: bounds)
    addSubview(playerView)
    alpha = 0
    contentMode = .scaleAspectFill
    isUserInteractionEnabled = false
  }
  
  public required init?(coder aDecoder: NSCoder) {
    self.identifier = String()
    super.init(coder: aDecoder)
    playerView = TBPlayerView(frame: bounds)
    addSubview(playerView)
    alpha = 0
    contentMode = .scaleAspectFill
    playerView.x_fitTo(self)
    isUserInteractionEnabled = false
  }

  public func setup(url: URL, identifier: String = String()) {
    self.url = url
    self.identifier = identifier
  }
  
}

//MARK: - VIDEO LOADING
extension TBVideoLooperView {
  
  public func loadVideoAsync(completion: ((Bool) -> Void )?) {
    playerView.player?.replaceCurrentItem(with: nil)
    playerView.player = nil
    AVURLAsset.x_asyncLoadAsset(url: url) { [weak self] asset in
      guard let asset = asset else {
        tbPrint("LoopPlayerLayer: impossible to load asset async", category: .ui)
        completion?(false)
        return
      }
      self?.playerView.player?.replaceCurrentItem(with: nil)
      self?.playerView.player = nil
      self?.playerView.player = TBLoopPlayer(playerItem: AVPlayerItem(asset: asset))
      self?.player?.play()
      self?.animateFadingIn()
      completion?(true)
    }
  }
  
  fileprivate func setFirstFramePlaceholder() {
    guard image == nil, let asset = player?.currentItem?.asset else {
      return
    }
    DispatchQueue.global(qos: .background).async {
      let generator = AVAssetImageGenerator(asset: asset)
      generator.appliesPreferredTrackTransform = true
      do {
        let rawFrame  = try generator.copyCGImage(at: kCMTimeZero, actualTime: nil)
        let imageFrame = UIImage(cgImage: rawFrame)
        DispatchQueue.main.async { [weak self] in
          self?.image = imageFrame
        }
      }
      catch {
        tbPrint("generateThumbImage: impossible to retrieve video's first frame. \(error)", category: .ui)
      }
    }
  }
  
}

//MARK: - HELPERS
extension TBVideoLooperView {
  
  fileprivate func animateFadingIn() {
    let animator = UIViewPropertyAnimator(duration: 0.8, curve: .easeOut)
    animator.addAnimations { [weak self] in
      self?.alpha = 1
    }
    
    animator.addCompletion() { [weak self] _ in
      self?.setFirstFramePlaceholder()
    }
    
    animator.startAnimation()
  }
  
  public func reloadPlayerIfErrorOccured() {
    if player?.currentItem?.error != nil {
      removePlayer()
      recreatePlayer()
    }
  }
  
  public func removePlayer() {
   player?.pause()
   player?.replaceCurrentItem(with: nil)
   playerView.player = nil
  }
  
  public func recreatePlayer() {
    guard player == nil else {
      return
    }
    loadVideoAsync(completion: nil)
  }
  
}
