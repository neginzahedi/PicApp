//
//  ContentView.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = PhotosListViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(){
            viewModel.fetchImages()
        }
    }
}

#Preview {
    ContentView()
}
