//
//  MainLotteryController.swift
//  lottery
//
//  Created by GARY on 2017/2/6.
//  Copyright © 2017年 GARY. All rights reserved.
//

import UIKit


class MainLotteryController: UIViewController {
    
    private var backView : UIImageView;
    private var foreView : UIImageView;
    private var centerBtn : UIButton;
    private var wheelBtnsArr = [WheelBtn]();
    private var WheelingTimer : Timer?;
    
    init() {
        
        backView = UIImageView(image: UIImage.init(named: "LuckyBaseBackground"));
        foreView = UIImageView(image: UIImage.init(named: "LuckyRotateWheel"));
        
        centerBtn = UIButton(type: UIButtonType.custom);
        centerBtn.setBackgroundImage(UIImage.init(named: "LuckyCenterButton"), for: UIControlState.normal);
        centerBtn.setBackgroundImage(UIImage.init(named: "LuckyCenterButtonPressed"), for: UIControlState.highlighted);

        super.init(nibName: nil, bundle: nil);
        
//        self.transitioningDelegate = self;
        self.view.backgroundColor = UIColor.init(red: 152/255, green: 245/255, blue: 255/255, alpha: 1);
        centerBtn.addTarget(self, action: #selector(startWheeling), for: UIControlEvents.touchUpInside);
        
        
        view.addSubview(backView);
        view.addSubview(foreView);
        
        //设置轮转按钮
        //设置轮转按钮图片比例
        let image = UIImage.init(named: "LuckyAstrology");
        let selImage = UIImage.init(named: "LuckyAstrologyPressed");
        let scale = UIScreen.main.scale;
        
        //获得图片的宽高
        let imageW = image!.size.width / 12 * scale;
        let imageH = image!.size.height * scale;
        
        for index in 0...11 {
            let wheelBtn = WheelBtn(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
            wheelBtn.tag = index;
            wheelBtnsArr.append(wheelBtn);
            self.view.addSubview(wheelBtn);
            
            wheelBtn.isUserInteractionEnabled = false;
            wheelBtn.setBackgroundImage(UIImage.init(named: "LuckyRototeSelected"), for: UIControlState.selected);
            wheelBtn.addTarget(self, action:#selector(didSelectBtn(Selbtn:)), for: UIControlEvents.touchUpInside);
            wheelBtn.layer.anchorPoint = CGPoint(x: 0.5, y: 1);
            
            //裁剪图片
            let clipImage = image?.cgImage?.cropping(to: CGRect(x: CGFloat(index)*imageW, y: 0, width: imageW, height: imageH));
            let clipSelImage = selImage?.cgImage?.cropping(to: CGRect(x: CGFloat(index)*imageW, y: 0, width: imageW, height: imageH));
            
            wheelBtn.setImage(UIImage.init(cgImage: clipImage!), for: UIControlState.normal);
            wheelBtn.setImage(UIImage.init(cgImage: clipSelImage!), for: UIControlState.selected);
            
        }
        view.addSubview(centerBtn);
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        self.navigationItem.title = "Lottery";
    }
    
    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300));
        }
        
        foreView.snp.makeConstraints { (make) in
            make.center.equalToSuperview();
            make.size.equalTo(CGSize(width: 300, height: 300));
        }
        
        centerBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview();
            make.size.equalTo(CGSize(width: 100, height: 100));
        }
        
        for index in 0...11 {
            let btn = wheelBtnsArr[index];
            
            //布置按钮的位置
            btn.snp.makeConstraints({ (make) in
                make.center.equalToSuperview();
                make.size.equalTo(CGSize(width: 68, height: 143));
            })
            
            //开始按钮的变形
            let angle = M_PI*2 / 12;
            btn.transform = CGAffineTransform.init(rotationAngle: CGFloat(angle)*CGFloat(index));
            
        }
    }
    
    @objc func didSelectBtn(Selbtn : WheelBtn) {
        
        Selbtn.isSelected = true;
        for btn in wheelBtnsArr {
            if btn.tag != Selbtn.tag {
                btn.isSelected = false;
            }
        }
    }
    
    //轮转的次数
    static var count : NSInteger = 0;
    //旋转圈数的基数
    static let multiply = 1;
    //点击开始选号后
    @objc func startWheeling()
    {
        MainLotteryController.count = 0;
        
        if WheelingTimer == nil{
            
            //构建概率表
            let probility = [wheelBtnsArr[0] : 0.1,wheelBtnsArr[1] : 0.2,
                             wheelBtnsArr[2] : 0.1,wheelBtnsArr[3] : 0.5,
                             wheelBtnsArr[4] : 0.01,wheelBtnsArr[5] : 0.01,
                             wheelBtnsArr[6] : 0.05,wheelBtnsArr[7] : 0.02,
                             wheelBtnsArr[8] : 0.001,wheelBtnsArr[9] : 0.005,
                             wheelBtnsArr[10] : 0.002,wheelBtnsArr[11] : 0.002]
            
            //根据概率表的权值进行排序
            var tempDict = [WheelBtn : Double]();
            for btn  in wheelBtnsArr {
                //根据权值获得随机值
                tempDict.updateValue(Double(arc4random()%100 + 1)*probility[btn]!, forKey: btn);
            }
            
            var sortedArr = wheelBtnsArr;
            
            //根据随机值进行排序
            sortedArr.sort(by: { (b1, b2) -> Bool in
                return tempDict[b1]! > tempDict[b2]!;
            })
            
            for btn in sortedArr {
                print("\(btn.tag)-->\(tempDict[btn])");
            }
            
            //控制中奖概率
            let random = sortedArr[0].tag;
            print("将要选中\(random)")
    
            WheelingTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true, block: { (timer) in
                
                MainLotteryController.count += 1;
                let btn = self.wheelBtnsArr[MainLotteryController.count%self.wheelBtnsArr.count];
                self.didSelectBtn(Selbtn: btn);
                
                //增加旋转圈数
                if (random + (MainLotteryController.multiply * self.wheelBtnsArr.count)) == MainLotteryController.count
                {
                    timer.invalidate();
                    self.WheelingTimer = nil;
                    
                    //停止抽奖
                    MessageView.init(withMessage: "\(random+1)", parentView: self.view).show();
                }
                
            })
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
