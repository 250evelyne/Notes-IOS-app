//
//  NotesListView.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//

import SwiftUI

struct NotesListView: View {
    
    @StateObject private var firebaseManager = FirebaseManager()
    @AppStorage("hasLoadedNotes") private var hasLoadedNotes = false
    
    @State private var editingNote: Note?
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
             
                LinearGradient(
                    colors: [Color.pink.opacity(0.15), Color.purple.opacity(0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                       
                if isLoading {
                    // loading spinner
                    VStack(spacing: 15) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.pink)
                        Text("loading your notes...")
                            .foregroundColor(.pink)
                            .font(.subheadline)
                    }
                } else if firebaseManager.notes.isEmpty {
                    // no notes yet
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .font(.system(size: 70))
                            .foregroundColor(.pink.opacity(0.6))
                        Text("no notes yet!")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("pull down to refresh")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                } else {
                    
                    // list of notes
                    List {
                        ForEach(firebaseManager.notes, id: \.nid) { note in
                            NoteRowView(note: note)
                                .listRowBackground(Color.white.opacity(0.5))
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    editingNote = note
                                }
                        }
                        .onDelete { indexSet in
                            Task {
                                for index in indexSet {
                                    let note = firebaseManager.notes[index]
                                    if let id = note.id {
                                        await firebaseManager.deleteNote(id: id)
                                    }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
            }
            .navigationTitle("✨ my notes")
            .task {
                await loadInitialData()
            }
            .refreshable {
                await firebaseManager.fetchNotes()
            }
            .sheet(item: $editingNote) { note in
                EditNoteSheet(
                    note: note,
                    firebaseManager: firebaseManager
                )
            }
        }
    }
    
    // load data on first launch
    private func loadInitialData() async {
        // only get from api on 1st launch
        if !hasLoadedNotes {
            isLoading = true
            
            let noteService = NoteService()
            let apiNotes = await noteService.fetchNotesFromAPI()
            
            if !apiNotes.isEmpty {
                // save to firebase
                await firebaseManager.uploadNotesToFirebase(notes: apiNotes)
                hasLoadedNotes = true
            }
            
            isLoading = false
        }
    }
}

// individual note in de list
struct NoteRowView: View {
    let note: Note
    
    var body: some View {
        HStack(spacing: 15) {
           
            AsyncImage(url: URL(string: note.image)) { phase in
                if let image = phase.image {
                  
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                
                    Color.pink.opacity(0.2)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.pink.opacity(0.5))
                        )
                } else {
                    // loading
                    Color.pink.opacity(0.2)
                        .overlay(
                            ProgressView()
                                .tint(.pink)
                        )
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .pink.opacity(0.3), radius: 5, x: 0, y: 2)
            
            // title
            VStack(alignment: .leading, spacing: 5) {
                Text(note.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("tap to edit")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            // arrow
            Image(systemName: "chevron.right")
                .foregroundColor(.pink.opacity(0.6))
                .font(.caption)
        }
        .padding(.vertical, 10)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
        )
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
       








