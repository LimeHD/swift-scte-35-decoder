import XCTest
@testable import SCTE35Parser

final class SCTE35ParserTests: XCTestCase {
    // MARK: - SCTE-35 2020 - 14. Sample SCTE 35 Messages (Informative)
    
    // 14.1. time_signal – Placement Opportunity Start
    func test_timeSignal_placementOpportunityStart() throws {
        let base64String = "/DA0AAAAAAAA///wBQb+cr0AUAAeAhxDVUVJSAAAjn/PAAGlmbAICAAAAAAsoKGKNAIAmsnRfg=="
        let hexString = "0xFC3034000000000000FFFFF00506FE72BD0050001E021C435545494800008E7FCF0001A599B00808000000002CA0A18A3402009AC9D17E"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 1924989008))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959694,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: false,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: 27630000,
                            segmentationUPID: .ti("0x000000002CA0A18A"),
                            segmentationTypeID: .providerPlacementOpportunityStart,
                            segmentNum: 2,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0x9AC9D17E
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.2. splice_insert
    func test_spliceInsert() {
        let base64String = "/DAvAAAAAAAA///wFAVIAACPf+/+c2nALv4AUsz1AAAAAAAKAAhDVUVJAAABNWLbowo="
        let hexString = "0xFC302F000000000000FFFFF014054800008F7FEFFE7369C02EFE0052CCF500000000000A0008435545490000013562DBA30A"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .spliceInsert(
                SpliceInsert(
                    eventId: 1207959695,
                    scheduledEvent: SpliceInsert.ScheduledEvent(
                        outOfNetworkIndicator: true,
                        isImmediateSplice: false,
                        spliceMode: .programSpliceMode(
                            SpliceInsert.ScheduledEvent.SpliceMode.ProgramMode(
                                spliceTime: SpliceTime(ptsTime: 1936310318)
                            )
                        ),
                        breakDuration: BreakDuration(
                            autoReturn: true,
                            duration: 5426421
                        ),
                        uniqueProgramId: 0,
                        availNum: 0,
                        availsExpected: 0
                    )
                )
            ),
            spliceDescriptors: [
                .availDescriptor(
                    AvailDescriptor(
                        identifier: 1129661769,
                        providerAvailId: 309
                    )
                )
            ],
            CRC_32: 0x62DBA30A
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.3. time_signal – Placement Opportunity End
    func test_timeSignal_placementOpportunityEnd() {
        let base64String = "/DAvAAAAAAAA///wBQb+dGKQoAAZAhdDVUVJSAAAjn+fCAgAAAAALKChijUCAKnMZ1g="
        let hexString = "0xFC302F000000000000FFFFF00506FE746290A000190217435545494800008E7F9F0808000000002CA0A18A350200A9CC6758"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 1952616608))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959694,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA0A18A"),
                            segmentationTypeID: .providerPlacementOpportunityEnd,
                            segmentNum: 2,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0xA9CC6758
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.4. time_signal – Program Start/End
    func test_timeSignal_programStartEnd() {
        let base64String = "/DBIAAAAAAAA///wBQb+ek2ItgAyAhdDVUVJSAAAGH+fCAgAAAAALMvDRBEAAAIXQ1VFSUgAABl/nwgIAAAAACyk26AQAACZcuND"
        let hexString = "0xFC3048000000000000FFFFF00506FE7A4D88B60032021743554549480000187F9F0808000000002CCBC344110000021743554549480000197F9F0808000000002CA4DBA01000009972E343"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 2051901622))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959576,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CCBC344"),
                            segmentationTypeID: .programEnd,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                ),
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959577,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA4DBA0"),
                            segmentationTypeID: .programStart,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0x9972E343
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.5. time_signal – Program Overlap Start
    func test_timeSignal_programOverlapStart() {
        let base64String = "/DAvAAAAAAAA///wBQb+rr//ZAAZAhdDVUVJSAAACH+fCAgAAAAALKVs9RcAAJUdsKg="
        let hexString = "0xFC302F000000000000FFFFF00506FEAEBFFF640019021743554549480000087F9F0808000000002CA56CF5170000951DB0A8"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 2931818340))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959560,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA56CF5"),
                            segmentationTypeID: .programOverlapStart,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0x951DB0A8
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.6. time_signal – Program Blackout Override / Program End
    func test_timeSignal_programBlackoutoverrideProgramEnd() {
        let base64String = "/DBIAAAAAAAA///wBQb+ky44CwAyAhdDVUVJSAAACn+fCAgAAAAALKCh4xgAAAIXQ1VFSUgAAAl/nwgIAAAAACygoYoRAAC0IX6w"
        let hexString = "0xFC3048000000000000FFFFF00506FE932E380B00320217435545494800000A7F9F0808000000002CA0A1E3180000021743554549480000097F9F0808000000002CA0A18A110000B4217EB0"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 2469279755))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959562,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA0A1E3"),
                            segmentationTypeID: .programBlackoutOverride,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                ),
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959561,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA0A18A"),
                            segmentationTypeID: .programEnd,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0xB4217EB0
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.7. time_signal – Program End
    func test_timeSignal_programEnd() {
        let base64String = "/DAvAAAAAAAA///wBQb+rvF8TAAZAhdDVUVJSAAAB3+fCAgAAAAALKVslxEAAMSHai4="
        let hexString = "0xFC302F000000000000FFFFF00506FEAEF17C4C0019021743554549480000077F9F0808000000002CA56C97110000C4876A2E"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 2935061580))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959559,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CA56C97"),
                            segmentationTypeID: .programEnd,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0xC4876A2E
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
    
    // 14.8. time_signal – Program Start/End - Placement Opportunity End
    func test_timeSignal_programStartEnd_placementOpportunityEnd() {
        let base64String = "/DBhAAAAAAAA///wBQb+qM1E7QBLAhdDVUVJSAAArX+fCAgAAAAALLLXnTUCAAIXQ1VFSUgAACZ/nwgIAAAAACyy150RAAACF0NVRUlIAAAnf58ICAAAAAAsstezEAAAihiGnw=="
        let hexString = "0xFC3061000000000000FFFFF00506FEA8CD44ED004B021743554549480000AD7F9F0808000000002CB2D79D350200021743554549480000267F9F0808000000002CB2D79D110000021743554549480000277F9F0808000000002CB2D7B31000008A18869F"
        let expectedSpliceInfoSection = SpliceInfoSection(
            tableID: 252,
            sapType: .unspecified,
            protocolVersion: 0,
            encryptedPacket: nil,
            ptsAdjustment: 0,
            tier: 0xFFF,
            spliceCommand: .timeSignal(TimeSignal(spliceTime: SpliceTime(ptsTime: 2832024813))),
            spliceDescriptors: [
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959725,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CB2D79D"),
                            segmentationTypeID: .providerPlacementOpportunityEnd,
                            segmentNum: 2,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                ),
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959590,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CB2D79D"),
                            segmentationTypeID: .programEnd,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                ),
                .segmentationDescriptor(
                    SegmentationDescriptor(
                        identifier: 1129661769,
                        eventId: 1207959591,
                        scheduledEvent: SegmentationDescriptor.ScheduledEvent(
                            deliveryRestrictions: SegmentationDescriptor.ScheduledEvent.DeliveryRestrictions(
                                webDeliveryAllowed: true,
                                noRegionalBlackout: true,
                                archiveAllowed: true,
                                deviceRestrictions: .none
                            ),
                            componentSegments: nil,
                            segmentationDuration: nil,
                            segmentationUPID: .ti("0x000000002CB2D7B3"),
                            segmentationTypeID: .programStart,
                            segmentNum: 0,
                            segmentsExpected: 0,
                            subSegment: nil
                        )
                    )
                )
            ],
            CRC_32: 0x8A18869F
        )
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(base64String))
        try XCTAssertEqual(expectedSpliceInfoSection, SpliceInfoSection(hexString))
    }
}
