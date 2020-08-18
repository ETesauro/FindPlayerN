//
//  ErrorView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var show : Bool
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    Image("error")
                        .resizable()
                        .frame(height: 250)
                        //                        .cornerRadius(25)
                        .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                    
                    VStack {
                        
                        HStack {
                            
                            //BOTTONE CUORE
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            })
                            
                            Spacer()
                            
                            //BOTTONE PER CHIUDERE
                            Button(action: {
                                withAnimation(.spring()) {
                                    show.toggle()
                                }
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            })
                            
                        }
                        .padding()
                        // since all edges are ignored....
                        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    }
                    
                }
                
                // Details View...
                
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("selected.name")
                            .font(.title)
                        
                        Image(systemName: "heart.fill")
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.bottom)
                
            }
            .background(Color.white)
            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
            
            Spacer(minLength: 0)
            
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
