//
//  VideoRow.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 27/12/2022.
//

import Foundation
import SwiftUI

struct VideoRow: View {

    let video: Video

    var body: some View {
        ZStack {
            AsyncImage(url: video.thumb) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
            } placeholder: {
                ZStack {
                    AngularGradient(colors: [.teal, .red], center: .center)
                    Rectangle().fill(.thickMaterial)
                }
                .frame(height: 200)
            }
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Rectangle().fill(.ultraThinMaterial)
                    Text(video.title)
                        .padding(5)
                }
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(8)
                .padding(5)
            }
        }
        .frame(minHeight: 100)
    }
}
