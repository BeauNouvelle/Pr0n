//
//  Pron.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 27/12/2022.
//

import Foundation

struct Pron: Decodable {
    let videos: [Video]

    init(videos: [Video]) {
        self.videos = videos
    }

    enum CodingKeys: CodingKey {
        case videos
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let videoWrappers = try container.decode([VideoWrapper].self, forKey: .videos)
        videos = videoWrappers.compactMap { $0.video }
    }
}
