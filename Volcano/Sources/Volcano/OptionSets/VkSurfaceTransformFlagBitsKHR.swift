//
//  VkSurfaceTransformFlagBitsKHR.swift
//  Volcano
//
//  Created by Serhii Mumriak on 17.08.2020.
//

import CVulkan

public typealias VkSurfaceTransformFlagBitsKHR = CVulkan.VkSurfaceTransformFlagBitsKHR

public extension VkSurfaceTransformFlagBitsKHR {
    static let identity = VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR
    static let rotate90 = VK_SURFACE_TRANSFORM_ROTATE_90_BIT_KHR
    static let rotate180 = VK_SURFACE_TRANSFORM_ROTATE_180_BIT_KHR
    static let rotate270 = VK_SURFACE_TRANSFORM_ROTATE_270_BIT_KHR
    static let horizontalMirror = VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_BIT_KHR
    static let horizontalMirrorRotate90 = VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_90_BIT_KHR
    static let horizontalMirrorRotate180 = VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_180_BIT_KHR
    static let horizontalMirrorRotate270 = VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_270_BIT_KHR
    static let inherit = VK_SURFACE_TRANSFORM_INHERIT_BIT_KHR
}
