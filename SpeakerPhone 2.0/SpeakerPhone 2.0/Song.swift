//
//  Song.swift
//  SpeakerPhone 2.0
//
//  Created by Addisalem Kebede on 2/4/17.
//  Copyright © 2017 Addisalem Kebede. All rights reserved.
//

import Foundation
import UIKit
class Song
{
    var title:String?
    var lengthInSeconds:Int?
    var artist:String?
    var artwork:UIImage?
    
    init(title: String, lengthInSeconds:Int, artist:String, artwork:UIImage)
    {
        self.title = title
        self.lengthInSeconds = lengthInSeconds
        self.artist = artist
        self.artwork = artwork
    }
}
