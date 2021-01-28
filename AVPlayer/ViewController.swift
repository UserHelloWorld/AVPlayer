//
//  ViewController.swift
//  AVPlayer
//
//  Created by mac on 2021/1/27.
//

import UIKit
import AVKit
class ViewController: UIViewController {
    
    private let urlString = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
    var play: PlayerManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play  = PlayerManager(urlString)
        play.playerLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 400)
        self.view.layer.addSublayer(play.playerLayer)
       let tab = PlayerTabbarView(frame: CGRect(x: 0, y: 400-40, width: view.bounds.width, height: 40))
        view.addSubview(tab)
        tab.playClickBlock = {[weak self] b in
            self?.play.play()
            tab.playImageState(self?.play.isPlaying ?? false)
        }
        play.playProgress = { progress, second in
            tab.sliderValue(Float(progress))
            let min = second / 60
            let sec = Int(second) % 60
            let timeStr = String(format: "%02d:%02d", Int(min),sec)
            tab.startTimeLabel.text = timeStr
        }
        tab.sliderBlock = { [weak self] value in
            self?.play.seekToTime(time: value)
        }
        play.totalTimeBlock = {
            tab.endTimeLabel.text = $0
        }
    }
}

