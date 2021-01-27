//
//  PlayerManager.swift
//  AVPlayer
//
//  Created by mac on 2021/1/27.
//

import UIKit
import AVKit

class PlayerManager: NSObject {
    
     var player: AVPlayer!
    
    private var playerItem: AVPlayerItem?
    
    private(set) var playerLayer: AVPlayerLayer!
    
    init(_ url: String) {
        super.init()
        guard let url = URL(string: url) else {
            return
        }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        // status属性观察
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        playerLayer = AVPlayerLayer(player: player)
        
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let playerItem = object as? AVPlayerItem  else { return }
        guard let keyPath = keyPath else { return }
        
        if keyPath == "status" {
            switch playerItem.status {
            // 资源准备完毕可以播放
            case .readyToPlay:
                // 总时间 秒数
                print("准备好播放")
                
            case .failed:
                print("播放出错")
            case .unknown:
                print("播放出错")
            default:
                break
            }
            
        } else if keyPath == "loadedTimeRanges" {
            // 总时间 秒数
            let totalTime = getTotalSeconds(playerItem)
            getBufferProgress()
        }
    }
    
    /// 获取缓冲进度
    @discardableResult
    private func getBufferProgress() -> TimeInterval {
        // 加载时间范围
        guard let loadedTimeRanges = player.currentItem?.loadedTimeRanges, let first = loadedTimeRanges.first else {
            return 0
        }
        // 本次缓冲时间范围
        let timeRange = first.timeRangeValue
        // 本次缓冲起始时间
        let startSeconds = CMTimeGetSeconds(timeRange.start)
        // 缓冲时间
        let durationSecound = CMTimeGetSeconds(timeRange.duration)
        // 缓冲总长度
        let result = startSeconds + durationSecound
        print(startSeconds,durationSecound)
        return result
    }
    
    // 获取总时长
    @discardableResult
    private func getTotalSeconds(_ playerItem: AVPlayerItem) -> Float64 {
        return CMTimeGetSeconds(playerItem.duration)
    }
}
