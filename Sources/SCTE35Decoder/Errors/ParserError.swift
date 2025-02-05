//
//  ParserError.swift
//  
//
//  Created by Robert Galluccio on 06/02/2021.
//

import Foundation

public enum ParserError: Equatable, LocalizedError, CustomNSError {
    case unexpectedEndOfData(UnexpectedEndOfDataErrorInfo)
    case invalidInputString(String)
    case invalidSectionSyntaxIndicator
    case invalidPrivateIndicator
    case unrecognisedSpliceCommandType(Int)
    case unrecognisedSegmentationUPIDType(Int)
    case unexpectedSegmentationUPIDLength(UnexpectedSegmentationUPIDLengthErrorInfo)
    case invalidUUIDInSegmentationUPID(String)
    case invalidURLInSegmentationUPID(String)
    case unrecognisedSegmentationTypeID(Int)
    case invalidSegmentationDescriptorIdentifier(Int)
    case invalidATSCContentIdentifierInUPID(InvalidATSCContentIdentifierInUPIDInfo)
    case invalidMPUInSegmentationUPID(InvalidMPUInSegmentationUPIDInfo)
    case invalidBitStreamMode(InvalidBitStreamModeErrorInfo)
    case unrecognisedAudioCodingMode(Int)
    case unrecognisedSpliceDescriptorTag(Int)
    case encryptedMessageNotSupported
    case unexpectedSpliceCommandLength(UnexpectedSpliceCommandLengthErrorInfo)
    case unexpectedDescriptorLoopLength(UnexpectedDescriptorLoopLengthErrorInfo)
    case unexpectedSpliceDescriptorLength(UnexpectedSpliceDescriptorLengthErrorInfo)
    
    public static var errorDomain: String { "SCTE35DecoderError" }
    
    public static let unexpectedEndOfDataUserInfoKey = "unexpectedEndOfDataUserInfoKey"
    public static let invalidInputStringUserInfoKey = "invalidUserInputUserInfoKey"
    public static let unrecognisedSpliceCommandTypeUserInfoKey = "unrecognisedSpliceCommandTypeUserInfokey"
    public static let unrecognisedSegmentationUPIDTypeUserInfoKey = "unrecognisedSegmentationUPIDTypeUserInfoKey"
    public static let invalidUUIDInSegmentationUPIDUserInfoKey = "invalidUUIDInSegmentationUPIDUserInfoKey"
    public static let invalidURLInSegmentationUPIDUserInfoKey = "invalidURLInSegmentationUPIDUserInfoKey"
    public static let unrecognisedSegmentationTypeIDUserInfoKey = "unrecognisedSegmentationTypeIDUserInfoKey"
    public static let unexpectedSegmentationUPIDLengthUserInfoKey = "unexpectedSegmentationUPIDLengthUserInfoKey"
    public static let invalidSegmentationDescriptorIdentifierUserInfoKey = "invalidSegmentationDescriptorIdentifierUserInfoKey"
    public static let invalidATSCContentIdentifierInUPIDUserInfoKey = "invalidATSCContentIdentifierInUPIDUserInfoKey"
    public static let invalidMPUInSegmentationUPIDUserInfoKey = "invalidMPUInSegmentationUPIDUserInfoKey"
    public static let invalidBitStreamModeUserInfoKey = "invalidBitStreamModeUserInfoKey"
    public static let unrecognisedAudioCodingModeUserInfoKey = "unrecognisedAudioCodingModeUserInfoKey"
    public static let unrecognisedSpliceDescriptorTagUserInfoKey = "unrecognisedSpliceDescriptorTagUserInfoKey"
    public static let encryptedMessageNotSupportedUserInfoKey = "encryptedMessageNotSupportedUserInfoKey"
    public static let unexpectedSpliceCommandLengthUserInfoKey = "unexpectedSpliceCommandLengthUserInfoKey"
    public static let unexpectedDescriptorLoopLengthUserInfoKey = "unexpectedDescriptorLoopLengthUserInfoKey"
    public static let unexpectedSpliceDescriptorLengthUserInfoKey = "unexpectedSpliceDescriptorLengthUserInfoKey"
    
