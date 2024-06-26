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
        }.scrollIndicators(.hidden)
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
        }
    }
    
    private var asyncImageView: some View {
        ZStack {
            if let cachedImage = ImageCache.shared.getImage(forKey: photo.id as NSString) {
                Image(uiImage: cachedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200, alignment: .top)
            } else {
                AsyncImage(url: photo.urls.small) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200, alignment: .top)
                } placeholder: {
                    ProgressView()
                }
                .onAppear {
                    cacheImage()
                }
            }
            if photo.isFavourite ?? false {
                isFavoritedView
            }
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    private var isFavoritedView: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                ZStack{
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 30)
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            .padding(10)
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
    private func cacheImage() {
        URLSession.shared.dataTask(with: photo.urls.small) { data, _, error in
            guard let data = data, error == nil else { return }
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.setImage(uiImage, forKey: photo.id as NSString)
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
