//
//  AVURLAsset+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 26/01/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import AVFoundation

public extension AVURLAsset {
  
  static func x_asyncLoadAsset(url: URL, mandatoryValues: [String] = ["playable", "duration"], completion: @escaping ((_ urlAsset: AVURLAsset?) -> ())) {
    let asset = AVURLAsset(url: url)
    asset.loadValuesAsynchronously(forKeys: mandatoryValues, completionHandler: {
      var hasFailed = false
      for key in mandatoryValues {
        var keyStatusError: NSError? = nil
        if asset.statusOfValue(forKey: key, error: &keyStatusError) == .failed {
          hasFailed = true
          tbPrint("[AVURLAsset] x_asyncLoadAsset fail with : \(String(describing: keyStatusError))", category: .ui)
          break
        }
      }
      DispatchQueue.main.async {
        completion(hasFailed ? nil : asset)
      }
    })
  }
  
  
  func x_writeMP4Asset(to outputURL: URL, override: Bool = true) {
    if FileManager.default.fileExists(atPath: outputURL.path) {
      if override == true {
        do {
          try FileManager.default.removeItem(atPath: outputURL.path)
        }
        catch { }
      }
      else {
        return
      }
    }
    let outputTmpURL = outputURL.appendingPathExtension("tmp")
    self.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
    let exporter = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetPassthrough)
    exporter?.outputURL = outputTmpURL
    exporter?.outputFileType = AVFileType.mp4
    do { try FileManager.default.removeItem(at: outputTmpURL) } catch  { }
    exporter?.exportAsynchronously(completionHandler: { [weak self] in
      if let error = exporter?.error {
        tbPrint("[x_writeMP4Asset] fail to write file \(error) - \(outputURL.path)", category: .file)
      }
      else {
        do { try FileManager.default.moveItem(atPath: outputTmpURL.path, toPath: outputURL.path) } catch  { }
      }
      do { try FileManager.default.removeItem(at: outputTmpURL) } catch  { }
      self?.resourceLoader.setDelegate(nil, queue: DispatchQueue.main)
      tbPrint("[x_writeMP4Asset] Success to write file to \(outputURL.path)", category: .file)
    })
  }
  
}


extension AVURLAsset: AVAssetResourceLoaderDelegate {
  
}
