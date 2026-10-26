//
//  ViewController.swift
//  shakeShuffule
//
//  Created by Bibek Shrestha on 2/23/19.
//  Copyright © 2019 Bibek Shrestha. All rights reserved.
//

import UIKit
import AVFoundation

var randomNumber = 0
class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var previousSong = randomNumber
    var player = AVAudioPlayer()
    var songs = ["track1","track2","track3","track4","track5"]
    let images: [UIImage] = [
        UIImage(named: "image1")!,UIImage(named: "image2")!,UIImage(named: "image3")!,UIImage(named: "image4")!,UIImage(named: "image5")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = images[randomNumber]
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func playAudioFile(_ index: Int)
    {
        let audioPath = Bundle.main.path(forResource: songs[index], ofType: "mp3")
        do
        {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            player.delegate = self as? AVAudioPlayerDelegate
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.volume = 1
            player.play()
        }
        catch{print("error")}
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            print("Device was shaken")
            randomNumber = Int.random(in: 0 ... songs.count )
            imageView.image = images[randomNumber]
            playAudioFile(randomNumber)
            
        }
    }
    
    @objc func swipped(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right {
                
                print("Swipped to right")
                if (randomNumber < (songs.count-1)){
                    
                    previousSong = randomNumber
                    randomNumber = randomNumber + 1
                    playAudioFile(randomNumber)
                    imageView.image = images[randomNumber]
                    print(randomNumber)
                    //randomNumber = randomNumber + 1
                } else {
                    playAudioFile(0)
                    previousSong = (songs.count - 1)
                    randomNumber = 0
                    print(randomNumber)
                    imageView.image = images[randomNumber]
                    //randomNumber = randomNumber + 1
                }
                
            } else {
                print("Swipped to left")
                playAudioFile(previousSong)
                randomNumber = randomNumber - 1
                print(previousSong)
                imageView.image = images[previousSong]
                
            }
            
        }
        
        
    }

}

