//
//  Video.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 27/12/2022.
//

import Foundation

struct Video: Decodable, Identifiable {
    var id: String { return video_id }

    let video_id: String
    let title: String
    let embed_url: URL
    let url: URL
    let thumb: URL
    let rating: String
    let views: Int
    let duration: String
}
