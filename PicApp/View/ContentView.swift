//
//  ContentView.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import SwiftUI

/// The main view displaying a list of photos fetched from the view model.
struct ContentView: View {
    
    @StateObject private var viewModel = PhotosListViewModel()
    
    var body: some View {
        NavigationView {
            PhotosListView(viewModel: viewModel)
                .navigationTitle("PicApp")
                .onAppear {
                    viewModel.fetchImages()
                }
                .refreshable {
                    viewModel.fetchImages()
                }
        }
    }
}

/// A view displaying a scrollable list of photos.
struct PhotosListView: View {
    
    @ObservedObject var viewModel: PhotosListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.photos) { photo in
                    NavigationLink {
                        PhotoDetailsView(viewModel: PhotoDetailsViewModel(photo: photo))
                    } label: {
                        PhotoRowView(photo: photo)
                            .tint(.primary)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                }
            }
        }
    }
}

/// A view representing each row in the photos list.
struct PhotoRowView: View {
    var photo: Photo
    
    var body: some View {
        VStack{
            asyncImageView
            photoTitlesView
                .padding(.vertical,10)
            if photo.isFavourite ?? false {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
    
    private var asyncImageView: some View {
        ZStack {
            AsyncImage(url: photo.urls.small) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    private var photoTitlesView: some View{
        HStack {
            VStack(alignment: .leading) {
                Text(photo.alt_description.capitalizedEachWord())
                    .font(.subheadline)
                
                Text(photo.user.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
