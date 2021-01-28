//
//  PlayerTabbarView.swift
//  AVPlayer
//
//  Created by mac on 2021/1/28.
//

import UIKit

class PlayerTabbarView: UIView {
    
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()
    let playBtn = UIButton(type: .custom)
    let slider = UISlider()
    
    var playClickBlock: ((Bool) -> Void)?
    var sliderBlock: ((Float)-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        addSubview(playBtn)
        addSubview(startTimeLabel)
        addSubview(slider)
        addSubview(endTimeLabel)
        startTimeLabel.text = "00:00"
        endTimeLabel.text = "00:00"
        slider.setThumbImage(UIImage(named: "circle"), for: .normal)
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        playBtn.addTarget(self, action: #selector(playBtnClick(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderClick), for: .valueChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sliderClick(_ slider: UISlider) {
        print(slider.value)
        sliderBlock?(slider.value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.bounds.width
        let height = self.bounds.height
        playBtn.frame = CGRect(x: 0, y: 0, width: 50, height: height)
        
        startTimeLabel.frame = CGRect(x: playBtn.frame.maxX + 5, y: 0, width: 60, height: height)
        endTimeLabel.frame = CGRect(x: width - 60 - 10, y: 0, width: 60, height: height)
        slider.frame = CGRect(x: startTimeLabel.frame.maxX + 5, y: 0, width: width - startTimeLabel.frame.maxX - endTimeLabel.frame.width - 10 - 5, height: height)
    }
    
    @objc func playBtnClick(_ btn: UIButton) {
        self.playClickBlock?(true)
        
    }
    func playImageState(_ selected: Bool)  {
        if selected {
            playBtn.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playBtn.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func sliderValue(_ value: Float) {
        print(slider.isTracking)
        if slider.isTracking == false {
            self.slider.value = value
        }
    }
    
    
}

