//
//  FortniteDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FortniteDetailView: View {
    
    //MARK: - PROPERTIES
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    //FORTNITE
    @State private var avatar: String = "https://cdn.thetrackernetwork.com/cdn/fortnite/6EF66474_small.png"
    @State private var username: String = ""
    @State private var fortnite_stats: [FortniteStatsDetails] = [FortniteStatsDetails]()
    
    //FIREBASE USER
    @ObservedObject var model : ModelData
    
    //DATABASE
    let db = Firestore.firestore()
    @State private var richiestePS4 = [RichiestaDiGioco]()
    @State private var richiesteXBOX = [RichiestaDiGioco]()
    @State private var richiestePC = [RichiestaDiGioco]()
    
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            
            
            ScrollView(.vertical) {
                
                //VSTACK
                VStack{
                    
                    
                    // ZSTACK PER L'HEADER
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        
                        // IMMAGINE
                        Image(selected.image)
                            .resizable()
                            .frame(height: 250)
                            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                            .matchedGeometryEffect(id: selected.image, in: animation)
                        
                        
                        // HSTACK PER I BOTTONI (CUORE E CHIUDI)
                        HStack {
                            
                            //BOTTONE CUORE
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        withAnimation {
                                            self.model.isLoading.toggle()
                                            loadFortniteRequests()
                                        }
                                    }
                            }) //: BUTTON
                            
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
                            }) //: BUTTON
                            
                        } //: HSTACK
                        .padding()
                        // since all edges are ignored....
                        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                        
                    } //: ZSTACK
                    
                    
                    //VSTACK PER LE INFO DEL GIOCO
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(selected.name)
                            .font(.title)
                        
                        
                        //                            //VSTACK DELLA FOTO E NOME
                        //                            HStack {
                        //
                        //                                URLImageView(urlString: avatar)
                        //
                        //                                Text(username)
                        //                                    .font(.headline)
                        //
                        //                                Spacer()
                        //                            }
                        //
                        //                            //VSTACK DELLE STATISTICHE (DA TOGLIERE DA QUI)
                        //                            HStack {
                        //                                ForEach(fortnite_stats, id: \.winRatio.value) { item in
                        //
                        //                                    VStack {
                        //                                        Text("SOLO")
                        //
                        //                                        Text(item.top1.label)
                        //                                        Text(item.top1.value)
                        //                                    }
                        //                                }
                        //                            }
                        
                        
                        // HSTACK PER IL BOTTONE PER FARE RICHIESTA
                        HStack {
                            Spacer(minLength: 0)
                            
                            AddToDBButtonView(selected: $selected)
                            
                            Spacer(minLength: 0)
                        } //: HSTACK
                        
                    } //:VSTACK
                    
                    
                } //: VSTACK
                
                VStack {
                    Text("PS4")
                    
                    ScrollView (.horizontal) {
                        HStack {
                            if(richiestePS4.isEmpty) {
                                Text("Le richieste per PS4 non esistono")
                            } else {
                                ForEach(richiestePS4, id: \.id) { item in
                                        RequestCardView(richiestaDiGioco: item)
//                                                    .frame(height: 150)
                                                    .cornerRadius(30)
                                }
                            }
                        }
                    }
                    
                    
                    Text("XBOX")
                    
                    ScrollView (.horizontal) {
                        HStack {
                            if(richiesteXBOX.isEmpty) {
                                Text("Le richieste per XBOX non esistono")
                            } else {
                                ForEach(richiesteXBOX, id: \.id) { item in
                                        RequestCardView(richiestaDiGioco: item)
                                                    .frame(height: 150)
                                                    .cornerRadius(30)
                                }
                            }
                        }
                    }

                    
                    Text("PC")
                    
                    ScrollView (.horizontal) {
                        HStack {
                            if(richiestePC.isEmpty) {
                                Text("Le richieste per PC non esistono")
                            } else {
                                ForEach(richiestePC, id: \.id) { item in
                                        RequestCardView(richiestaDiGioco: item)
                                                    .frame(height: 150)
                                                    .cornerRadius(30)
                                }
                            }
                        }
                    }
                }

                
//                // MAIN VSTACK
//                VStack{
//
//
//
//                    Spacer(minLength: 0)
//
//                } //: MAIN VSTACK
                
            } //: SCROLLVIEW
            
            if model.isLoading{
                LoadingView()
            }
            
        } // :ZSTACK
        .background(Color.white)
        .onAppear(perform: {
            self.model.isLoading.toggle()
            loadFortniteRequests()
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
    
    
    func loadFortniteRequests() {
        
        let gamequery: Query = db.collection("RichiesteDiGioco").whereField("titolo", isEqualTo: self.selected.name)
        
//        var array = [RichiestaDiGioco]()
        var arrayPS4 = [RichiestaDiGioco]()
        var arrayXBOX = [RichiestaDiGioco]()
        var arrayPC = [RichiestaDiGioco]()
        
        //CERCO TUTTE LE RICHIESTE PER IL GIOCO IN QUESTIONE E LE SALVO IN ARRAY1
        gamequery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: RichiestaDiGioco.self)
                    }
                    
                    switch result {
                    case .success(let richiestaDiGioco):
                        if let richiesta = richiestaDiGioco {
                            switch richiesta.console {
                            case "PS4":
                                arrayPS4.append(richiesta)
                            case "XBOX":
                                arrayXBOX.append(richiesta)
                            case "PC":
                                arrayPC.append(richiesta)
                            default:
                                print("console non riconosciuta")
                            }
//                            array.append(richiesta)
//                            self.richieste = array
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding richiesta: \(error)")
                    }
                }
                
                self.richiestePS4 = arrayPS4
                self.richiestePC = arrayPC
                self.richiesteXBOX = arrayXBOX
                
                self.model.isLoading.toggle()
            }
        }
    }
}
