//
//  EditNoteSheet.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//

import SwiftUI

struct EditNoteSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let note: Note
    let firebaseManager: FirebaseManager
    
    @State private var title: String
    @State private var showError = false
    @State private var isSaving = false
    
    init(note: Note, firebaseManager: FirebaseManager) {
        self.note = note
        self.firebaseManager = firebaseManager
        _title = State(initialValue: note.title)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    colors: [Color.pink.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                       
                        AsyncImage(url: URL(string: note.image)) { phase in
                            if let image = phase.image {
                              
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else if phase.error != nil {
                                // error loading image
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.pink.opacity(0.2))
                                    .frame(height: 250)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "photo")
                                                .font(.largeTitle)
                                            Text("image unavailable")
                                                .font(.caption)
                                        }
                                        .foregroundColor(.pink.opacity(0.5))
                                    )
                            } else {
                                // loading
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.pink.opacity(0.2))
                                    .frame(height: 250)
                                    .overlay(
                                        ProgressView()
                                            .tint(.pink)
                                    )
                            }
                        }
                        .frame(maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .pink.opacity(0.3), radius: 10, x: 0, y: 5)
                        .padding()
                        
                        // edit section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("edit title")
                                .font(.headline)
                                .foregroundColor(.pink)
                            
                            TextField("enter title", text: $title)
                                .textFieldStyle(.roundedBorder)
                                .padding(12)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            if showError {
                                HStack {
                                    Image(systemName: "exclamationmark.circle.fill")
                                    Text("title can't be empty!")
                                }
                                .foregroundColor(.red)
                                .font(.caption)
                            }
                        }
                        .padding()
                        
                        // save button
                        Button {
                            saveNote()
                        } label: {
                            HStack {
                                if isSaving {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text("save changes")
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(color: .pink.opacity(0.5), radius: 8, x: 0, y: 4)
                        }
                        .disabled(isSaving)
                        .padding()
                        .padding(.top, 10)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("✏️ edit note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                    .foregroundColor(.pink)
                }
            }
        }
    }
    
    private func saveNote() {
        // check title is not empty
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        
        if trimmedTitle.isEmpty {
            showError = true
            return
        }
        
        showError = false
        isSaving = true
        
        // save to firebase
        Task {
            await firebaseManager.updateNote(note: note, newTitle: trimmedTitle)
            isSaving = false
            dismiss()
        }
    }
}

struct EditNoteSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteSheet(
            note: Note(id: "1", nid: 1, title: "Test", image: ""),
            firebaseManager: FirebaseManager()
        )
    }
}


