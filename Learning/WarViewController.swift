//
//  File.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-04.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import UIKit

class WarViewController: UIViewController {
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    var cardArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardArray = ["card2", "card3", "card4", "card5", "card6", "card7", "card8",
                     "card9", "card10", "jack", "queen", "king", "ace"]
        winnerLabel.alpha = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dealTapped(sender:UIButton) {
        
        if(winnerLabel.alpha == 0)
        {
            winnerLabel.alpha = 1.0
        }
        
        
        let leftCardIndex = randCard()
        let rightCardIndex = randCard()
        
        leftImageView.image = UIImage(named:cardArray[leftCardIndex])!
        rightImageView.image = UIImage(named:cardArray[rightCardIndex])!
        
        scoreLabel(leftImageIndex: leftCardIndex, rightImageIndex: rightCardIndex)
        
    }
    
    func randCard() -> Int {
        let cardIndex = Int(arc4random_uniform(13))
        return cardIndex
        
    }
    
    func scoreLabel(leftImageIndex: Int, rightImageIndex: Int) {
        
        if(leftImageIndex > rightImageIndex) {
            var leftScore = Int(self.leftScoreLabel.text!)!
            leftScore += 1
            self.leftScoreLabel.text = "\(leftScore)"
            self.winnerLabel.text = "Player won!"
        }
            
        else if(rightImageIndex > leftImageIndex) {
            var rightScore = Int(self.rightScoreLabel.text!)!
            rightScore += 1
            self.rightScoreLabel.text = "\(rightScore)"
            self.winnerLabel.text = "CPU won!"
        }
            
        else {
            self.winnerLabel.text = "Tie"
        }
        
        
    }
    
    
    
}


