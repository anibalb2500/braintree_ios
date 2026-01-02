import Foundation

@objc public enum BTPayPalFundingSource: Int {
    case payPal
    case payLater
    case credit

    var stringValue: String {
        switch self {
        case .payPal:
            return "paypal"
        case .payLater:
            return "paylater"
        case .credit:
            return "credit"
        }
    }
}

extension BTPayPalRequest {
    var fundingSource: BTPayPalFundingSource {
        if
            let checkoutRequest = self as? BTPayPalCheckoutRequest,
            checkoutRequest.offerPayLater
        {
            return .payLater
        }

        let offersCredit =
            (self as? BTPayPalCheckoutRequest)?.offerCredit ??
            (self as? BTPayPalVaultRequest)?.offerCredit ?? false

        return offersCredit ? .credit : .payPal
    }
}

