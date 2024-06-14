//
//  PhotoDetailsView.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import SwiftUI

struct PhotoDetailsView: View {
    @StateObject var viewModel: PhotoDetailsViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.photo.urls.regular) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .padding(20)
            
            VStack(alignment: .leading, spacing: 20){
                Text(viewModel.photo.alt_description)
                Label(viewModel.photo.user.name, systemImage: "person.fill")
                Label(viewModel.photo.user.location ?? "N/A", systemImage: "pin.fill")
            }
            .foregroundColor(.secondary)
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    PhotoDetailsView(viewModel: PhotoDetailsViewModel(photo: Photo(id: "h-jIyccjUwU", alt_description: "a woman in a black jacket is posing for a picture", urls: .init(small: URL(string: "https://images.unsplash.com/photo-1717765697742-6b2f48f4a1fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjI2NTd8MHwxfGFsbHw0fHx8fHx8Mnx8MTcxODM5NDUyNnw&ixlib=rb-4.0.3&q=80&w=400")!, regular: URL(string: "https://images.unsplash.com/photo-1717765697742-6b2f48f4a1fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjI2NTd8MHwxfGFsbHw0fHx8fHx8Mnx8MTcxODM5NDUyNnw&ixlib=rb-4.0.3&q=80&w=1080")!), user: .init(username: "nick_pliachas", name: "Nick Pliahas", bio: nil, location: nil), isFavourite: true)))
}
