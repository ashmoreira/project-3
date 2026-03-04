import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    @State private var page: RemindersPage = RemindersPage(title:"Todo List", items:[], color: .red)
    
    var body: some View {
        VStack {
            HStack{
                Text("5:52")
                    .bold()
                Spacer()
                HStack(spacing:1){
                    Image(systemName:"ellipsis")
                        .offset(y:5)
                        .foregroundStyle(.secondary)
                    Image(systemName:"wifi")
                    Image(systemName:"battery.100percent")
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, -35)
            .foregroundStyle(Color(.label))
            .font(.system(size:19))
            HStack {
                Text(page.title)
                    .font(.system(size:40, weight: .bold))
                Spacer()
                
                Button {
                    isEditing.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .font(.headline)
                }
            }
            .padding(30)
                List {
                    ForEach($page.items) { $reminder in
                        HStack{
                            Button {
                                reminder.isCompleted.toggle()
                            } label : {
                                Image(systemName: reminder.isCompleted ? "circle.fill" : "circle").font(.title2).bold()
                            }
                            TextField("Add Item", text:$reminder.title)
                                .font(.system(size:20))
                                .foregroundStyle(.black)
                            
                        }
                    }
                    .onDelete { indexSet in
                        page.items.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
            HStack{
                Spacer()
                Button {
                    page.items.append( Reminder(title:""))
                }label :{
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding(.horizontal,45)

                
            }
        .foregroundStyle(page.color)
            .sheet(isPresented: $isEditing) {
                // TODO: Add remaining binding
                EditSheet(selectedColor: $page.color, name:$page.title)
            }
        }
    }
#Preview {
    ContentView()
}