    public var code: Code {
        switch self {
        case .unexpectedEndOfData: return .unexpectedEndOfData
        case .invalidInputString: return .invalidInputString
        case .invalidSectionSyntaxIndicator: return .invalidSectionSyntaxIndicator
        case .invalidPrivateIndicator: return .invalidPrivateIndicator
        case .unrecognisedSpliceCommandType: return .unrecognisedSpliceCommandType
        case .unrecognisedSegmentationUPIDType: return .unrecognisedSegmentationUPIDType
        case .unexpectedSegmentationUPIDLength: return .unexpectedSegmentationUPIDLength
        case .invalidUUIDInSegmentationUPID: return .invalidUUIDInSegmentationUPID
        case .invalidURLInSegmentationUPID: return .invalidURLInSegmentationUPID
        case .unrecognisedSegmentationTypeID: return .unrecognisedSegmentationTypeID
        case .invalidSegmentationDescriptorIdentifier: return .invalidSegmentationDescriptorIdentifier
        case .invalidATSCContentIdentifierInUPID: return .invalidATSCContentIdentifierInUPID
        case .invalidMPUInSegmentationUPID: return .invalidMPUInSegmentationUPID
        case .invalidBitStreamMode: return .invalidBitStreamMode
        case .unrecognisedAudioCodingMode: return .unrecognisedAudioCodingMode
        case .unrecognisedSpliceDescriptorTag: return .unrecognisedSpliceDescriptorTag
        case .encryptedMessageNotSupported: return .encryptedMessageNotSupported
        case .unexpectedSpliceCommandLength: return .unexpectedSpliceCommandLength
        case .unexpectedDescriptorLoopLength: return .unexpectedDescriptorLoopLength
        case .unexpectedSpliceDescriptorLength: return .unexpectedSpliceDescriptorLength
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .unexpectedEndOfData:
            return "Unexpected end of data during parsing."
        case .invalidInputString:
            return "String input could not be converted to Data."
        case .invalidSectionSyntaxIndicator:
            return "Invalid section syntax indicator."
        case .invalidPrivateIndicator:
            return "Invalid private indicator."
        case .unrecognisedSpliceCommandType(let type):
            return "\(type) is an invalid splice command type."
        case .unrecognisedSegmentationUPIDType(let type):
            return "\(type) is an invalid segmentation upid type."
        case .unexpectedSegmentationUPIDLength:
            return "Unexpected mis-match between declared segmentation upid length and upid type."
        case .invalidUUIDInSegmentationUPID:
            return "The uuid string read from the segmentation upid was not a valid UUID."
        case .invalidURLInSegmentationUPID:
            return "The url string read from the segmentation upid was not a valid URL."
        case .unrecognisedSegmentationTypeID(let type):
            return "\(type) is an invalid segmentation type id."
        case .invalidSegmentationDescriptorIdentifier:
            return "Invalid segmentation descriptor identifier (was not 0x43554549)."
        case .invalidATSCContentIdentifierInUPID:
            return "Invalid upid length defined for ATSC content identifier."
        case .invalidMPUInSegmentationUPID:
            return "Invalid upid length defined for MPU."
        case .invalidBitStreamMode(let info):
            var acmodString = "nil"
            if let acmod = info.acmod {
                acmodString = "\(acmod)"
            }
            return "\(info.bsmod) bit stream mode and \(acmodString) audio coding mode is an invalid combination."
        case .unrecognisedAudioCodingMode(let type):
            return "\(type) is an invalid audio coding mode."
        case .unrecognisedSpliceDescriptorTag(let type):
            return "\(type) is an invalid splice descriptor tag."
        case .encryptedMessageNotSupported:
            return "Encrypted message is not supported."
        case .unexpectedSpliceCommandLength:
            return "Unexpected mis-match between declared splice command length and number of bits required to parse the command."
        case .unexpectedDescriptorLoopLength:
            return "Unexpected mis-match between declared descriptor loop length and number of bits required to parse the array of splice descriptors."
        case .unexpectedSpliceDescriptorLength:
            return "Unexpected mis-match between declared splice descriptor length and number of bits required to parse the descriptor."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .unexpectedEndOfData(let info):
            return "Expected at least \(info.expectedMinimumBitsLeft) bits left and instead was \(info.actualBitsLeft) when parsing: \(info.description)."
        case .invalidInputString(let input):
            return "String could not be converted to Data: \(input)"
        case .invalidSectionSyntaxIndicator:
            return "The 1-bit section syntax indicator was not 0."
        case .invalidPrivateIndicator:
            return "The 1-bit private indicator was not 0."
        case .unrecognisedSpliceCommandType(let type):
            return "Value \(type) was obtained for splice command type and this does not match any known values."
        case .unrecognisedSegmentationUPIDType(let type):
            return "Value \(type) was obtained for segmentation upid type and this does not match any known values."
        case .unexpectedSegmentationUPIDLength(let info):
            return "Declared upid length was \(info.declaredSegmentationUPIDLength); however, expected length for upid type \(info.segmentationUPIDType) is \(info.expectedSegmentationUPIDLength)."
        case .invalidUUIDInSegmentationUPID(let uuidString):
            return "\(uuidString) is not a valid UUID."
        case .invalidURLInSegmentationUPID(let urlString):
            return "\(urlString) is not a valid URL."
        case .unrecognisedSegmentationTypeID(let type):
            return "Value \(type) was obtained for segmentation type id and this does not match any known values."
        case .invalidSegmentationDescriptorIdentifier(let value):
            return "Value \(value) was obtained for segmentation descriptor identifier but this should be 0x43554549."
        case .invalidATSCContentIdentifierInUPID(let info):
            return "UPID length defined as \(info.upidLength), and \(info.staticBytesLength) bytes are taken up by static fields, implying contentID has \(info.calculatedContentIDByteCount) bytes left, which is invalid."
        case .invalidMPUInSegmentationUPID(let info):
            return "UPID length defined as \(info.upidLength), and \(info.staticBytesLength) bytes are taken up by static fields, implying private data has \(info.calculatedPrivateDataByteCount) bytes left, which is invalid."
        case .invalidBitStreamMode(let info):
            var acmodString = "nil"
            if let acmod = info.acmod {
                acmodString = "\(acmod)"
            }
            return "Value \(info.bsmod) was obtained for bit stream mode, and \(acmodString) was obtained for audio coding mode, but this combination is not a valid BitStreamMode."
        case .unrecognisedAudioCodingMode(let type):
            return "Value \(type) was obtained for audio coding mode and this does not match any known values."
        case .unrecognisedSpliceDescriptorTag(let type):
            return "Value \(type) was obtained for splice descriptor tag and this does not match any known values."
        case .encryptedMessageNotSupported:
            return "The SpliceInfoSection was determined to be encrypted and this is not currently supported"
        case .unexpectedSpliceCommandLength(let info):
            return "Declared splice command (\(info.spliceCommandType.rawValue)) length was \(info.declaredSpliceCommandLengthInBits) bits; however, number of bits needed to parse the section was \(info.actualSpliceCommandLengthInBits)."
        case .unexpectedDescriptorLoopLength(let info):
            return "Declared descriptor loop length was \(info.declaredDescriptorLoopLengthInBits) bits; however, number of bits needed to parse the array was \(info.actualDescriptorLoopLengthInBits)."
        case .unexpectedSpliceDescriptorLength(let info):
            return "Declared splice descriptor (\(info.spliceDescriptorTag.rawValue)) length was \(info.declaredSpliceDescriptorLengthInBits) bits; however, number of bits needed to parse the descriptor was \(info.actualSpliceDescriptorLengthInBits)."
        }
    }
    
