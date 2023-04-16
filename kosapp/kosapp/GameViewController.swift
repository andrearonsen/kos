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
        
        let dictCat = readDictionaryCatalog()
        print(dictCat.forNumberOfInputLetters(nrInputLetters: 4).countWords())
        var board = Board(width: 9, height: 6)
        
        let dir = board.canPlaceWord(row: 0, col: 0, word: "hallo")
        board.placeWord(row: 0, col: 0, dir: dir, word: "hallo")
        board.printBoard()
        
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
