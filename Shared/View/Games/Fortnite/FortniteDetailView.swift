//
//  FortniteDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import SwiftUI

struct FortniteDetailView: View {
    
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    //Fortnite

    @State private var avatar: String = "https://cdn.thetrackernetwork.com/cdn/fortnite/6EF66474_small.png"
    @State private var username: String = ""
    @State private var fortnite_stats: [FortniteStatsDetails] = [FortniteStatsDetails]()
    
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
                            
    //                        Image(systemName: "heart.fill")
    //
    //                        Image(systemName: "star.fill")
    //                            .foregroundColor(.yellow)
                            
                            HStack {
                                
                                URLImageView(urlString: avatar)
                                
                                Text(username)
                                    .font(.headline)
                                
                                Spacer()
                            }
                            
                            HStack {
                                ForEach(fortnite_stats, id: \.winRatio.value) { item in
                                    
                                VStack {
                                    Text("SOLO")
                                    
                                    Text(item.top1.label)
                                    Text(item.top1.value)
                                }

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
            self.model.isLoading.toggle()
            loadFortniteStats()
        })
    }
    
    func loadFortniteStats() {
        guard let url = URL(string: "https://api.fortnitetracker.com/v1/profile/kbm/NonSoGiocare_") else {
            print("Invalid URL")
            return
        }
        
        let headers = [
            "TRN-API-Key": "cdfe7b9d-0572-4fb9-bac3-148a358407aa",
            "accept" : "application/json",
            "accept-encoding": "gzip deflate"
        ]
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    guard let json = try? JSONDecoder().decode(FortniteResponse.self, from: data) else {
                        print("Error during decoding")
                        return
                    } //: guard let json
                    
                    
                    
                    let solo = json.stats.p2
                    let duos = json.stats.p9
                    let team = json.stats.p10
                    
                    let array = [solo, duos, team]
                    
                    self.fortnite_stats = array
                    
                    self.username = json.epicUserHandle
                    self.avatar = json.avatar
                    
                    self.model.isLoading.toggle()
                    
                }//: Async
                return
            }//: IfData
            else { print("eh no") }
        }//: DataTask
        .resume()
    }
}
