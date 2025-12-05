//
//  FirebaseManager.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//


import Foundation
import FirebaseFirestore

@MainActor
class FirebaseManager: ObservableObject {
    
    @Published var notes: [Note] = []  
    
    private let db = Firestore.firestore()
    private let collectionName = "tasks"
    
    // load notes when manager is created
    init() {
        Task {
            await fetchNotes()
        }
    }
    
    // get all notes from firebase
    func fetchNotes() async {
        do {
            let snapshot = try await db.collection(collectionName).getDocuments()
            
           
            notes = snapshot.documents.compactMap { document in
                try? document.data(as: Note.self)
            }
            
            print("got \(notes.count) notes from firebase")
        } catch {
            print("error getting notes:", error.localizedDescription)
        }
    }
    
    // update note title
    func updateNote(note: Note, newTitle: String) async {
        // make sure note has id
        guard let id = note.id else {
            print("note has no id")
            return
        }
        
        do {
            // update just the title
            try await db.collection(collectionName).document(id).updateData([
                "title": newTitle
            ])
            
            print("updated note: \(newTitle)")
            
            // refresh list
            await fetchNotes()
        } catch {
            print("error updating note:", error.localizedDescription)
        }
    }
    
    // delete a note
    func deleteNote(id: String) async {
        do {
            try await db.collection(collectionName).document(id).delete()
            
            print("deleted note")
            
            // refresh list
            await fetchNotes()
        } catch {
            print("error deleting note:", error.localizedDescription)
        }
    }
    
    // upload api notes to firebase
    func uploadNotesToFirebase(notes: [Note]) async {
        for note in notes {
            do {
                // add each note to firebase
                _ = try db.collection(collectionName).addDocument(from: note)
                print("uploaded note: \(note.title)")
            } catch {
                print("error uploading note:", error.localizedDescription)
            }
        }
        
        // get updated list
        await fetchNotes()
    }
}
