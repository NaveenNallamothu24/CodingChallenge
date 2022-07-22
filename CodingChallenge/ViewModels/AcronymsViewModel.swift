//
//  AcronymsViewModel.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//

import Foundation
class AcronymsViewModel {
    
    weak var dataSource : GenericDataSource<Acronym>?
    var onErrorHandling : ((String,String) -> Void)?
    init(dataSource : GenericDataSource<Acronym>?) {
        self.dataSource = dataSource
    }
    
    func fetchAcronymsResults(word:String) {
        clear()
        let urlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(word)"
       
        NetworkManager.sharedInstance.requestWithModel(urlString: urlString, method: .GET, model: Acronyms.self) { response in
            if response.success {
                self.dataSource?.data.value = response.model?.first?.lfs ?? []
                if (self.dataSource?.data.value.count ?? 0) == 0 {
                    self.onErrorHandling?("Result","No results found")
                }
            } else {
                self.onErrorHandling?("Error",response.message)
            }
        }
    }
    func clear() {
        self.dataSource?.data.value = []
    }
}
