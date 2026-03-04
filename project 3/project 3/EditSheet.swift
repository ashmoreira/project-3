import SwiftUI

struct EditSheet: View {
    @Binding var selectedColor: Color
    @Binding var name: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("List Info")
                .font(.title2.bold())
            VStack{
                Image(systemName: "list.bullet.circle.fill")
                    .font(.system(size:70))
                TextField("List Name", text: $name)
                    .font(Font.title3.bold())
                    .padding()
                    .background(Color.secondary.opacity(0.20), in: RoundedRectangle(cornerRadius: 16))
            }
            .padding()
            .background(Color.secondary.opacity(0.15), in: RoundedRectangle(cornerRadius: 16))
            ColorChooser(selectedColor: $selectedColor)
            
            Spacer()
        }
        .foregroundStyle(selectedColor)
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedColor: Color = .red
    @Previewable @State var name: String = "Todo List"
    
    EditSheet(selectedColor: $selectedColor, name: $name)
        .preferredColorScheme(.light)
}
