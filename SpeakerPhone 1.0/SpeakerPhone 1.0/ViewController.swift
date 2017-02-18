//
//  ViewController.swift
//  SpeakerPhone 1.0
//
//  Created by Addisalem Kebede on 2/4/17.
//  Copyright © 2017 Addisalem Kebede. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
class ViewController: UIViewController, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var songTitleOutlet: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var songProgressOutlet: UIProgressView!
    
    var songs:[String] = ["sample1","sample2","sample3","sample4"]
    
    var songNumberPlaying = 0
    
    var currentSong:String?
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentSong = songs[songNumberPlaying]
        //songNumberPlaying = songNumberPlaying + 1
        
        songTitleOutlet.text = currentSong
        
        do
        {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: currentSong, ofType: "mp3")!))
            
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        

        let currentTime = audioPlayer.currentTime
        let songDuration = audioPlayer.duration
        let progression:Double = currentTime/songDuration
        print("CT:" , currentTime)
        print("SD:" ,songDuration)
        print("P:", progression)
        
        songProgressOutlet.setProgress(Float(progression), animated: true)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  
    // enable/disable button
    
    
    func updateProgress(){
        let currentTime = audioPlayer.currentTime
        let songDuration = audioPlayer.duration
        let progression:Double = currentTime/songDuration
        print("CT:" , currentTime)
        print("SD:" ,songDuration)
        print("P:", progression)
        
        songProgressOutlet.setProgress(Float(progression), animated: true)
    }
    
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        if flag == true
        {
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: currentSong, ofType: "mp3")!))
                
                audioPlayer.prepareToPlay()
            }
            catch{
                print(error)
            }
            
            skipButtonTapped(self)
            audioPlayer.play()
        }
    }
    
    
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        
        if audioPlayer.isPlaying
        {
            audioPlayer.stop()
            playPauseButton.setTitle("Play", for: .normal)
            
        }
        else
        {
            audioPlayer.play()
            playPauseButton.setTitle("Pause", for: .normal)
            let currentTime = audioPlayer.currentTime
            let songDuration = audioPlayer.duration
            let progression:Double = currentTime/songDuration
            
            songProgressOutlet.setProgress(Float(progression), animated: true)
        }
   
        audioPlayerDidFinishPlaying(audioPlayer, successfully: audioPlayer.isPlaying)
//      var a = #selector(self.updateProgress)
    }
    
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        if audioPlayer.isPlaying
        {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            audioPlayer.play()
        }
        
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        if(songNumberPlaying < songs.count)
        {
            currentSong = songs[songNumberPlaying]
            songTitleOutlet.text = currentSong
            songNumberPlaying = songNumberPlaying + 1
        }
        else
        {
            songNumberPlaying = 0
            currentSong = songs[songNumberPlaying]
            songTitleOutlet.text = currentSong
            songNumberPlaying = songNumberPlaying + 1
            
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        if(audioPlayer.isPlaying)
        {
            audioPlayer.stop()
        }
        audioPlayer.currentTime = 0
        playPauseButton.setTitle("Play", for: .normal)
        
    }
    
    @IBAction func volumeSliderMoved(_ sender: UISlider) {
        audioPlayer.volume = sliderOutlet.value
        //print(audioPlayer.volume)
        //audioPlayer.play()
    }
    
    @IBAction func pickSongsButtonTapped(_ sender: Any) {
        
        let songPickerController = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        songPickerController.delegate = self
        songPickerController.allowsPickingMultipleItems = false
        songPickerController.showsCloudItems = true
        
        
        let query = MPMediaQuery()
        
        let result = query.collections //getting an mediaItem array
        var savedSongs:[MPMediaItem] = []
        var iCloudSongs:[MPMediaItem] = []
        
        for album in result!//
        {
            for song in album.items
            {
                print("Title: \(song.title) \nCloudItem: \(song.isCloudItem) \nSongUrl: \(song.assetURL)") // \(song.assetURL)")
                
                if song.assetURL != nil
                {
                    savedSongs.append(song)//if song has a url then add it to
                }
                if song.isCloudItem == true
                {
                    iCloudSongs.append(song)
                }
                
                //\(AVURLAsset(url: song.assetURL!))")
                
            }
        }
        print("*********************************************")
        print("*********************************************")
        print("*********************************************")
        
        for i in savedSongs{
            print("Title: \(i.title) \nCloudItem: \(i.isCloudItem) \nSongUrl: \(i.assetURL)")
        }
        
        print("*********************************************")
        print("*********************************************")
        print("*********************************************")
        
        for i in iCloudSongs
        {
            print("Title: \(i.title) \nCloudItem: \(i.isCloudItem) \nSongUrl: \(i.assetURL)")
        
        }
    }
}

