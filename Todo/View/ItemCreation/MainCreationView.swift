//
//  MainCreationView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//
import SwiftUI

struct MainCreationView: View {
    
    @State var title = ""
    @State var desc = ""
    @State private var selectedDate: Date? = nil
    @State private var selectedImage: Data? = nil
    var item: ItemModel? = nil
    @State var dateSelected = false
    @State private var isKeyboardVisible = false
    @State private var showingBottomSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var listItemViewModel: ListItemViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Date.distantFuture
        return min...max
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CreateImageView(selectedImageData: $selectedImage)
                VStack {
                    TextField("Заголовок", text: $title, axis: .horizontal)
                        .padding()
                        .border(.secondary, width: 1)
                        .padding()
                    TextField("Описание", text: $desc, axis: .vertical)
                        .frame(height: 200)
                        .padding()
                        .border(.secondary, width: 1)
                        .padding()
                    HStack {
                        Text("Выбрать дату")
                        Image(systemName: dateSelected ? "checkmark.circle" : "circle")
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    dateSelected.toggle()
                                    if !dateSelected {
                                        selectedDate = nil
                                    } else {
                                        selectedDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
                                    }
                                }
                            }
                            .scaleEffect(1.5)
                        
                        if dateSelected || item?.date != nil {
                            DatePicker(
                                "",
                                selection: selectedDate != nil ? .constant(selectedDate!) : .constant(item?.date ?? Date()),
                                in: dateClosedRange,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .datePickerStyle(.compact)
                        }


                        
                    }
                    .padding()
                    .foregroundStyle(.secondary)
                    
                }
                
                NotificationButtonView(title: "Добавить напоминание", action: {
                    if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        alertMessage = "Пожалуйста, заполните заголовок."
                        showAlert = true
                    } else {
                        itemCreateAndEdit()
                        notificationCreate()
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("Ок"))
                    )
                }
                
                if let item {
                    DeleteButtonView(showingBottomSheet: $showingBottomSheet, item: item)
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Отмена")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "Пожалуйста, заполните заголовок."
                            showAlert = true
                        } else {
                            itemCreateAndEdit()
                            notificationCreate()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Сохранить")
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Ошибка"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("Ок"))
                        )
                    }
                }
            }
            .onAppear {
                if let item {
                    title = item.title
                    desc = item.desc ?? ""
                    selectedDate = item.date
                    selectedImage = item.image
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                isKeyboardVisible = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                isKeyboardVisible = false
            }
        }
        
        
        
    }
    
    private func itemCreateAndEdit() {
        
        if let item {
            listItemViewModel.editItem(
                updatedItem: ItemModel(
                    id: item.id,
                    image: selectedImage,
                    title: title,
                    desc: desc,
                    date: selectedDate,
                    done: item.done
                )
            )
        } else {
            listItemViewModel.addItem(
                item: ItemModel(
                    id: UUID(),
                    image: selectedImage,
                    title: title,
                    desc: desc,
                    date: selectedDate,
                    done: false
                )
            )
        }
        
    }
    
    private func notificationCreate() {
        
        if let item {
            if let existingDate = item.date, existingDate != selectedDate {
                NotificationManager.shared.cancelNotification(id: item.id.uuidString)
            }
        }
        
        if dateSelected, let selectedDate {
            NotificationManager.shared.scheduleNotification(
                title: "Todo",
                body: title,
                date: selectedDate
            )
        }
        
    }

    
}

#Preview {
    NavigationView {
        MainCreationView()
    }
    .environmentObject(ListItemViewModel())
}

struct DeleteButtonView: View {
    
    @Binding var showingBottomSheet: Bool
    var item: ItemModel
    @EnvironmentObject var listItemViewModel: ListItemViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NotificationButtonView(title: "Удалить", color: .black, background: .secondary) {
            showingBottomSheet = true
        }
        .sheet(isPresented: $showingBottomSheet) {
            VStack(spacing: 20) {
                Text("Вы уверены, что хотите удалить?")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(spacing: 20) {
                    Button(action: {
                        showingBottomSheet = false
                    }) {
                        Text("Отмена")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        listItemViewModel.deleteItem(toDelete: item)
                        presentationMode.wrappedValue.dismiss()
                        showingBottomSheet = false
                    }) {
                        Text("Удалить")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .presentationDetents([.fraction(0.3)])
        }
    }
}