    public var errorCode: Int { code.rawValue }
    
    public var errorUserInfo: [String: Any] {
        switch self {
        case .unexpectedEndOfData(let info): return [Self.unexpectedEndOfDataUserInfoKey: info]
        case .invalidInputString(let input): return [Self.invalidInputStringUserInfoKey: input]
        case .invalidSectionSyntaxIndicator: return [:]
        case .invalidPrivateIndicator: return [:]
        case .unrecognisedSpliceCommandType(let type): return [Self.unrecognisedSpliceCommandTypeUserInfoKey: type]
        case .unrecognisedSegmentationUPIDType(let type): return [Self.unrecognisedSegmentationUPIDTypeUserInfoKey: type]
        case .unexpectedSegmentationUPIDLength(let info): return [Self.unexpectedSegmentationUPIDLengthUserInfoKey: info]
        case .invalidUUIDInSegmentationUPID(let uuidString): return [Self.invalidUUIDInSegmentationUPIDUserInfoKey: uuidString]
        case .invalidURLInSegmentationUPID(let urlString): return [Self.invalidURLInSegmentationUPIDUserInfoKey: urlString]
        case .unrecognisedSegmentationTypeID(let type): return [Self.unrecognisedSegmentationTypeIDUserInfoKey: type]
        case .invalidSegmentationDescriptorIdentifier(let value): return [Self.invalidSegmentationDescriptorIdentifierUserInfoKey: value]
        case .invalidATSCContentIdentifierInUPID(let info): return [Self.invalidATSCContentIdentifierInUPIDUserInfoKey: info]
        case .invalidMPUInSegmentationUPID(let info): return [Self.invalidMPUInSegmentationUPIDUserInfoKey: info]
        case .invalidBitStreamMode(let info): return [Self.invalidBitStreamModeUserInfoKey: info]
        case .unrecognisedAudioCodingMode(let type): return [Self.unrecognisedAudioCodingModeUserInfoKey: type]
        case .unrecognisedSpliceDescriptorTag(let type): return [Self.unrecognisedSpliceDescriptorTagUserInfoKey: type]
        case .encryptedMessageNotSupported: return [:]
        case .unexpectedSpliceCommandLength(let info): return [Self.unexpectedSpliceCommandLengthUserInfoKey: info]
        case .unexpectedDescriptorLoopLength(let info): return [Self.unexpectedDescriptorLoopLengthUserInfoKey: info]
        case .unexpectedSpliceDescriptorLength(let info): return [Self.unexpectedSpliceDescriptorLengthUserInfoKey: info]
        }
    }
    
