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
        NavigationView {
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.photos) { image in
                        ImageRowView(image: image)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                    }
                }
            }
            
            .navigationTitle("Pic App")
            .onAppear {
                viewModel.fetchImages()
            }
            .refreshable {
                viewModel.fetchImages()
            }
        }
    }
}

struct ImageRowView: View {
    var image: Photo
    
    var body: some View {
        VStack{
            ZStack{
                AsyncImage(url: image.urls.small) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            HStack{
                VStack(alignment: .leading){
                    Text(image.alt_description.capitalizedEachWord())
                        .font(.subheadline)
                    Spacer()
                    Text(image.user.name)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    
                }
                Spacer()
            }
            .padding(.vertical,10)
        }
        .background(.white)
    }
}

#Preview {
    ContentView()
}
