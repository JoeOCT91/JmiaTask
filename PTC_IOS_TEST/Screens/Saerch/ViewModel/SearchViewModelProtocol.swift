//
//  SearchViewModelProtocol.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/10/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import RxSwift
protocol SearchViewModelProtocol {
    var inputs : SearchViewModelProtocolInput {get}
    var outputs : SearchViewModelProtocolOutput {get}
}

protocol SearchViewModelProtocolInput {
    var searchQuery : BehaviorSubject<String> { get }
    var searchTrigger : PublishSubject<Void> {get}
}

protocol SearchViewModelProtocolOutput {
    var searchResult :  PublishSubject<Void> {get}
    var searchButtonEnabled : BehaviorSubject<Bool> {get}
    var noSearchResult :  PublishSubject<String> {get}
}


typealias SearchViewModelEvents =   SearchViewModelProtocolInput & SearchViewModelProtocolOutput
