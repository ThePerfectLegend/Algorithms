//
//  DownloadingImageView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: ImageLoadingPresentor
    
    init(url: String) {
        _loader = StateObject(wrappedValue: ImageLoadingPresentor(url: url))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}
