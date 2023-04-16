//
//  GameViewController.swift
//  kosapp
//
//  Created by André Fagerlie Aronsen on 15/04/2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fileUrl = Bundle.main.url(forResource: "dict34", withExtension: "txt") else {
            fatalError("Not able to create URL")
        }
        
        var dict = ""
        do {
            dict = try String(contentsOf: fileUrl)
        } catch {
            assertionFailure("Failed reading from URL: \(fileUrl), Error: " + error.localizedDescription)
        }
        let words = dict
             .split(separator: "\n")
             .map(String.init)
        print(words.count)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
