import SwiftUI
import CoreData

// Fetch menu data from the given URL and save it to Core Data
func getMenuData() {
    let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
    let request = URLRequest(url: url)

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }

        guard let data = data else {
            print("No data received.")
            return
        }

        let decoder = JSONDecoder()
        do {
            let decodedMenuList = try decoder.decode(MenuList.self, from: data)
            let menuItems = decodedMenuList.menu

            // Saving the fetched menu items to Core Data
            let viewContext = PersistenceController.shared.container.viewContext
            for menuItem in menuItems {
                let dish = Dish(context: viewContext)
                dish.title = menuItem.title
                dish.image = menuItem.image
                dish.price = menuItem.price
            }
            // Save the context after updating it
            try viewContext.save()
        } catch {
            print("Error decoding JSON data: \(error)")
        }
        
    }

    task.resume()
}

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Dish.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)]
    ) var dishes: FetchedResults<Dish>
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    
    var body: some View {
        
        @Environment(\.managedObjectContext) var viewContext
        
        @State var startersIsEnabled = true
        @State var mainsIsEnabled = true
        @State var dessertsIsEnabled = true
        @State var drinksIsEnabled = true
        
        VStack {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Header()
                        Hero()
                            .padding()
                            .background(Color.primaryColor1)
                            .frame(maxWidth:.infinity, maxHeight: 240)
                    }
                }
            }
            
            Text("ORDER FOR DELIVERY!")
                .font(.sectionTitle())
                .foregroundColor(.highlightColor2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Toggle("Starters", isOn: $startersIsEnabled)
                    Toggle("Mains", isOn: $mainsIsEnabled)
                    Toggle("Desserts", isOn: $dessertsIsEnabled)
                    Toggle("Drinks", isOn: $drinksIsEnabled)
                }
                .toggleStyle(MyToggleStyle())
                .padding(.horizontal)
            }
            
            List {
                ForEach(dishes, id: \.self) { dish in
                    HStack {
                        Text("\(dish.title ?? "Unknown Title") - $\(dish.price ?? "")")
                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView() // Placeholder while loading
                        }
                    }
                }
            }
        }
        .onAppear { getMenuData() }
    }

}


#Preview {
    Menu()
}
