//
//  ContentView.swift
//  Shared
//
//  Created by Beau Nouvelle on 13/7/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @StateObject var model = PronModel()
    @State var selectedLink: URL?
    
    var body: some View {
        NavigationView {
            List(model.pron.videos) { video in
                NavigationLink {
                    PlayerView(url: video.embed_url, newUrl: nil)
                } label: {
                    VideoRow(video: video)
                }
            }
            .listStyle(.plain)
            .searchable(text: $model.searchText)
            .onAppear {
                model.search()
            }
            .navigationTitle(Text("Pr0n"))
        }
    }

}

struct PlayerView: View {
    
    var url: URL
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
            loadVideo(url: url)
        }
    }
    
    func loadVideo(url: URL) {
        let contents = try? String(contentsOf: url)
        let someUrl = contents!.slice(from: "videoUrl\":\"", to: "\"}") ?? ""
        let url = URL(string: someUrl.replacingOccurrences(of: "\\", with: ""))
        print(url)
        newUrl = url
    }
    
}

import WebKit

extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}



extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}

struct VideoRow: View {
    
    let video: Video
    
    var body: some View {
        VStack {
            AsyncImage(url: video.thumb) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "cross")
                    .padding()
            }
            Text(video.title)
        }
        .frame(minHeight: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
