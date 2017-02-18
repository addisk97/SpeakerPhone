//
//  ViewController.swift
//  SpeakerPhone 2.0
//
//  Created by Addisalem Kebede on 2/4/17.
//  Copyright © 2017 Addisalem Kebede. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation
import MultipeerConnectivity


class ViewController: UIViewController, MPMediaPickerControllerDelegate, UINavigationControllerDelegate, MCSessionDelegate{
    
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID)
    {
        stream.schedule(in: .main, forMode: .defaultRunLoopMode)
        stream.open()
    }
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState)
    {
    }
    
    // Received data from remote peer.
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)
    {
    }
    
    // Received a byte stream from remote peer.
    
    
    // Start receiving a resource from remote peer.
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress)
    {
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?)
    {
        let destinationURL = URL(fileURLWithPath: "path/to/destination")
        do {
            try FileManager.default.moveItem(at: localURL, to: destinationURL)
        } catch {
            print("[Error] \(error)")
        }
    }
    
    
    
    //_ session: MCSession,  didReceive stream: InputStream,withName streamName: String,fromPeer peerID: MCPeerID)
    
    @IBOutlet weak var albumImageViewOutlet: UIImageView!
    @IBOutlet weak var songTitleOutlet: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickSongFromSongLibrary(_ sender: Any) {
        let songPickerController = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        songPickerController.delegate = self
        songPickerController.allowsPickingMultipleItems = false
        songPickerController.showsCloudItems = true
        
        
        let query = MPMediaQuery() //things in media library
        //let result1:[MPMediaItem]? = query.items
        
        
        let result = query.collections
        var songs:[MPMediaItem] = []
        var cloudItems:[MPMediaItem] = []
        
        /*      songTitleOutlet.text = String(describing: result?.count)
         
         //print(result?.count)
         
         */
        
        //adding the audio files that have assetUrl's to a list of MediaItems :songs
        
        for album in result!
        {
            for song in album.items
            {
                songTitleOutlet.text = song.title
                print("Title: \(song.title) \nCloudItem: \(song.isCloudItem) \nSongUrl: \(song.assetURL)") // \(song.assetURL)")
                
                if song.assetURL != nil
                {
                    songs.append(song)
                }
                if song.isCloudItem != true
                {
                    cloudItems.append(song)
                }
                //\(AVURLAsset(url: song.assetURL!))")
                
            }
        }
        
        //displaying the song title , if it is in the icloud library, the songs url
        print("*********************************ON-PHONE*******************************************")
        for i in songs{
             print("Title: \(i.title) \nCloudItem: \(i.isCloudItem) \nSongUrl: \(AVURLAsset(url: i.assetURL!))") // \
        }
        
        print("******************************ICLOUD LIBRARY*****************************************")
        
        for j in cloudItems{
            print("Title: \(j.title) \nSongUrl: \(AVURLAsset(url: j.assetURL!))") //
        }
        
        
        //var song: MPMediaItem = MPMediaItem.init(coder: NSData.init(contentsOf: audioPlayer.url))
        
        
        //var asset:AVURLAsset = AVURLAsset(url: song.assetURL!)
        
        
        var defaultURL = Bundle.main.url(forResource: "sample1", withExtension: "mp3")!
        
        var asset:AVURLAsset = AVURLAsset(url: defaultURL)
        
        print(asset.url)
        
        
        do{
            
            var assetReader:AVAssetReader = try AVAssetReader(asset: asset)// assetReaderWithAssetasset error:nil
            var assetOutput:AVAssetReaderTrackOutput = AVAssetReaderTrackOutput(track: asset.tracks[0], outputSettings: nil)
            //= [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:asset.tracks[0] outputSettings:nil];
            
            assetReader.add(assetOutput)// addOutput:self.assetOutput
            assetReader.startReading()
            
            var sampleBuffer:CMSampleBuffer = assetOutput.copyNextSampleBuffer()!
            var blockBuffer:CMBlockBuffer?
            
            var audioBufferList:AudioBufferList = AudioBufferList()
            
            CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(sampleBuffer, nil, &audioBufferList, MemoryLayout<AudioBufferList>.size, nil, nil, kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment, &blockBuffer)
            
            
            
            
            
            
            let buffers = UnsafeBufferPointer<AudioBuffer>(start: &audioBufferList.mBuffers,
                                                           count: Int(audioBufferList.mNumberBuffers))
            for buf in buffers {
                
                buf.mData
                buf.mDataByteSize
            }
            
            
        }
        catch
        {
            print(error)
        }
        
        
    }
    
    
    
    
    
    /*func session(_ session: MCSession,  didReceive stream: InputStream,withName streamName: String,fromPeer peerID: MCPeerID)
     {
     stream.delegate = self
     stream.schedule(in: .main, forMode: .defaultRunLoopMode)
     stream.open()
     }*/
    
    
}
