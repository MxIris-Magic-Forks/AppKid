//
//  Shader.swift
//  Volcano
//
//  Created by Serhii Mumriak on 20.05.2020.
//

import Foundation
import TinyFoundation
import CVulkan

public enum VulkanShaderError: Error {
    case noData
    case noSuchFile
}

public final class Shader: VulkanDeviceEntity<SmartPointer<VkShaderModule_T>> {
    public let entryPoint: String

    public convenience init(named name: String, entryPoint: String = "main", in bundle: Bundle? = nil, device: Device) throws {
        let bundle = bundle ?? Bundle.main

        let nameCasted = name as NSString
        let fileName = nameCasted.deletingPathExtension
        var fileExtension = nameCasted.pathExtension
        if fileExtension.isEmpty {
            fileExtension = "spv"
        }

        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw VulkanShaderError.noSuchFile
        }

        let data = try Data(contentsOf: url, options: [])

        try self.init(data: data, entryPoint: entryPoint, device: device)
    }

    public init(data: Data, entryPoint: String = "main", device: Device) throws {
        if data.isEmpty {
            throw VulkanShaderError.noData
        }
        var info = VkShaderModuleCreateInfo()
        info.sType = .VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO
        info.codeSize = data.count

        let handlePointer: SmartPointer<VkShaderModule_T> = try data.withUnsafeBytes {
            info.pCode = $0.baseAddress!.assumingMemoryBound(to: CUnsignedInt.self)

            return try device.create(with: &info)
        }

        self.entryPoint = entryPoint

        try super.init(device: device, handlePointer: handlePointer)
    }

    internal func withStageInfoUnsafePointer<R>(for stage: VkShaderStageFlagBits, flags: VkPipelineShaderStageCreateFlagBits = [], body: (UnsafePointer<VkPipelineShaderStageCreateInfo>) throws -> (R)) throws -> R {
        return try entryPoint.withCString { entryPoint in
            var info = VkPipelineShaderStageCreateInfo()
        
            info.sType = .VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO
            info.pNext = nil
            info.flags = flags.rawValue
            info.stage = stage
            info.module = handle
            info.pName = entryPoint
            info.pSpecializationInfo = nil

            return try withUnsafePointer(to: &info) { info in
                return try body(info)
            }
        }
    }
}

public extension Shader {
    fileprivate static let defaultShaderEntryPointName = strdup("main")

    func createStageInfo(for stage: VkShaderStageFlagBits, flags: VkPipelineShaderStageCreateFlagBits = []) -> VkPipelineShaderStageCreateInfo {
        var result = VkPipelineShaderStageCreateInfo()
        
        result.sType = .VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO
        result.pNext = nil
        result.flags = flags.rawValue
        result.stage = stage
        result.module = handle
        result.pName = UnsafePointer(Shader.defaultShaderEntryPointName)
        result.pSpecializationInfo = nil

        return result
    }
}
