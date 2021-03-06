//
//  URLImageView.swift
//  TwitchTest (iOS)
//
//  Created by Emmanuel Tesauro on 11/08/20.
//

import SwiftUI

struct URLImageView: View {
    
    //MARK: - PROPERTIES
    @ObservedObject var urlImageModel: URLImageModel
    
    
    //MARK: - INIT
    init(urlString: String?) {
        urlImageModel = URLImageModel(urlString: urlString)
    }
    
    
    //MARK: - BODY
    var body: some View {
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
            .renderingMode(.original)
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
    
    static var defaultImage = UIImage(systemName: "play")
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}
