//
//  MainView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 12/08/20.
//

import SwiftUI
import Firebase

struct MainView : View {
    
    @State var tab = "Explore"
    @Namespace var animation
    @State var show = false
    @State var selected : Game = gamesData[0].game
    
    
    @AppStorage("log_Status") var status = false
    @StateObject var model = ModelData()
    
    
    var body: some View{
        
        ZStack{
            
            if status {
                
                VStack(spacing: 0){
                    
                    // changing Views Based On tab....
                    switch(tab){
                        case "Explore": TopGamesView(animation: animation, show: $show, selected: $selected)
                        case "Search": SearchView()
                        default: ProfileView(model: model)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0){
                        
                        tabButton(title: "Explore", tab: $tab)
                        
                        Spacer(minLength: 0)
                        
                        tabButton(title: "Search", tab: $tab)
                        
                        Spacer(minLength: 0)
                        
                        tabButton(title: "Account", tab: $tab)
                    }
                    .padding(.top)
                    // for smaller size iPhones....
                    .padding(.bottom,UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)
                    .padding(.horizontal,35)
                    .background(Color.white)
                    .clipShape(RoundedShape(corners: [.topLeft,.topRight]))

                }
                
            } else {
                
                LoginView(model: model)
                
            }
            
            
            
            // Detail View....
            if show{
                switch (selected.image.description) {
                case "cod" : CODDetailView(selected: $selected, show: $show, animation: animation, model: model)
                case "fortnite" : FortniteDetailView(selected: $selected, show: $show, animation: animation, model: model)
//                ...
                default:
                    //Da cambiare e mettere una pagina di errore
                    ErrorView(show: $show)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.white)
    }
}
