//
//  MessageView.swift
//  Lottery
//
//  Created by GARY on 2017/2/7.
//  Copyright © 2017年 GARY. All rights reserved.
//

import UIKit

class MessageView: UIView {

    static let screenW = UIScreen.main.bounds.size.width;
    static let screenH = UIScreen.main.bounds.size.height;
    
    let message : String;
    let messageLable : UILabel?;
    let parentView : UIView;
    let quitBtn : UIButton;
    let confirmBtn : UIButton;
    
    init(withMessage message: String, parentView: UIView) {
        self.message = message;
        self.parentView = parentView;
        self.quitBtn = UIButton.init(type: UIButtonType.custom);
        self.confirmBtn = UIButton.init(type: UIButtonType.custom);
        self.messageLable = UILabel.init();
        
        let viewH = MessageView.screenH/4;
        let viewW = MessageView.screenW/3 * 2.5;
        super.init(frame: CGRect(x: (MessageView.screenW - viewW)/2, y: MessageView.screenH/3, width: viewW, height: viewH));
        
        self.confirmBtn.addTarget(self, action: #selector(didClickConfirm), for: UIControlEvents.touchUpInside);
        self.quitBtn.addTarget(self, action: #selector(didClickQuite), for: UIControlEvents.touchUpInside);
        self.confirmBtn.setTitle("领奖", for: UIControlState.normal);
        self.quitBtn.setTitle("放弃", for: UIControlState.normal);
        self.confirmBtn.backgroundColor = UIColor.init(red: 83/255, green: 134/255, blue: 139/255, alpha: 1);
        self.quitBtn.backgroundColor = UIColor.init(red: 83/255, green: 134/255, blue: 139/255, alpha: 1);
        
        self.addSubview(confirmBtn);
        self.addSubview(quitBtn);
        self.addSubview(messageLable!);
        
        self.messageLable?.text = "抽中\(message)号大奖！";
        self.messageLable?.font = UIFont.systemFont(ofSize: 18);
        self.messageLable?.textAlignment = NSTextAlignment.center;
        
        self.layer.cornerRadius = 10;
        self.backgroundColor = UIColor.init(red: 1, green: 1, blue:1 , alpha: 0.85);
    }
    
    public func show() {
        parentView.addSubview(self);
    }
    
    func didClickQuite() {
        self.removeFromSuperview();
    }
    
    func didClickConfirm() {
        
    }
    
    override func layoutSubviews() {
        
        quitBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self);
            make.right.equalTo(self.snp.centerX).offset(-1);
            make.height.equalTo(self.frame.size.height/3);
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview();
            make.left.equalTo(self.snp.centerX).offset(1);
            make.height.equalTo(quitBtn);
        }
        
        messageLable?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview();
            make.top.equalToSuperview().offset((self.frame.size.height - confirmBtn.frame.size.height)/5)
            make.height.equalTo((self.frame.size.height - confirmBtn.frame.size.height)/3)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
