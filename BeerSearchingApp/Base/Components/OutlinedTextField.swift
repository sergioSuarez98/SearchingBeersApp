//
//  OutlinedTextField.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation
import SwiftUI

struct OutlinedTextField: View {
    
    var placeholder: String
    var text: Binding<String>
    var error:Binding<String>
    var keyboardType: UIKeyboardType = .default
    var icon: String = ""
    var iconColor: Color = Color.gray
    var iconTapped: () -> () = {}
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            ZStack(alignment: .leading){
                Text(placeholder)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14,weight: .regular,design: .default))
                    .padding(.horizontal,2)
                    .background(Rectangle().fill(Color.white))
                    .padding(.leading,12)
                    .offset(y: text.wrappedValue.isEmpty ? 0 : -32)
                    .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.7,anchor: .leading)
                    .zIndex(text.wrappedValue.isEmpty ? 0 : 1)
                    .animation(.easeInOut, value: text.wrappedValue.isEmpty)
                
                HStack {
                    TextField("", text: text)
                        .autocapitalization(.none)
                        .keyboardType(keyboardType)
                        .zIndex(text.wrappedValue.isEmpty ? 1 : 0)
                    Button(action: { iconTapped()}) {
                        Image(systemName: icon)
                            .resizable()
                            .foregroundColor(iconColor)
                            .frame(width: 18,height: 18)
                            .padding(.trailing, 16)
                    }
                    /*if !icon.isEmpty {
                        if text.wrappedValue.isEmpty {
                            Button(action: { iconTapped()}) {
                                Image(systemName: icon)
                                    .resizable()
                                    .foregroundColor(iconColor)
                                    .frame(width: 18,height: 18)
                                    .padding(.trailing, 16)
                            }
                        }
                    }*/
                    if !error.wrappedValue.isEmpty {
                        Image(systemName: "info.circle")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 18,height: 18)
                            .padding(.trailing, 16)
                            .transition(.opacity)
                    }
                }
                .foregroundColor(Color.gray)
                .font(.system(size: 14,weight: .regular,design: .default))
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .padding(.leading,12)
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color(error.wrappedValue.isEmpty ? .gray : .red),lineWidth: 1))
            }
            
            
            if !error.wrappedValue.isEmpty {
                Text(error.wrappedValue)
                    .foregroundColor(Color.red)
                    .font(.caption)
                    .padding(.top,4)
                    .transition(.opacity)
                frame(height: 10)
            }
        }
    }
}


