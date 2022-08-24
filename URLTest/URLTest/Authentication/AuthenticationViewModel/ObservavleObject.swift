//
//  ObservavleObject.swift
//  URLTest
//
//  Created by Adrian San Martin on 23/08/22.
//

import Foundation

class ObservavleObjetc<T> {
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    
    private var listener: ((T)  -> Void)?
    init(_ value: T){
        self.value = value
    }
    func bind(_ listener: @escaping(T) -> Void){
        listener(value)
        self.listener = listener
    }
}
