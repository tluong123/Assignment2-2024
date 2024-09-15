import Foundation
import SwiftUI

struct DogInfoView: View {
    @EnvironmentObject var dogManager: DogManager
    @Environment(\.presentationMode) var presentationMode

    // Temporary state variables to hold edited values
    @State private var editedName: String = ""
    @State private var editedAge: Int = 0
    @State private var editedBreed: String = ""
    @State private var editedSize: String = ""
    @State private var editedWeight: Int = 0

    let possibleAges = Array(0...25)
    let possibleWeights = Array(0...100)
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dog Information")) {
                    LabeledContent("*Name:") {
                        TextField("", text: $editedName)
                            .onAppear {
                                editedName = dogManager.dog.name
                            }
                    }
                    Picker("*Age:", selection: $editedAge) {
                        ForEach(possibleAges, id: \.self) { age in
                            Text("\(age)").tag(age)
                            }
                        }
                    .onAppear {
                        editedAge = dogManager.dog.age
                    }
                    LabeledContent("*Breed:") {
                        TextField("", text: $editedBreed)
                            .onAppear {
                                editedBreed = dogManager.dog.breed
                            }
                    }
                    LabeledContent("*Size:") {
                        TextField("", text: $editedSize)
                            .onAppear {
                                editedSize = dogManager.dog.size
                            }
                    }
                    Picker("*Weight(kg):", selection: $editedWeight) {
                        ForEach(possibleWeights, id: \.self) { weight in
                            Text("\(weight)").tag(weight)
                        }
                    }
                    .onAppear {
                        editedWeight = dogManager.dog.weight
                    }

                }
            }
            .navigationTitle("Your Dog's Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Reset edited values to original dog data
                        editedName = dogManager.dog.name
                        editedAge = dogManager.dog.age
                        editedBreed = dogManager.dog.breed
                        editedSize = dogManager.dog.size
                        editedWeight = dogManager.dog.weight

                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if editedName.isEmpty || editedAge == 0 || editedBreed.isEmpty || editedSize.isEmpty || editedWeight == 0 {
                                showAlert = true
                        } else {
                            save()
                        }
                   }
                }
            }
            .alert("Please fill in all required fields.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    private func save() {
        dogManager.updateDog(
            name: editedName,
            age: editedAge,
            breed: editedBreed,
            size: editedSize,
            weight: editedWeight
        )

        presentationMode.wrappedValue.dismiss()
    }
}
