//
//  AddToDBButtonView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 18/08/2020.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


struct AddToDBButtonView: View {
    
    //MARK: - PROPERTIES
    @Binding var selected : Game
    let db = Firestore.firestore()
    
    
    //MARK: - BODY
    var body: some View {
        
        Button(action: {
            // Add a new document with a generated ID
            let richiesteRef = db.collection("RichiesteDiGioco")
            var maxCount = 0
            
            richiesteRef.getDocuments() { (querySnapshot, err) in
                maxCount = querySnapshot!.count + 1
                print(maxCount)
                
                richiesteRef.document("\(selected.name.prefix(3))\(maxCount)").setData([
                    "titolo": selected.name,
                    "console":"PS4",
                    "giocatore":Auth.auth().currentUser!.email!,
                    "id":maxCount
                ])
                
                print("Richiesta effettuata")
                
            } //: GETDOCUMENTS
            
        }) //: BUTTON
        {
            Text("Fai richiesta")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
                .background(Color("top"))
                .clipShape(Capsule())
        }
        .padding(.vertical,22) //:MODIFIERS
    }
}
