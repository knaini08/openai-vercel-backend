import SwiftUI

struct HomeView: View {
    let features = [
        FeatureItem(title: "Create Flashcards", icon: "rectangle.stack.fill", color: .blue),
        FeatureItem(title: "Generate AI Flashcards", icon: "sparkles.rectangle.stack.fill", color: .purple),
        FeatureItem(title: "Create Practice Questions", icon: "questionmark.circle.fill", color: .green),
        FeatureItem(title: "Generate AI Practice Questions", icon: "brain.head.profile", color: .orange),
        FeatureItem(title: "Generate AI Practice Test", icon: "doc.text.fill", color: .red),
        FeatureItem(title: "Scan Problem", icon: "camera.fill", color: .teal)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Welcome to")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text("LearnIt AI")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        Text("Your personal study companion")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Feature Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(features) { feature in
                            FeatureCard(feature: feature)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
}

struct FeatureCard: View {
    let feature: FeatureItem
    
    var body: some View {
        Button(action: {
            // Handle tap action
            print("Tapped \(feature.title)")
        }) {
            VStack(spacing: 12) {
                Image(systemName: feature.icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                Text(feature.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [feature.color, feature.color.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .shadow(color: feature.color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HomeView()
}