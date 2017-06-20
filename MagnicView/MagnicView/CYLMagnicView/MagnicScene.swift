//
//  MagnicScene.swift
//  MagnicView
//
//  Created by 迟钰林 on 2017/6/20.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit
import SpriteKit

let KScreenW = UIScreen.main.bounds.width
let KScreenH = UIScreen.main.bounds.height

class MagnicScene: SKScene {
    //场移动的距离比例
    let fieldMoveFactor : CGFloat = 0.5
    
    var numOfCircle: NSInteger = 0{
        
        didSet{
            updateScene()
        }
    }
    
    let circieR : CGFloat = 40
    
    public lazy var radialForce : SKFieldNode = { [unowned self] in
        let field = SKFieldNode.radialGravityField()
        field.minimumRadius = 2000
        field.strength = 500
        field.region = SKRegion.init(radius: 2000)
        return field
    }()
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        self.physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)

        radialForce.position = CGPoint.init(x: size.width/2, y: size.height/2)
        self.addChild(radialForce)
    }
    
    func updateScene() {
        
        for i in 0 ..< numOfCircle {
            
            let circle = MagnicNode.init(circleOfRadius: circieR)
            circle.position = CGPoint.init(x: i * 40, y: i * 60)
            circle.isSelected = false
            setPhysicBody(node: circle)
            self.randomAddChild(circle)
        }
    }
    
    func setPhysicBody(node: SKNode) {
        let body = SKPhysicsBody(circleOfRadius: circieR)
        body.allowsRotation = false
        body.friction = 0
        body.linearDamping = 3
        body.restitution = 0.8
        node.physicsBody = body
    }
    
    open func randomAddChild(_ node: SKNode) {
        var x = -node.frame.width // left
        if children.count % 2 == 0 {
            x = frame.width + node.frame.width // right
        }
        let y = CGFloat.random(node.frame.height, frame.height - node.frame.height)
        node.position = CGPoint(x: x, y: y)
        super.addChild(node)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var touchedNode: MagnicNode? = nil
    var lastPoint: CGPoint = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let position = touch?.location(in: self)
        lastPoint = position!
        let touchedNodes = nodes(at: position!) as! [MagnicNode]
        touchedNodes.forEach { (node) in
            touchedNode = node
            touchedNode?.isSelected = !(touchedNode?.isSelected)!
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let position = touch?.location(in: self)
        if touchedNode != nil {
            touchedNode?.position = position!
        }
        
        //拖动空白处时
        if touchedNode == nil{
            radialForce.position.x += (((position?.x)! - lastPoint.x)) * fieldMoveFactor
            radialForce.position.y += (((position?.y)! - lastPoint.y)) * fieldMoveFactor
        }
        
        lastPoint = position!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedNode = nil
    }
    
}











