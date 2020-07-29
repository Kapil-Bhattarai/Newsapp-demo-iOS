//
//  CacheManager.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation
struct CacheManager {
    static var cache = [String: Data]()
    static func setVideoCache (_ url: String, _ data: Data) {
        cache[url] = data
    }
    static func getVideoCache (_ url: String ) -> Data? {
        return cache[url]
    }
}
