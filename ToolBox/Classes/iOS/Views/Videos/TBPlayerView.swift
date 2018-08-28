//
//  TBPlayerView.swift
//  ToolBox
//
//  Created by Paride on 13/09/16.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import AVFoundation

open class TBPlayerView: UIView {
  
  public var player: AVPlayer? {
    get { return playerLayer.player }
    set { playerLayer.player = newValue }
  }
  
  public var playerLayer: AVPlayerLayer {
    return layer as! AVPlayerLayer
  }
  
  open override class var layerClass : AnyClass {
    return AVPlayerLayer.self
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
  }
  
}
