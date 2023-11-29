import SwiftUI
import PhotosUI
import SwiftData

struct AddPlantView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var items: [Item]
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var plantName: String = ""
    @State private var plantDesc: String = ""
    @State private var selectedImages = [Image]()

    //MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                inputSection
                imageSection
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
            }
        } //: NAVIGATIONSTACK
    }

    //MARK: - FUNCTIONS
    
    // input section
    private var inputSection: some View {
        Section {
            TextField("Bitki İsmi".localized(), text: $plantName)
            TextField("Bitki Açıklaması".localized(), text: $plantDesc)
        }
    }

    // image section
    private var imageSection: some View {
        Section {
            PhotosPicker("Fotoğraf Seç".localized(), selection: $selectedItems, matching: .images) // allowsMultipleSelection: false ekledik
            displaySelectedImages()
        }
        .onChange(of: selectedItems) { _ in
            Task {
                await loadSelectedImages()
            }
        }
    }

    // display select images
    private func displaySelectedImages() -> some View {
        ScrollView {
            LazyHStack {
                ForEach(selectedImages.indices, id: \.self) { index in
                    displayedImage(selectedImages[index])
                }
            }
        }
    }

    // display image
    private func displayedImage(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }

    // save button
    private var saveButton: some View {
        Button("Kaydet".localized()) {
            guard isInputValid, let selectedPhoto = selectedItems.first else {
                // Show an alert or some indication to the user about missing input or no photo selected
                return
            }

            saveData(selectedPhoto: selectedPhoto) {
                dismiss()
            }
        }
    }

    // cancel button
    private var cancelButton: some View {
        Button("İptal".localized()) {
            dismiss()
        }
    }

    // valid
    private var isInputValid: Bool {
        !plantName.isEmpty && !plantDesc.isEmpty
    }

    // load select images
    private func loadSelectedImages() async {
        selectedImages.removeAll()

        for item in selectedItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    selectedImages.append(image)
                }
            }
        }
    }

    // save data 
    private func saveData(selectedPhoto: PhotosPickerItem, completion: @escaping () -> Void) {
        Task {
            do {
                if let imageData = try? await selectedPhoto.loadTransferable(type: Data.self) {
                    let item = Item(name: plantName, timestamp: Date(), desc: plantDesc, image: imageData)
                    modelContext.insert(item)

                    do {
                        try await modelContext.save()
                        print("Success // Data => \(item.name)")
                    } catch {
                        print("Error saving data: \(error.localizedDescription)")
                        // Show an alert or some indication to the user
                    }
                }

                dismiss()
            } catch {
                print("Error: \(error.localizedDescription)")
                // Show an alert or some indication to the user
            }
        }
    }
}

struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}

