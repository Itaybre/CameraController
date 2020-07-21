//
//  USBHeaders.h
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

#include <stdint.h>

struct UVC_InterfaceDescriptorHdr {
    uint8_t bLength;
    uint8_t bDescriptorType;
    uint8_t bDescriptorSubType;
};

#pragma pack(1)    /* needed here because otherwise there would be a gap of
1 byte added before bcdUV. */
struct UVC_VCHeaderDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint16_t bcdUVC;
    uint16_t wTotalLength;
    uint32_t dwClockFrequency;
    uint8_t  bInCollection;
    uint8_t  baInterface;    /* TODO: array, but we're not using this. */
};
#pragma pack(pop)

struct UVC_CameraTerminalDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint8_t  bTerminalID;
    uint16_t wTerminalType;
    uint8_t  bAssocTerminal;
    uint8_t  iTerminal;
    uint16_t wObjectiveFocalLengthMin;
    uint16_t wObjectiveFocalLengthMax;
    uint16_t wOcularFocalLength;
    uint8_t  bControlSize;
    uint8_t  bmControls;    /* TODO: array, but we're not using this (yet). */
};

#pragma pack(1)
struct UVC_ProcessingUnitDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint8_t  bUnitID;
    uint8_t  bSourceID;
    uint16_t wMaxMultiplier;
    uint8_t  bControlSize;
    uint8_t  bmControls;    /* TODO: array, but we're not using this (yet). */
    /* TODO: iProcessing and bmVideoStandards */
};
#pragma pack(pop)
