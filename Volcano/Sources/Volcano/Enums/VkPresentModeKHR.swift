//
//  VkPresentModeKHR.swift
//  Volcano
//
//  Created by Serhii Mumriak on 27.12.2020.
//

import CVulkan

public typealias VkPresentModeKHR = CVulkan.VkPresentModeKHR

public extension VkPresentModeKHR {
    static let immediate: VkPresentModeKHR = .VK_PRESENT_MODE_IMMEDIATE_KHR
    static let mailbox: VkPresentModeKHR = .VK_PRESENT_MODE_MAILBOX_KHR
    static let fifo: VkPresentModeKHR = .VK_PRESENT_MODE_FIFO_KHR
    static let fifoRelaxed: VkPresentModeKHR = .VK_PRESENT_MODE_FIFO_RELAXED_KHR
    static let sharedDemandRefresh: VkPresentModeKHR = .VK_PRESENT_MODE_SHARED_DEMAND_REFRESH_KHR
    static let sharedContinuousRefresh: VkPresentModeKHR = .VK_PRESENT_MODE_SHARED_CONTINUOUS_REFRESH_KHR
}
