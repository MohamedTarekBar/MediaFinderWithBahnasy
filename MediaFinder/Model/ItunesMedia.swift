//
//  ItunesMedia.swift
//  Test
//
//  Created by MohamedTarek on 26/12/2020.
//

import UIKit

struct ItunesMedia: Codable {
    var resultCount: Int
    var results: [Media]
}

struct Media: Codable {
    var artworkUrl100: String?
    var artistName: String?
    var trackName: String?
    var longDescription: String?
    var previewUrl:String?
    var kind: dataType.RawValue?
}

enum dataType: String {
    case music = "song"
    case tv = "tv-episode"
    case movie = "feature-movie"
}
