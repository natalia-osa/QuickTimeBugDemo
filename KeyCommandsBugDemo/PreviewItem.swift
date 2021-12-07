//
//  PreviewItem.swift
//  KeyCommandsBugDemo
//
//  Created by Natalia Osiecka on 07/12/2021.
//

import QuickLook

class PreviewItem: NSObject, QLPreviewItem {
    let fileName: String
    let fileExtension: String

    init(fileName: String, fileExtension: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        super.init()
    }

    var previewItemTitle: String? {
        return fileName + "." + fileExtension
    }

    var previewItemURL: URL? {
        return Bundle.main.url(forResource: fileName, withExtension: fileExtension)
    }
}
