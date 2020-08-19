//
//  DatabaseController.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 19/08/2020.
//

import Foundation


//MARK: REGISTER USER
func registerUser(name: String, surname: String, email: String) {
    
    guard let url = URL(string: "http://192.168.178.103:8080/FindPlayer-0.0.1/RegisterUser") else {
        print("Invalid URL")
        return
    }
    
    let headers = [
        "accept" : "application/json",
        "accept-encoding": "gzip deflate"
    ]
    
    let parameters: [String: String] = ["name": name, "surname": surname, "email" : email]
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST" //set http method as POST
    
    request.allHTTPHeaderFields = headers

    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    
    
    //SE VOGLIO LEGGERE I DATI DAL SERVER
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            DispatchQueue.main.async {
                
                guard let json = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                    print("Error during decoding")
                    return
                } //: guard let json
                
                print(json)
                
            }//: Async
            return
        }//: IfData
        else { print("eh no") }
    }.resume()
}

struct RegisterResponse: Codable {
    var result: String
}



//MARK: RETRIEVE ALL USER (DA METTERE NELLA STRUTTURA DOVE SI VUOLE UTILIZZARLA)
func retrieveAllUser() {
    
    guard let url = URL(string: "http://192.168.178.103:8080/FindPlayer-0.0.1/Ciao") else {
        print("Invalid URL")
        return
    }
    
    let headers = [
        "accept" : "application/json",
        "accept-encoding": "gzip deflate"
    ]
    
    var request = URLRequest(url: url)
    
    request.allHTTPHeaderFields = headers
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            DispatchQueue.main.async {
                
                guard let json = try? JSONDecoder().decode(UtentiRisposta.self, from: data) else {
                    print("Error during decoding")
                    return
                } //: guard let json
                
                //                self.utenti = json.users
                
            }//: Async
            
        }//: IfData
        
        else { print("eh no") }
    }//: DataTask
    .resume()
}
