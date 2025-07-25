import SwiftUI

struct LibraryView: View {
    @State private var selectedFilter = "All"
    @State private var searchText = ""
    
    let filters = ["All", "Flashcards", "Practice Questions", "Practice Tests"]
    
    let libraryItems = [
        LibraryItem(title: "Biology Chapter 5", type: .flashcards, itemCount: 24, lastStudied: "2 days ago"),
        LibraryItem(title: "Chemistry Basics", type: .practiceQuestions, itemCount: 15, lastStudied: "1 week ago"),
        LibraryItem(title: "Physics Midterm Prep", type: .practiceTest, itemCount: 1, lastStudied: "3 days ago"),
        LibraryItem(title: "History Timeline", type: .flashcards, itemCount: 32, lastStudied: "5 days ago"),
        LibraryItem(title: "Math Problem Set", type: .practiceQuestions, itemCount: 20, lastStudied: "1 day ago"),
        LibraryItem(title: "Spanish Vocabulary", type: .flashcards, itemCount: 48, lastStudied: "4 hours ago")
    ]
    
    var filteredItems: [LibraryItem] {
        let filtered = libraryItems.filter { item in
            if selectedFilter == "All" { return true }
            switch selectedFilter {
            case "Flashcards": return item.type == .flashcards
            case "Practice Questions": return item.type == .practiceQuestions
            case "Practice Tests": return item.type == .practiceTest
            default: return true
            }
        }
        
        if searchText.isEmpty {
            return filtered
        } else {
            return filtered.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                // Filter Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(filters, id: \.self) { filter in
                            FilterTab(
                                title: filter,
                                isSelected: selectedFilter == filter
                            ) {
                                selectedFilter = filter
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 16)
                
                // Library Items
                if filteredItems.isEmpty {
                    EmptyLibraryView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredItems) { item in
                                LibraryItemCard(item: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Your Library")
        }
    }
}

enum LibraryItemType {
    case flashcards
    case practiceQuestions
    case practiceTest
    
    var icon: String {
        switch self {
        case .flashcards: return "rectangle.stack.fill"
        case .practiceQuestions: return "questionmark.circle.fill"
        case .practiceTest: return "doc.text.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .flashcards: return .blue
        case .practiceQuestions: return .green
        case .practiceTest: return .red
        }
    }
    
    var displayName: String {
        switch self {
        case .flashcards: return "Flashcards"
        case .practiceQuestions: return "Practice Questions"
        case .practiceTest: return "Practice Test"
        }
    }
}

struct LibraryItem: Identifiable {
    let id = UUID()
    let title: String
    let type: LibraryItemType
    let itemCount: Int
    let lastStudied: String
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search your library", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        )
    }
}

struct FilterTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.blue : Color(.systemGray5))
                )
        }
    }
}

struct LibraryItemCard: View {
    let item: LibraryItem
    
    var body: some View {
        Button(action: {
            print("Tapped \(item.title)")
        }) {
            HStack(spacing: 16) {
                // Icon
                Image(systemName: item.type.icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(item.type.color)
                    )
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text(item.type.displayName)
                            .font(.caption)
                            .foregroundColor(item.type.color)
                        
                        Text("•")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(item.itemCount) items")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Last studied: \(item.lastStudied)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // More Options
                Button(action: {
                    print("More options for \(item.title)")
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmptyLibraryView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "books.vertical")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("Your Library is Empty")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Start creating flashcards and practice questions to build your study collection")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button(action: {
                print("Get started tapped")
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    LibraryView()
}