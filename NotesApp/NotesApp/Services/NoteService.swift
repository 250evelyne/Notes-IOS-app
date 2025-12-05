//
//  NoteService.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//



import Foundation

class NoteService {
    private let webService = WebService()
    private let baseURL = "https://api.jerryjoy.me/notes"
    
    // get notes from api
    func fetchNotesFromAPI() async -> [Note] {
        let result: [Note]? = await webService.sendRequest(
            toURL: baseURL,
            method: .GET
        )
        return result ?? []  // empty list  when if it fails
    }
}
