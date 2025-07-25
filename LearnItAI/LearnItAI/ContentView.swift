import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            TasksView()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Tasks")
                }
            
            LibraryView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Your Library")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}