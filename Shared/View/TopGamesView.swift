//
//  TopGamesView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 12/08/20.
//

import SwiftUI

struct TopGamesView : View {
    
    //MARK: - PROPERTIES
    @State private var topGames = [TopGames]()
    
    var animation : Namespace.ID
    @Binding var show : Bool
    @Binding var selected : Game
    
    
    //MARK: - BODY
    var body: some View {
        
        // SCROLLVIEW
        ScrollView(.vertical, showsIndicators: false) {
            
            
            // MAIN VSTACK
            VStack (spacing: 15){
                
                
                //HSTACK PER LA SCRITTA SOPRA E LA LENTE DI INGRANDIMENTO
                HStack{
                    
                    Text("Discover a \nNew Friend")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color("top"))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {

                        Image("Search")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("top"))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                // since all edges are ignored....
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                
                // SCROLLVIEW ORIZZONTALE PER LE ICONCINE SOPRA
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    // HSTACK
                    HStack(spacing: 15){
                        
                        // FOREACH
                        ForEach(1...6,id: \.self){i in
                            
                            Image("c\(i)")
                                .resizable()
                                .renderingMode(.original)
                                .scaledToFit()
                                .frame(height: 50)
                                .onTapGesture {
                                    
                                    // do some stuff....
                                }
                        } //: FOREACH
                        
                    } //: HSTACK
                    .padding(.horizontal)
                    
                } //: SCROLLVIEW
                
                
                // HSTACK PER LA SCRITTA TopGames E SeeAll
                HStack{
                    
                    Text("Top Games")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("top"))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        
                        Text("See All")
                            .foregroundColor(.gray)
                    }
                } //: HSTACK
                .padding(.horizontal)
                
                
                // FOREACH
                ForEach(gamesData, id: \.game.id) { item in
                    
                    
                    // ZSTACK
                    ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)){
                        
                        Image(item.game.image)
                            .resizable()
                            .frame(height: 200)
                            .cornerRadius(25)
                            .matchedGeometryEffect(id: item.game.image, in: animation)
                            .padding(.horizontal)
                        
//                        Text(item.game.name)
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .matchedGeometryEffect(id: item.game.name, in: animation)
//                            .padding()
//                            .background(Color("top"))
//                            .clipShape(Capsule())
                    } //: ZSTACK
                    .padding(.bottom, 25)
                    .onTapGesture {
                        withAnimation(.spring()){
                            selected = item.game
                            show.toggle()
                        }
                    } //: ONTAPGESTURE
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 2, x: 4, y: 4)
                    
                } //: FOREACH
                
            } //: VSTACK
            
        } //: SCROLLVIEW
        .statusBar(hidden: true)
    }
}

