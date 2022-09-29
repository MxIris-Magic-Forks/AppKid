//
//  Framebuffer.swift
//  Volcano
//
//  Created by Serhii Mumriak on 29.08.2020.
//

import TinyFoundation
import CVulkan

public final class Framebuffer: DeviceEntity<VkFramebuffer_T> {
    public fileprivate(set) var attachments: [ImageView]

    public init(device: Device, size: VkExtent2D, renderPass: RenderPass, attachments: [ImageView], layersCount: CUnsignedInt = 1) throws {
        self.attachments = attachments

        let handle: SharedPointer<VkFramebuffer_T> = try attachments
            .map { $0.pointer as VkImageView? }
            .withUnsafeBufferPointer { attachments in
                var info = VkFramebufferCreateInfo.new()
                info.renderPass = renderPass.pointer
                info.attachmentCount = CUnsignedInt(attachments.count)
                info.pAttachments = attachments.baseAddress!
                info.width = size.width
                info.height = size.height
                info.layers = layersCount

                return try device.create(with: &info)
            }

        try super.init(device: device, handle: handle)
    }
}
