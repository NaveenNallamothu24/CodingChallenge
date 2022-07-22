//
//  AcronymsDataSource.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class AcronymsDataSource : GenericDataSource<Acronym>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcronymCell", for: indexPath) as! AcronymCell
        
        let acronym = self.data.value[indexPath.row]
        cell.acronym = acronym
        
        return cell
    }
}
