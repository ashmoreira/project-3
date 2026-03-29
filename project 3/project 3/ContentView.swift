import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    @State private var page: RemindersPage = RemindersPage(title:"Todo List", items:[], color: .red)
    
    var body: some View {
        NavigationStack {
            List {
                // for each reminder there is a completed button
                ForEach($page.items) {$reminder in
                    NavigationLink (value: reminder.id) {
                        HStack {
                            Button {
                                reminder.isCompleted.toggle()
                            } label: {
                                Image(systemName: reminder.isCompleted ? "circle.fill" : "circle")
                                    .font(.title2)
                                    .bold()
                            }
                            .buttonStyle(.borderless)
                            // when new reminder added -> there is a filled in name to be replaced
                            Text(reminder.title.isEmpty ? "New Reminder" : reminder.title)
                                .font(.system(size:20))
                            
                            Spacer()
                            // adding date
                            Text(reminder.date, style: .relative)
                                .font(.system(size:15))
                                .foregroundStyle(.secondary)
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                }
                .onDelete {indexSet in
                    page.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .navigationTitle(page.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .navigationDestination(for: UUID.self) {id in
                if let index = page.items.firstIndex (where: {$0.id == id }) {
                    ReminderDetailView(
                        selectedColor: $page.color,
                        reminder: $page.items[index],
                        isEditing: $isEditing,
                        name: $page.title
                    )
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    page.items.append(Reminder(title: "", description: "", date: Date()))
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size:50))
                }
                .padding(.trailing, 30)
                .padding(.bottom, 10)
            }
        }
        .foregroundStyle(page.color)
        .sheet(isPresented: $isEditing) {
            EditSheet(selectedColor: $page.color, name: $page.title)
        }
    }
}

#Preview {
    ContentView()
}
