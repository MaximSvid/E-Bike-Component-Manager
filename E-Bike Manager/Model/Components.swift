//
//  Components.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

/*
 Wofür wird DocumentID benötigt?
 DocumentID ist ein spezieller Property Wrapper, der in Swift verwendet wird, um die Dokumenten-ID eines Firestore-Dokuments zu verwalten. Wenn Sie Daten in Firestore speichern oder abrufen, hat jedes Dokument eine eindeutige ID. Diese ID wird verwendet, um das Dokument in der Datenbank zu identifizieren und darauf zuzugreifen.

 */

import SwiftUI
import FirebaseFirestore

struct Components: Codable {
    @DocumentID var id: String? //virwaltet die Dokument-ID
    
    var image: String = "" // wenn ich Zeit habe...
    var name: String
    var type: ComponentsType
    var serialNumber: Int
    var version: String
    var status: DeviceStatus
    
}
