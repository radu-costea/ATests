//
//  ValidationFormViewController.swift
//  ATests
//
//  Created by Radu Costea on 12/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class ValidationFormViewController: BaseViewController, ValidationTextFieldDelegate {
    lazy var bindings: [ValidationTextField: FieldValidationViewModel] = self.createBindings()
    lazy var viewModels: [FieldValidationViewModel] = self.createViewModels()
    var formIsValid: Bool { return viewModels.reduce(true){ $0 && $1.isValid } }
    
    // MARK: - Validation text field delegate
    
    func validationFieldTextDidChanged(validationField: ValidationTextField) {
        if var vm = bindings[validationField] {
            vm.textTouched = true
            vm.text = validationField.text
            syncField(validationField, withViewModel: vm)
        }
    }
    
    func validationFieldTextDidEndEditing(validationField: ValidationTextField) {
        if var vm = bindings[validationField] {
            vm.textTouched = true
            syncField(validationField, withViewModel: vm)
        }
    }
    
    func validationFieldTextDidBeginEditing(validationField: ValidationTextField) { }
    
    // MARK: - TO Override
    
    func createBindings() -> [ValidationTextField: FieldValidationViewModel] { return [:] }
    func createViewModels() -> [FieldValidationViewModel] { return [] }
    
    // MARK: - Helper methods
    
    private func syncField(field: ValidationTextField, withViewModel model: FieldValidationViewModel) -> Void {
        field.setValidationIconVisible(model.textTouched)
        field.setTextIsValid(model.isValid)
    }
}