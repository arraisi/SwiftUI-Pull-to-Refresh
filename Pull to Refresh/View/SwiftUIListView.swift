//
//  SwiftUIListView.swift
//  Pull to Refresh
//
//  Created by Abdul R. Arraisi on 27/12/20.
//

import SwiftUI
import SwiftUIRefresh

struct SwiftUIListView: View {
    
    @State private var results = [Result]()
    @State private var isLoading = false
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .background(Color.gray)
        .pullToRefresh(isShowing: $isLoading) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                loadData()
                self.isLoading = false
            }
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=bring+me+the+horizon&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // step 4
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    print("data : \(decodedResponse)")
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }
                    
                    // everything is good, so we can exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct SwiftUIListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListView()
    }
}
