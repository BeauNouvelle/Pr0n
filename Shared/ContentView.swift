//
//  ContentView.swift
//  Shared
//
//  Created by Beau Nouvelle on 13/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = PronModel()
    @State var selectedLink: URL?
    
    var body: some View {
        NavigationView {
            List(model.pron.videos) { video in
                NavigationLink {
                    PlayerView(url: video.embed_url)
                } label: {
                    VideoRow(video: video)
                        .clipped()
                }
            }
            .searchable(text: $model.searchText)
            .listStyle(.plain)
            .onAppear {
                model.search()
            }
            .frame(minWidth: 300)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
