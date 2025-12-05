//
//  Note.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//


import Foundation
import FirebaseFirestore

struct Note: Identifiable, Codable {
    @DocumentID var id: String?
    let nid: Int
    var title: String
    let image: String
    
    
    enum CodingKeys: String, CodingKey {
        case nid
        case title
        case image
      
    }
    
    
    var identifier: String {
        id ?? "\(nid)"
    }
}
