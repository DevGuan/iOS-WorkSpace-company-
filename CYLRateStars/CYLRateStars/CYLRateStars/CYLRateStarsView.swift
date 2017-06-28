//
//  CYLRateStarsView.swift
//  CYLRateStars
//
//  Created by 迟钰林 on 2017/6/27.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class CYLRateStarsView: UIView {

    var numOfStars: NSInteger = 0
    var stars: Array<UIButton> = Array.init()
    let duration : CFTimeInterval = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func setUI() {
        for i in 0 ..< 5 {
            let star = UIButton.init()
            star.setBackgroundImage(UIImage.init(named: "star"), for: .normal)
            star.tag = i
            star.addTarget(self, action: #selector(didClickStar(star:)), for: .touchUpInside)
            self.addSubview(star)
            stars.append(star)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = self.bounds.height
        
        stars[0].snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.top.equalTo(self)
            ConstraintMaker.width.equalTo(height)
            ConstraintMaker.height.equalTo(height)
        }
        
        stars[1].snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self)
            ConstraintMaker.left.equalTo(stars[0].snp.right).offset(5)
            ConstraintMaker.width.height.equalTo(stars[0])
        }
        
        stars[2].snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self)
            ConstraintMaker.left.equalTo(stars[1].snp.right).offset(5)
            ConstraintMaker.width.height.equalTo(stars[0])
        }
        
        stars[3].snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self)
            ConstraintMaker.left.equalTo(stars[2].snp.right).offset(5)
            ConstraintMaker.width.height.equalTo(stars[0])
        }
        
        stars[4].snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self)
            ConstraintMaker.left.equalTo(stars[3].snp.right).offset(5)
            ConstraintMaker.width.height.equalTo(stars[0])
        }
    }
    
    func didClickStar(star:UIButton) {

        sparking(star: star)
    }
    
    let KAnimName = "animName"
    let KAnimObj = "animObj"
    
    func sparking(star:UIButton) {
        star.isUserInteractionEnabled = false
        star.isSelected = !star.isSelected
        scalePhaseOne(star: star)
    }
    
    func scalePhaseOne(star:UIButton) {
        let scalePhaseOne = CABasicAnimation.init(keyPath: "transform.scale")
        scalePhaseOne.toValue = 0.2
        scalePhaseOne.beginTime = CACurrentMediaTime()
        scalePhaseOne.duration = duration/5
        scalePhaseOne.isRemovedOnCompletion = false
        scalePhaseOne.fillMode = kCAFillModeBoth
        scalePhaseOne.delegate = self
        scalePhaseOne.setValue("phaseOne", forKey: KAnimName)
        scalePhaseOne.setValue(star, forKey: KAnimObj)
        star.layer.add(scalePhaseOne, forKey: nil)
    }
    
    func scaleUpPhaseTwo(star:UIButton) {
        
        star.setImage(UIImage.init(named: star.isSelected ? "star-selected" : "star"), for: .normal)
        
        let scaleUp = CASpringAnimation.init(keyPath: "transform.scale")
        scaleUp.duration = duration/5 * 3
        scaleUp.damping = 20
        scaleUp.initialVelocity = 2
        scaleUp.toValue = 1
        scaleUp.beginTime = CACurrentMediaTime() + duration/5
        scaleUp.isRemovedOnCompletion = false
        scaleUp.fillMode = kCAFillModeForwards
        scaleUp.delegate = self
        scaleUp.setValue("phaseTwo", forKey: KAnimName)
        scaleUp.setValue(star, forKey: KAnimObj)
        star.layer.add(scaleUp, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CYLRateStarsView: CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim.value(forKey: KAnimName) as! String == "phaseOne" {
            scaleUpPhaseTwo(star: anim.value(forKey: KAnimObj) as! UIButton)
        }
        
        if anim.value(forKey: KAnimName) as! String == "phaseTwo" {
            (anim.value(forKey: KAnimObj) as! UIButton).isUserInteractionEnabled = true
        }
        
    }
}
