//
//  PlayerView.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 27/12/2022.
//

import Foundation
import SwiftUI
import AVKit

struct PlayerView: View {

    var url: URL?
    @State var newUrl: URL?

    var body: some View {
        VStack {
            if let newUrl = newUrl {
                VideoPlayer(player: AVPlayer(url: newUrl))
            } else {
                Text("Loading")
            }
        }
        .onAppear {
            if let url {
                loadVideo(url: url)
            }
        }
    }

    func loadVideo(url: URL) {
        DispatchQueue.global(qos: .background).async {
            let contents = try? String(contentsOf: url)
            let someUrl = contents!.slice(from: "videoUrl\":\"", to: "\"}") ?? ""
            let url = URL(string: someUrl.replacingOccurrences(of: "\\", with: ""))
            DispatchQueue.main.async {
                newUrl = url
            }
        }
    }

}
