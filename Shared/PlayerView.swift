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
    @State var player = AVPlayer()

    var body: some View {
        VStack {
            VideoPlayer(player: player)
        }
        .onAppear {
            if let url {
                loadVideo(url: url)
            }
        }
        .onDisappear {
            player.pause()
        }
    }

    func loadVideo(url: URL) {
        DispatchQueue.global(qos: .background).async {
            let contents = try? String(contentsOf: url)
            let someUrl = contents!.slice(from: "videoUrl\":\"", to: "\"}") ?? ""
            guard let url = URL(string: someUrl.replacingOccurrences(of: "\\", with: "")) else { return }
            DispatchQueue.main.async {
                player = AVPlayer(url: url)
                player.play()
            }
        }
    }

}
