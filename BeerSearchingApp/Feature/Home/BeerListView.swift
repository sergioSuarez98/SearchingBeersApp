//
//  BeerListView.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BeerListView: View {
    
    @ObservedObject var presenter = BeerPresenter()
    @State private var searchQuery = ""
    var body: some View {
        VStack{
            OutlinedTextField(placeholder: "Búsqueda", text: $presenter.text, error: $presenter.error, icon: "magnifyingglass.circle",iconColor: Color.gray,iconTapped: {
                presenter.requestBeersFiltered(query: presenter.text)
            })
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            if !presenter.beers.isEmpty{
                ScrollView{
                    ForEach(presenter.beers, id: \.id) { beer in
                        BeerCardView(item: beer)
                    }
                    
                }
            }else{
                Spacer()
                
                Text(presenter.error)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 15)
        .background(Color.gray.opacity(0.2))
        .onAppear(){
            presenter.requestBeers()
        }
    }
    
}

struct BeerCardView: View {
    var item : BeerViewModel
    var body : some View {
        HStack(alignment: .top){
            WebImage(url: URL(string: item.imageUrl))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 130, height: 130)
            VStack(alignment: .leading){
                Text(item.name)
                    .font(.headline)
                    .bold()
                    .lineLimit(2)
                    .padding(.top, 6)
                    .padding(.bottom, 4)
                Text(item.description)
                    .font(.caption)
                    .lineLimit(4)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
}
