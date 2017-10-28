//
//  ViewController.swift
//  Sayi Kapmaca
//
//  Created by Furkan on 6/21/17.
//  Copyright © 2017 Furkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 50
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
        updateLabels()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        
       let difference = abs(targetValue - currentValue)
        //abs negatif de olsa pozitif cikartir	
        var points = 100 - difference
        
        
        let title: String
        if difference == 0 {
            if round < 2 {
                title = "Vaay"
                points += 200
            }
            else{
            title = "Tam Isabet!!"
            points += 100
            }
        }
        else if difference < 5 {
            if round < 5 {
                title = "Öğrenmeye başlıyorsun.."
                points -= 50
            }
            else {
                title = "Ahh!! Neredeyse.."
                points -= 40
            }
        }
        else if difference < 10 {
            title = "Gözlere bir baktır.."
            points -= 80
        }
        else {
            if round < 2 {
                title = "Yenisin olur öyle şeyler.."
            }
            else {
            title = "Sabri.. sen misin?"
                points -= 150
            }
        }
        score += points
        
        let message = "\(points) Puan \n\(difference)'yle kaçtı"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Devam", style: .default, handler: { action in self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    @IBAction func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame(){
        round = 0
        score = 0
        startNewRound()
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
}
