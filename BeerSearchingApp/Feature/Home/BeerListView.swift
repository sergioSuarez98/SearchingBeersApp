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
    ///Navigation view usado para realizar la navegación a la vista del detalle de cada cerveza
    var body: some View {
        NavigationView {
            VStack {
                OutlinedTextField(placeholder: "Búsqueda", text: $presenter.text, error: $presenter.error, icon: "magnifyingglass.circle", iconColor: Color.gray, iconTapped: {
                    presenter.requestBeersFiltered(query: presenter.text)
                })
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                if !presenter.beers.isEmpty {
                    List(presenter.beers) { beer in
                        NavigationLink(destination: BeerDetailView(id: beer.id)) {
                            BeerCardView(item: beer)
                                .padding(.vertical, 8)
                        }
                    }
                    .listStyle(.plain)
                    .padding(.horizontal, -16)
                    
                } else {
                    Spacer()
                    Text(presenter.error)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
            }
            .padding(.top, 16)
            .background(Color.gray.opacity(0.2))
            .navigationTitle("Listado de cervezas")
            .onAppear() {
                presenter.requestBeers()
            }
        }
    }
}

///Librería SDWebImageSwiftUi usada para mostrar las imagenes que vienen de la api a través de su url
struct BeerCardView: View {
    var item: BeerViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            WebImage(url: URL(string: item.imageUrl))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(3)
            }
            .padding(.horizontal, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
    
}
