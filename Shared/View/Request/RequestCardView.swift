//
//  RequestCardView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 19/08/2020.
//

import SwiftUI

struct RequestCardView: View {
    //MARK: - PROPERTIES
    var richiestaDiGioco: RichiestaDiGioco
    
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all)
            
            VStack (alignment: .leading) {
                
                HStack {
                    Text(richiestaDiGioco.titolo)
                        .font(.title)
                        .lineLimit(nil)
                    
                    Spacer()
                    
                    Text(richiestaDiGioco.console)
                        .fontWeight(.bold)
                }
                
                Text(richiestaDiGioco.giocatore)
            }
            .padding()
            .foregroundColor(.white)
            
        }
//        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom))
        
    }
}


//MARK: - PREVIEW
struct RequestCardView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCardView(richiestaDiGioco: RichiestaDiGioco(id: 3, console: "PS4", giocatore: "Manu", titolo: "Fortnite"))
    }
}
