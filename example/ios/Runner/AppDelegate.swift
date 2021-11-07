import CreditCardScanner
import Flutter
import UIKit

fileprivate struct ChannelStrings {
    static let channelName = "card_scanner_channel"
    static let startCardScannerMethod = "start_card_scanner_method"
    static let retrieveCardMethod = "retrieve_card_method"
}

fileprivate struct CameraStrings {
    static let titleLabel = "Наведите на карту"
    static let subtitleLabel = ""
    static let cancelButtonTitle = "Отмена"
}

fileprivate struct Card: Codable {
    let name: String?
    let number: String?
    let expireDate: ExpireDate?
}

fileprivate struct ExpireDate: Codable {
    let year: Int?
    let month: Int?
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CreditCardScannerViewControllerDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name:  ChannelStrings.channelName, binaryMessenger: controller.binaryMessenger)
        methodChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == ChannelStrings.startCardScannerMethod {
                let creditCardScannerViewController = CreditCardScannerViewController(delegate: self)
                creditCardScannerViewController.titleLabelText = CameraStrings.titleLabel
                creditCardScannerViewController.subtitleLabelText = CameraStrings.subtitleLabel
                creditCardScannerViewController.cancelButtonTitleText = CameraStrings.cancelButtonTitle
                controller.present(creditCardScannerViewController, animated: true)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func creditCardScannerViewController(_ viewController: CreditCardScannerViewController, didErrorWith error: CreditCardScannerError) {
        print(error.errorDescription ?? "Card scanner error: \(error.errorDescription ?? "Unknown error")")
        viewController.dismiss(animated: true)
    }
    
    func creditCardScannerViewControllerDidCancel(_ viewController: CreditCardScannerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func creditCardScannerViewController(_ viewController: CreditCardScannerViewController, didFinishWith card: CreditCard) {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: ChannelStrings.channelName, binaryMessenger: controller.binaryMessenger)
        
        let card = Card(
            name: card.name,
            number: card.number,
            expireDate: ExpireDate(
                year: card.expireDate?.year,
                month: card.expireDate?.month
            )
        )
        
        do {
            let jsonData = try JSONEncoder().encode(card)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            // Example jsonString: {"name":"TOMAS EDISON","number":"2201382325881345","expireDate":{"year":2024,"month":6}}
            methodChannel.invokeMethod(ChannelStrings.retrieveCardMethod, arguments: jsonString)
        } catch {
            print("JSON encode error: \(error)")
        }
        
        viewController.dismiss(animated: true)
    }
}
