//
//  MainView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 12/08/20.
//

import SwiftUI
import Firebase

struct MainView : View {
    
    //MARK: - PROPERTIES
    @State var tab = "Explore"
    @Namespace var animation
    @State var show = false
    @State var selected : Game = gamesData[0].game
    
    
    @AppStorage("log_Status") var userIsLogged = false
    @StateObject var model = ModelData()    
    
    
    //MARK: - BODY
    var body: some View{
        
        ZStack{
            
            // IF USERISLOGGED = TRUE -> VAI ALLA PAGINA PRINCIPALE
            if userIsLogged {
                
                
                // MAIN VSTACK
                VStack(spacing: 0){
                    
                    switch(tab){
                        case "Explore": TopGamesView(animation: animation, show: $show, selected: $selected)
                        case "Search": SearchView()
                        default: ProfileView(model: model)
                    }
                    
                    Spacer()
                    
                    //HSTACK PER I TAB BUTTON (IN FONDO ALLA PAGINA)
                    HStack(spacing: 0){
                        
                        tabButton(title: "Explore", tab: $tab)
                        
                        Spacer(minLength: 0)
                        
                        tabButton(title: "Search", tab: $tab)
                        
                        Spacer(minLength: 0)
                        
                        tabButton(title: "Account", tab: $tab)
                    } //: HSTACK
                    .padding(.top)
                    // for smaller size iPhones....
                    .padding(.bottom,UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)
                    .padding(.horizontal,35)
                    .background(Color.white)
                    .clipShape(RoundedShape(corners: [.topLeft,.topRight]))

                } //: VSTACK
                
            } //: IF
            
            //IF USERISLOGGED = FALSE -> DEVI FARE IL LOGIN
            else {
                
                LoginView(model: model)
                
            } //: ELSE
            
            
            
            // Detail View...
            if show{
                switch (selected.image.description) {
                case "cod" : CODDetailView(selected: $selected, show: $show, animation: animation, model: model)
                case "fortnite" : FortniteDetailView(selected: $selected, show: $show, animation: animation, model: model)
//                ...
                default:
                    //Da cambiare e mettere una pagina di errore
                    ErrorView(show: $show)
                }
                
            }//: IF SHOW
            
        } // :ZSTACK
        .edgesIgnoringSafeArea(.all)
        .background(Color.white)
    }
}
