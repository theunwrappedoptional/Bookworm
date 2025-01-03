//
//  AddBookView.swift
//  Bookworm
//
//  Created by Manhattan on 23/12/24.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var genre = "Fantasy"
    
    let genres = ["Fantasy", "Horror", "Thriller", "Kids", "Romance", "Mistery", "Poetry"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of the book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review"){
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6){
//                            Text("\($0)")
//                        }
//                    }
                }
                
                Section{
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
