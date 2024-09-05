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
    @State private var editedMedication: String = ""
    let possibleAges = Array(0...25)
    let possibleWeights = Array(0...100)
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dog Information")) {
                    TextField("Name", text: $editedName)
                        .onAppear {
                            editedName = dogManager.dog.name
                        }

                    Picker("Age", selection: $editedAge) {
                        ForEach(possibleAges, id: \.self) { age in
                            Text("\(age)").tag(age)
                            }
                        }
                    TextField("Breed", text: $editedBreed)
                        .onAppear {
                            editedBreed = dogManager.dog.breed
                        }
                    TextField("Size", text: $editedSize)
                        .onAppear {
                            editedSize = dogManager.dog.size
                        }

                    Picker("Weight (kg)", selection: $editedWeight) {
                        ForEach(possibleWeights, id: \.self) { weight in
                            Text("\(weight)").tag(weight)
                        }
                    }

                    TextField("Medication", text: $editedMedication)
                        .onAppear {
                            editedMedication = dogManager.dog.medication
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
                        editedMedication = dogManager.dog.medication

                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Update dogManager with edited values
                        dogManager.updateDog(
                            name: editedName,
                            age: editedAge,
                            breed: editedBreed,
                            size: editedSize,
                            weight: editedWeight,
                            medication: editedMedication
                        )

                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
