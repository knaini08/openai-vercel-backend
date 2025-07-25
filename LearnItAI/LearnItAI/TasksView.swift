import SwiftUI

struct TasksView: View {
    @State private var aiTokens = 150
    @State private var showingSubscriptionSheet = false
    
    let dailyTasks = [
        Task(title: "Complete 5 flashcard reviews", reward: 10, isCompleted: false),
        Task(title: "Create a new flashcard set", reward: 15, isCompleted: true),
        Task(title: "Take a practice quiz", reward: 20, isCompleted: false),
        Task(title: "Study for 30 minutes", reward: 25, isCompleted: false)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Token Counter
                    TokenCounterCard(tokens: aiTokens)
                    
                    // Daily Tasks Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Tasks")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(dailyTasks) { task in
                                TaskRow(task: task)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Earn More Tokens Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Earn More Tokens")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            // Invite Friends
                            Button(action: {
                                // Handle invite friends
                                print("Invite friends tapped")
                            }) {
                                EarnTokensCard(
                                    title: "Invite Friends",
                                    subtitle: "Get 50 tokens for each friend who joins",
                                    icon: "person.2.fill",
                                    color: .green
                                )
                            }
                            
                            // Upgrade to Premium
                            Button(action: {
                                showingSubscriptionSheet = true
                            }) {
                                EarnTokensCard(
                                    title: "Upgrade to Premium",
                                    subtitle: "Unlimited tokens + exclusive features",
                                    icon: "crown.fill",
                                    color: .orange
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Tasks")
            .sheet(isPresented: $showingSubscriptionSheet) {
                SubscriptionView()
            }
        }
    }
}

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let reward: Int
    let isCompleted: Bool
}

struct TokenCounterCard: View {
    let tokens: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 40))
                .foregroundColor(.yellow)
            
            Text("\(tokens)")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.primary)
            
            Text("AI Tokens")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
        .padding(.horizontal)
    }
}

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(task.isCompleted ? .green : .gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.body)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
                
                Text("+\(task.reward) tokens")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}

struct EarnTokensCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Text("LearnIt AI Premium")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Unlock unlimited learning potential")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    FeatureBenefitRow(icon: "infinity", text: "Unlimited AI tokens")
                    FeatureBenefitRow(icon: "brain.head.profile", text: "Advanced AI features")
                    FeatureBenefitRow(icon: "chart.line.uptrend.xyaxis", text: "Detailed progress analytics")
                    FeatureBenefitRow(icon: "icloud.fill", text: "Cloud sync across devices")
                    FeatureBenefitRow(icon: "bell.fill", text: "Smart study reminders")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
                
                VStack(spacing: 12) {
                    Button(action: {
                        // Handle subscription purchase
                        print("Subscribe tapped")
                    }) {
                        Text("Start Free Trial")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange)
                            )
                    }
                    
                    Text("$4.99/month after 7-day free trial")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Premium")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureBenefitRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.orange)
                .frame(width: 24)
            
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    TasksView()
}