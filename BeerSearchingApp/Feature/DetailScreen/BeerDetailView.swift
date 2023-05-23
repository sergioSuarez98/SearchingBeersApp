//
//  BeerDetailView.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 23/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BeerDetailView: View {
    let id: Int
    @ObservedObject var presenter = BeerDetailPresenter()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                // Image
                if(presenter.isLoading){
                    ZStack {
                        Color.white
                            .edgesIgnoringSafeArea(.all)
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1)
                            .foregroundColor(.blue)
                            .padding(50)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        
                    }
                }else{
                    if let imageUrl = presenter.beer?.imageUrl {
                        WebImage(url: URL(string: imageUrl))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .cornerRadius(12)
                    }
                }
                // Name
                Text(presenter.beer?.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Description
                Text(presenter.beer?.description ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(16)
        }
        .navigationTitle(presenter.beer?.name ?? "Detalle")
        .onAppear {
            presenter.requestBeer(id: id)
        }
    }
}
