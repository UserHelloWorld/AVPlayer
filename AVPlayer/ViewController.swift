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
        play.player.play()
    }
}

