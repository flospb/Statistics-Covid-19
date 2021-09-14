//
//  VaccinationViewControllerTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import XCTest

class VaccinationViewControllerTests: XCTestCase {
    var sut: IVaccinationViewController!
    var view: VaccinationViewMock!
    var router: MainRouterMock!
    var builder: AssemblyBuilderMock!
    var storageService: ImageStorageServiceMock!

    override func setUp() {
        super.setUp()
        view = VaccinationViewMock()
        router = MainRouterMock()
        builder = AssemblyBuilderMock()
        storageService = ImageStorageServiceMock()
        sut = VaccinationViewController(view: view, router: router, builder: builder, imageStorageService: storageService)
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
        builder = nil
        storageService = nil
        sut = nil
    }

    func testThatCheckQrCertificateCodeTapped() {
        // act
        sut.qrCertificateCodeTapped()

        // assert
        XCTAssertTrue(router.openImagePickerControllerWasCalled)
    }

    func testThatCheckLinkContactTapped() {
        // arrange
        let url = "test url"

        // act
        sut.linkContactTapped(url: url)

        // assert
        XCTAssertTrue(router.openWebViewControllerWasCalled)
    }

    func testThatCheckClearCertificateButtonTapped() {
        // act
        sut.clearCertificateButtonTapped()

        // assert
        XCTAssertTrue(storageService.clearImageWasCalled)
    }
}
