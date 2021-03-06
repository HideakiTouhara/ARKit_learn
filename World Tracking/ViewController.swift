//
//  ViewController.swift
//  World Tracking
//
//  Created by HideakiTouhara on 2017/10/29.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuraiton = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuraiton)
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.1, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.3)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNCylinder(radius: 0.1, height: 0.3)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0,0,-0.3)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuraiton, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(secondNum, firstNum)
    }
    
    
}

