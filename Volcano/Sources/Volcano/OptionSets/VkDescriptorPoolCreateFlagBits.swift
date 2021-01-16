//
//  VkDescriptorPoolCreateFlagBits.swift
//  Volcano
//
//  Created by Serhii Mumriak on 16.08.2020.
//

import CVulkan

public typealias VkDescriptorPoolCreateFlagBits = CVulkan.VkDescriptorPoolCreateFlagBits

public extension VkDescriptorPoolCreateFlagBits {
    static let freeDescriptorSet = VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT
    static let updateAfterBind = VK_DESCRIPTOR_POOL_CREATE_UPDATE_AFTER_BIND_BIT
    static let updateAfterBindExt = VK_DESCRIPTOR_POOL_CREATE_UPDATE_AFTER_BIND_BIT_EXT
}
