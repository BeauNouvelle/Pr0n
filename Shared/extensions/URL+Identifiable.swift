//
//  URL+Identifiable.swift
//  Pr0n
//
//  Created by Beau Nouvelle on 27/12/2022.
//

import Foundation

extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}
