//
//  PronModel.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 13/7/21.
//

import Foundation
import Combine

final class PronModel: ObservableObject {
    
    var cancellable: AnyCancellable?
    var searchCancellable: AnyCancellable?
    @Published var pron: Pron = Pron(videos: [])
    @Published var searchText: String = ""
    
    init() {
        searchCancellable = AnyCancellable(
              $searchText
                .removeDuplicates()
                .debounce(for: 0.5, scheduler: DispatchQueue.main)
                .sink { searchText in
                  self.search()
              })
    }
    
    func search() {
        cancellable?.cancel()
        
        let urlQueries = [
            URLQueryItem(name: "data", value: "redtube.Videos.searchVideos"),
            URLQueryItem(name: "output", value: "json"),
            URLQueryItem(name: "search", value: searchText),
            URLQueryItem(name: "thumbsize", value: "medium")
        ]
        
        var components = URLComponents(string: "https://api.redtube.com/")!
        components.queryItems = urlQueries
        
        let request = URLRequest(url: components.url!)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Pron.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] finished in
                switch finished {
                case .failure(let error):
                    self?.report(error: error)
                case .finished:
                    print("DONE!")
                }
            } receiveValue: { [weak self] pron in
                self?.pron = pron
            }
    }
    
    func report(error: Error) {
        #if DEBUG
        if case let DecodingError.keyNotFound(key, context) = error {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
        }
        if case let DecodingError.valueNotFound(type, context) = error {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        }
        if case let DecodingError.typeMismatch(type, context) = error {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        }
        if case let DecodingError.dataCorrupted(context) = error {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
        }
        #endif
    }
    
}