    public init?(fromNSError nsError: NSError) {
        guard nsError.domain == ParserError.errorDomain, let code = Code(rawValue: nsError.code) else {
            return nil
        }
        switch code {
        case .encryptedMessageNotSupported:
            self = .encryptedMessageNotSupported
        case .invalidATSCContentIdentifierInUPID:
            guard let info = nsError.userInfo[Self.invalidATSCContentIdentifierInUPIDUserInfoKey] as? InvalidATSCContentIdentifierInUPIDInfo else { return nil }
            self = .invalidATSCContentIdentifierInUPID(info)
        case .invalidBitStreamMode:
            guard let info = nsError.userInfo[Self.invalidBitStreamModeUserInfoKey] as? InvalidBitStreamModeErrorInfo else { return nil }
            self = .invalidBitStreamMode(info)
        case .invalidInputString:
            guard let string = nsError.userInfo[Self.invalidInputStringUserInfoKey] as? String else { return nil }
            self = .invalidInputString(string)
        case .invalidMPUInSegmentationUPID:
            guard let info = nsError.userInfo[Self.invalidMPUInSegmentationUPIDUserInfoKey] as? InvalidMPUInSegmentationUPIDInfo else { return nil }
            self = .invalidMPUInSegmentationUPID(info)
        case .invalidPrivateIndicator:
            self = .invalidPrivateIndicator
        case .invalidSectionSyntaxIndicator:
            self = .invalidSectionSyntaxIndicator
        case .invalidSegmentationDescriptorIdentifier:
            guard let id = nsError.userInfo[Self.invalidSegmentationDescriptorIdentifierUserInfoKey] as? Int else { return nil }
            self = .invalidSegmentationDescriptorIdentifier(id)
        case .invalidURLInSegmentationUPID:
            guard let string = nsError.userInfo[Self.invalidURLInSegmentationUPIDUserInfoKey] as? String else { return nil }
            self = .invalidURLInSegmentationUPID(string)
        case .invalidUUIDInSegmentationUPID:
            guard let string = nsError.userInfo[Self.invalidUUIDInSegmentationUPIDUserInfoKey] as? String else { return nil }
            self = .invalidUUIDInSegmentationUPID(string)
        case .unexpectedEndOfData:
            guard let info = nsError.userInfo[Self.unexpectedEndOfDataUserInfoKey] as? UnexpectedEndOfDataErrorInfo else { return nil }
            self = .unexpectedEndOfData(info)
        case .unexpectedSegmentationUPIDLength:
            guard let info = nsError.userInfo[Self.unexpectedSegmentationUPIDLengthUserInfoKey] as? UnexpectedSegmentationUPIDLengthErrorInfo else { return nil }
            self = .unexpectedSegmentationUPIDLength(info)
        case .unrecognisedAudioCodingMode:
            guard let mode = nsError.userInfo[Self.unrecognisedAudioCodingModeUserInfoKey] as? Int else { return nil }
            self = .unrecognisedAudioCodingMode(mode)
        case .unrecognisedSegmentationTypeID:
            guard let id = nsError.userInfo[Self.unrecognisedSegmentationTypeIDUserInfoKey] as? Int else { return nil }
            self = .unrecognisedSegmentationTypeID(id)
        case .unrecognisedSegmentationUPIDType:
            guard let id = nsError.userInfo[Self.unrecognisedSegmentationUPIDTypeUserInfoKey] as? Int else { return nil }
            self = .unrecognisedSegmentationUPIDType(id)
        case .unrecognisedSpliceCommandType:
            guard let id = nsError.userInfo[Self.unrecognisedSpliceCommandTypeUserInfoKey] as? Int else { return nil }
            self = .unrecognisedSpliceCommandType(id)
        case .unrecognisedSpliceDescriptorTag:
            guard let id = nsError.userInfo[Self.unrecognisedSpliceDescriptorTagUserInfoKey] as? Int else { return nil }
            self = .unrecognisedSpliceDescriptorTag(id)
        case .unexpectedSpliceCommandLength:
            guard let info = nsError.userInfo[Self.unexpectedSpliceCommandLengthUserInfoKey] as? UnexpectedSpliceCommandLengthErrorInfo else { return nil }
            self = .unexpectedSpliceCommandLength(info)
        case .unexpectedDescriptorLoopLength:
            guard let info = nsError.userInfo[Self.unexpectedDescriptorLoopLengthUserInfoKey] as? UnexpectedDescriptorLoopLengthErrorInfo else { return nil }
            self = .unexpectedDescriptorLoopLength(info)
        case .unexpectedSpliceDescriptorLength:
            guard let info = nsError.userInfo[Self.unexpectedSpliceDescriptorLengthUserInfoKey] as? UnexpectedSpliceDescriptorLengthErrorInfo else { return nil }
            self = .unexpectedSpliceDescriptorLength(info)
        }
    }
}
