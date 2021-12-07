//
//  ViewController.swift
//  KeyCommandsBugDemo
//
//  Created by Natalia Osiecka on 07/12/2021.
//

import UIKit
import QuickLook

final class ViewController: UIViewController {

    @IBOutlet weak var logLabel: UILabel!

    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(upAction)),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(downAction)),
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(leftAction)),
            UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(rightAction))
        ].topPrioritised
    }

    @IBAction func clearAction(_ sender: Any) {
        logLabel.text = "Pressed arrows:\n"
    }

    @IBAction func properPreviewAction(_ sender: Any) {
        let previewItems = [
            PreviewItem(fileName: "i_dont_exist_1", fileExtension: "png"), // is NOT attached to the project
            PreviewItem(fileName: "i_dont_exist_2", fileExtension: "png") // is NOT attached to the project
        ]
        let quickLookController = PreviewViewController(previewItems: previewItems)
        quickLookController.onKeyboardPressTap = { [weak self] text in
            self?.logInfo(text: text)
        }
        present(quickLookController, animated: true) {
            self.logInfo(text: "--- FYI: If the assets are broken, keyboard presses work! ---")
        }
    }

    @IBAction func buggedPreviewAction(_ sender: Any) {
        let previewItems = [
            PreviewItem(fileName: "1", fileExtension: "png"), // is available in the project
            PreviewItem(fileName: "2", fileExtension: "png"), // is available in the project
            PreviewItem(fileName: "3", fileExtension: "png") // is available in the project
        ]
        let quickLookController = PreviewViewController(previewItems: previewItems)
        quickLookController.onKeyboardPressTap = { [weak self] text in
            self?.logInfo(text: text)
        }
        present(quickLookController, animated: true) {
            self.logInfo(text: "--- BUG - If the assets are proper, keyboard presses do NOT work! ---")
        }
    }
}

private extension ViewController {

    func logInfo(text: String) {
        logLabel.text?.append("\n\(text)")
        print(text)
    }

    @objc func upAction() {
        logInfo(text: "ViewController: UP")
    }

    @objc func downAction() {
        logInfo(text: "ViewController: DOWN")
    }

    @objc func leftAction() {
        logInfo(text: "ViewController: LEFT")
    }

    @objc func rightAction() {
        logInfo(text: "ViewController: RIGHT")
    }
}
