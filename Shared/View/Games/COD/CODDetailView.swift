//
//  CODDetailView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CODDetailView: View {
    
    //MARK: - PROPERTIES
    @Binding var selected : Game
    @Binding var show : Bool
    var animation : Namespace.ID
    
    //COD
    @State private var battle_royale_stats: [CODGameStats] = [CODGameStats]()
    @ObservedObject var model : ModelData
    
    //DATABASE
    let db = Firestore.firestore()
    @State private var richieste = [RichiestaDiGioco]()
    
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            
            // MAIN VSTACK
            VStack{
                
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
                    
                    // Details View...
                    HStack(alignment: .top){
                        
                        
                        //VSTACK PER LE INFO DEL GIOCO
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(selected.name)
                                .font(.title)
                            
//                            Image(systemName: "heart.fill")
//
//                            Image(systemName: "star.fill")
//                                .foregroundColor(.yellow)
                            
                            
                            // HSTACK PER IL BOTTONE PER FARE RICHIESTA
                            HStack {
                                Spacer(minLength: 0)
                                
                                AddToDBButtonView(selected: $selected)
                                
                                Spacer(minLength: 0)
                            } //: HSTACK
                            
                            
                            // VSTACK TEMPORANEO PER VEDERE I DATI PRESI DAL DB
                            VStack {
                                ForEach(richieste, id: \.id) { item in
                                    HStack {
                                        Text(item.titolo)
                                        Text("\(item.giocatore)")
                                        Text("\(item.console)")
                                    }
                                }
                            } //: VSTACK
                        } //:VSTACK
                        
                        Spacer(minLength: 0)
                    } //: HSTACK
                    .padding()
                    .padding(.bottom)
                    
                }
                .background(Color.white)
                .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                
                Spacer(minLength: 0)
                
            } //: MAIN VSTACK
            
            if model.isLoading{
                LoadingView()
            }
            
        } // :ZSTACK
        .background(Color.white)
        .onAppear(perform: {
            withAnimation {
                self.model.isLoading.toggle()
                loadCodRequests()
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
    
    
    func loadCodRequests() {
        db.collection("RichiesteDiGioco").whereField("titolo", isEqualTo: self.selected.name).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var array = [RichiestaDiGioco]()
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: RichiestaDiGioco.self)
                    }
                    
                    switch result {
                    case .success(let richiestaDiGioco):
                        if let richiesta = richiestaDiGioco {
                            // A `City` value was successfully initialized from the DocumentSnapshot.
                            print("Richiesta: \(richiesta)")
                            array.append(richiesta)
                            self.richieste = array
                        } else {
                            // A nil value was successfully initialized from the DocumentSnapshot,
                            // or the DocumentSnapshot was nil.
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        // A `City` value could not be initialized from the DocumentSnapshot.
                        print("Error decoding richiesta: \(error)")
                    }
                }
                self.model.isLoading.toggle()
            }
        }
    }
}
