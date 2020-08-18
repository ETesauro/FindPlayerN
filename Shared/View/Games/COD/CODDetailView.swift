//
//  CODDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import SwiftUI

struct CODDetailView: View {
    
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    //COD
    @State private var battle_royale_stats: [CODGameStats] = [CODGameStats]()
    @ObservedObject var model : ModelData

    
    
    var body: some View {
        ZStack {
            
            VStack{
                
                VStack{
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        Image(selected.image)
                            .resizable()
                            .frame(height: 250)
                            //                        .cornerRadius(25)
                            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                            .matchedGeometryEffect(id: selected.image, in: animation)
                        
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
                            
                            Text(selected.name)
                                .font(.title)
                            
                            Image(systemName: "heart.fill")
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            VStack {
                                ForEach(battle_royale_stats, id: \.title) { item in
                                    Text(item.title)
                                    Text("\(item.kills)")
                                    Text("\(item.wins)")
                                }
                            }
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
            
            if model.isLoading{
                LoadingView()
            }
        }
        .background(Color.white)
        .onAppear(perform: {
            withAnimation {
                self.model.isLoading.toggle()
                loadCodStats()
            }
        })
        
    }
    
    func loadCodStats() {
        guard let url = URL(string: "https://call-of-duty-modern-warfare.p.rapidapi.com/warzone/NonSoGiocare%252321564/battle") else {
            print("Invalid URL")
            return
        }
        
        let headers = [
            "x-rapidapi-host": "call-of-duty-modern-warfare.p.rapidapi.com",
            "x-rapidapi-key": "67b67c5966mshe3b9553a55ecd6cp1a694bjsn2cf8db3ffc06",
            "accept" : "application/json",
            "accept-encoding": "gzip deflate"
        ]
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    guard let json = try? JSONDecoder().decode(CODResponse.self, from: data) else {
                        print("Error during decoding")
                        return
                    } //: guard let json
                    //                    self.topGames = json.top
                    
                    let br = json.br
                    let br_dmz = json.br_dmz
                    let br_all = json.br_all
                    
                    let array = [br, br_dmz, br_all]
                    
                    //                    print(array)
                    self.battle_royale_stats = array
                    
                    self.model.isLoading.toggle()
                }//: Async
                return
            }//: IfData
            else { print("eh no") }
        }//: DataTask
        .resume()
    }
}