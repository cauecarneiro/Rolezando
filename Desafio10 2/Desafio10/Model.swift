//
//  Model.swift
//  Desafio10
//
//  Created by Turma02-28 on 29/04/25.
//

import Foundation

struct Local: Codable, Hashable {
    let _id: String
    let _rev: String
    let categoria: String
    let nome: String
    let data: String
    let localizacao: Loc
    let descricao: String
    let tags: [String]
    let salvo: Bool
    let imagem_url: String
}

struct Loc: Codable, Hashable{
    let local: String
    let endereco: String
    let latitude: Double
    let longitude: Double
}
