import Foundation
import SwiftUI

struct DogInfoView: View {
    @EnvironmentObject var dogManager: DogManager
    @Environment(\.presentationMode) var presentationMode

    // Temporary state variables to hold edited values
    // (initialize these with the original dog data on appear, just like before)
    @State private var editedName: String = ""
    @State private var editedAge: String = ""
    @State private var editedBreed: String = ""
    @State private var editedSize: String = ""
    @State private var editedWeight: String = ""
    @State private var editedMedication: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dog Information")) {
                    TextField("Name", text: $editedName)
                        .onAppear {
                            editedName = dogManager.dog.name
                        }
                    TextField("Age", text: $editedAge)
                        .onAppear {
                            editedAge = dogManager.dog.age
                        }
                    TextField("Breed", text: $editedBreed)
                        .onAppear {
                            editedBreed = dogManager.dog.breed
                        }
                    TextField("Size", text: $editedSize)
                        .onAppear {
                            editedSize = dogManager.dog.size
                        }
                    TextField("Weight", text: $editedWeight)
                        .onAppear {
                            editedWeight = dogManager.dog.weight
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
                        dogManager.dog.name = editedName
                        dogManager.dog.age = editedAge
                        dogManager.dog.breed = editedBreed
                        dogManager.dog.size = editedSize
                        dogManager.dog.weight = editedWeight
                        dogManager.dog.medication = editedMedication

                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
