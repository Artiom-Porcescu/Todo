//
//  MainCreationView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

// MARK: If date wasnt changed at first, dont create notification, also dont create notification for dates that are already in the past


import SwiftUI

struct MainCreationView: View {
    
    @State var title = ""
    @State var desc = ""
    @State private var selectedDate: Date? = nil
    @State private var selectedImage: UIImage? = nil
    var item: ItemModel? = nil
    @State var dateSelected = false
    
    @EnvironmentObject var listItemViewModel: ListItemViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Date.distantFuture
        return min...max
    }
    
    var body: some View {
        VStack {
            CreationImageView(selectedImage: $selectedImage)
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
                            selection: Binding(
                                get: {
                                    if let itemDate = item?.date {
                                        return itemDate
                                    }
                                    return selectedDate ?? Date()
                                },
                                set: { newValue in
                                    self.selectedDate = newValue
                                }
                            ),
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
                            image: selectedImage,
                            title: title,
                            desc: desc,
                            date: selectedDate,
                            done: false
                        )
                    )
                }
                
                if dateSelected, let selectedDate {
                    NotificationManager.shared.scheduleNotification(
                        title: title,
                        body: desc,
                        date: selectedDate
                    )
                    print("Notif created")
                }
                
                presentationMode.wrappedValue.dismiss()
            })
            
            if let item {
                NotificationButtonView(title: "Удалить", color: .black, background: .secondary) {
                    listItemViewModel.deleteItem(toDelete: item)
                }
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
                    } else { // Adding a new item
                        listItemViewModel.addItem(
                            item: ItemModel(
                                image: selectedImage,
                                title: title,
                                desc: desc,
                                date: selectedDate,
                                done: false
                            )
                        )
                    }
                    
                    if dateSelected {
                        if let selectedDate {
                            NotificationManager.shared.scheduleNotification(
                                title: "Todo",
                                body: title,
                                date: selectedDate
                            )
                            print("Notif created")
                        }
                    }
                    
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Сохранить")
                }
            }
        }
        .onAppear {
            if let item {
                title = item.title
                desc = item.desc ?? ""
                selectedDate = item.date 
                selectedImage = item.image ?? UIImage(named: "grad")
            }
        }
        
        
    }
}

#Preview {
    NavigationView {
        MainCreationView()
    }
    .environmentObject(ListItemViewModel())
}
