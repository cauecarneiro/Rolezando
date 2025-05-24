//
//  ViewModel.swift
//  Desafio10
//
//  Created by Turma02-28 on 29/04/25.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var local: [Local] = []
    func fetch() {
        guard let url = URL(string: "http://192.168.128.80:1880/leitura") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let parsed = try JSONDecoder().decode([Local].self, from: data)
                DispatchQueue.main.async {
                    self?.local = parsed
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    func post(_ obj: Local){ //Aqui deve ser colocado o nome da Struct relacionada
        
        guard let url = URL(string: "http://192.168.128.80:1880/enviarLocalFavorito") else { return } //Aqui deve ser colocado o IP (local ou da rede) e, depois da barra, o verbo do POST do Node-RED
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(obj)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error to send resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error to send resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource POST successfully")
            } else {
                print("Error POST resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}
