import SwiftUI

struct ReminderDetailView: View {
    @Binding var selectedColor: Color
    @Binding var reminder: Reminder
    @Binding var isEditing: Bool
    @Binding var name: String
    
    var body: some View {
        List {
            Section {
                Text(reminder.description.isEmpty ? "" : reminder.description)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .listRowBackground(Color.clear)
            }
            
            Section ("Title & Description") {
                HStack {
                    Text("Title")
                    TextField("Title", text: $reminder.title)
                }
                .foregroundStyle(.black)
                HStack {
                    Text("Description")
                    TextField("Description", text: $reminder.description)
                }
                .foregroundStyle(.black)
            }
            Section ("Date") {
                    DatePicker("Date", selection: $reminder.date)
                    .foregroundStyle(.black)
            }
        }
            .foregroundStyle(selectedColor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing.toggle()
                    } label : {
                        Image(systemName: "info.circle")
                            .foregroundStyle(selectedColor)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditSheet(selectedColor: $selectedColor, name: $name)
            }
            .navigationTitle(reminder.title.isEmpty ? "New Reminder" : reminder.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

#Preview {
    // TODO: Create necessary @State properties to pass into preview (Hint: use @Previewable)
    @Previewable @State var reminder = Reminder(title: "do my homework", description: "inls quiz", date: Date())
    @Previewable @State var color: Color = .red
    @Previewable @State var isEditing: Bool = false
    @Previewable @State var name: String = "todo list"
    
    NavigationStack {
        ReminderDetailView(selectedColor: $color, reminder: $reminder, isEditing: $isEditing, name: $name)
    }
}
