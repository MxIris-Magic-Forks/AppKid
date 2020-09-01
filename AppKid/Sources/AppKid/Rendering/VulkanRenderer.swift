//
//  VulkanRenderer.swift
//  AppKid
//
//  Created by Serhii Mumriak on 16.08.2020.
//

import Foundation
import Volcano
import TinyFoundation
import CVulkan

public enum VulkanRendererError: Error {
    case noDiscreteGPU
    case noPresentationQueueFound
}

public final class VulkanRenderer {
    internal let window: AppKid.Window

    internal fileprivate(set) var renderStack: VulkanRenderStack
    internal var device: Device { renderStack.device }
    internal fileprivate(set) var surface: Surface
    internal fileprivate(set) var presentationQueue: Queue
    internal fileprivate(set) var graphicsQueue: Queue
    internal fileprivate(set) var commandPool: CommandPool

    internal fileprivate(set) var imageAvailableSemaphore: Semaphore
    internal fileprivate(set) var renderFinishedSemaphore: Semaphore
    internal fileprivate(set) var fence: Fence

    var vertexShader: Shader
    var fragmentShader: Shader

    var oldSwapchain: Swapchain?
    var swapchain: Swapchain!
    var images: [Image]!
    var imageViews: [ImageView]!

    var pipelineLayout: SmartPointer<VkPipelineLayout_T>!
    var renderPass: SmartPointer<VkRenderPass_T>!
    var pipeline: SmartPointer<VkPipeline_T>!
    var framebuffers: [Framebuffer] = []
    var commandBuffers: [CommandBuffer] = []

    deinit {
        try? clearSwapchain()
        oldSwapchain = nil
    }

    public init(window: AppKid.Window, renderStack: VulkanRenderStack) throws {
        self.window = window

        self.renderStack = renderStack
        let device = renderStack.device

        let surface = try renderStack.createSurface(for: window)
        self.surface = surface

        guard let presentationQueue = try device.allQueues.first(where: { try surface.supportsPresenting(on: $0) }) else {
            throw VulkanRendererError.noPresentationQueueFound
        }

        self.presentationQueue = presentationQueue

        guard let graphicsQueue = device.allQueues.first(where: { $0.type == .graphics }) else {
            throw VulkanRendererError.noPresentationQueueFound
        }

        self.graphicsQueue = graphicsQueue

        commandPool = try CommandPool(device: device, queue: graphicsQueue)

        imageAvailableSemaphore = try Semaphore(device: device)
        renderFinishedSemaphore = try Semaphore(device: device)
        fence = try Fence(device: device)

        #if os(Linux)
            let bundle = Bundle.module
        #else
            let bundle = Bundle.main
        #endif

        vertexShader = try device.shader(named: "TriangleVertexShader", in: bundle)
        fragmentShader = try device.shader(named: "TriangleFragmentShader", in: bundle)

        renderPass = try createRenderPass()
        pipeline = try createGraphicsPipeline()
    }

    public func setupSwapchain() throws {
        try surface.refreshCapabilities()

        let windowSize = window.bounds.size
        let displayScale = window.nativeWindow.displayScale
        let desiredSize = VkExtent2D(width: UInt32(windowSize.width * displayScale), height: UInt32(windowSize.height * displayScale))
        let minSize = surface.capabilities.minImageExtent
        let maxSize = surface.capabilities.maxImageExtent

        let width = max(min(desiredSize.width, maxSize.width), minSize.width)
        let height = max(min(desiredSize.height, maxSize.height), minSize.height)
        let size = VkExtent2D(width: width, height: height)

        swapchain = try Swapchain(device: device, surface: surface, size: size, graphicsQueue: graphicsQueue, presentationQueue: presentationQueue, usage: .colorAttachment, compositeAlpha: .opaque, oldSwapchain: oldSwapchain)
        images = try swapchain.getImages()
        imageViews = try images.map { try ImageView(image: $0) }

        framebuffers = try createFramebuffers()
        commandBuffers = try createCommandBuffers()

        oldSwapchain = nil
    }

    public func clearSwapchain() throws {
        try device.waitForIdle()

        oldSwapchain = swapchain

        commandBuffers = []
        framebuffers = []
        imageViews = nil
        images = nil
        swapchain = nil
    }

    public func beginFrame() {
    }

    public func endFrame() {
    }

    public func render() throws {
        // trying to recreate swapchain only once per render request. if it fails for the second time - frame is skipped assuming there will be new render request following. maybe not the best thing to do because it's like a hidden logic. will re-evaluate
        var skipRecreation = false

        // stupid nvidia driver on X11. the resize event is processed by the driver much earlier that x11 sends resize evnents to application. this always results in invalid swapchain on first frame after x11 have already resized it's framebuffer, but have not sent the event to application. bad interprocess communication and lack of synchronization results in application-side hacks i.e. swapchain has to be recreated even before the actual window is resized and it's contents have been layed out

        while true {
            do {
                try drawFrame()
                break
            } catch VulkanError.badResult(let errorCode) {
                if errorCode == VK_ERROR_OUT_OF_DATE_KHR {
                    guard skipRecreation == false else {
                        break
                    }

                    try clearSwapchain()
                    try setupSwapchain()

                    skipRecreation = true
                } else {
                    throw VulkanError.badResult(errorCode)
                }
            }
        }

        // previous rendering code that would not skip swapchain recreation. keeping here till re-evaluating the solution
//        var happyFrame = false
//        repeat {
//            do {
//                try drawFrame()
//                happyFrame = true
//            } catch VulkanError.badResult(let errorCode) {
//                if errorCode == VK_ERROR_OUT_OF_DATE_KHR {
//                    try clearSwapchain()
//                    try setupSwapchain()
//                } else {
//                    throw VulkanError.badResult(errorCode)
//                }
//            }
//        } while happyFrame == false
    }

    public func updateRenderTargetSize() throws {
        do {
            try clearSwapchain()
            try setupSwapchain()
        } catch {
            debugPrint("Failed to recreate swapchain with error: \(error)")
        }
    }

    public func drawFrame() throws {
        try fence.reset()
        
        let imageIndex = try swapchain.getNextImageIndex(semaphore: imageAvailableSemaphore)

        let commandBuffer = commandBuffers[imageIndex]

        let submitCommandBuffers: [CommandBuffer] = [commandBuffer]
        let waitSemaphores: [Semaphore] = [imageAvailableSemaphore]
        let signalSemaphores: [Semaphore] = [renderFinishedSemaphore]
        let waitStages: [VkPipelineStageFlags] = [VkPipelineStageFlagBits.colorAttachmentOutput.rawValue]

        try graphicsQueue.submit(commandBuffers: submitCommandBuffers, waitSemaphores: waitSemaphores, signalSemaphores: signalSemaphores, waitStages: waitStages, fence: fence)
        try presentationQueue.present(swapchains: [swapchain], waitSemaphores: signalSemaphores, imageIndices: [CUnsignedInt(imageIndex)])

        try fence.wait()
    }

    func createRenderPass() throws -> SmartPointer<VkRenderPass_T> {
        var colorAttachment = VkAttachmentDescription()
        colorAttachment.format = surface.imageFormat
        colorAttachment.samples = .one
        colorAttachment.loadOp = .clear
        colorAttachment.storeOp = .store
        colorAttachment.stencilLoadOp = .clear
        colorAttachment.stencilStoreOp = .store
        colorAttachment.initialLayout = .undefined
        colorAttachment.finalLayout = .presentSource

        var colorAttachmentRef = VkAttachmentReference()
        colorAttachmentRef.attachment = 0
        colorAttachmentRef.layout = .colorAttachmentOptimal

        var subpass = VkSubpassDescription()
        subpass.pipelineBindPoint = .graphics
        subpass.colorAttachmentCount = 1
        withUnsafePointer(to: &colorAttachmentRef) {
            subpass.pColorAttachments = $0
        }

        var renderPassInfo = VkRenderPassCreateInfo()
        renderPassInfo.sType = .VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO
        renderPassInfo.attachmentCount = 1
        withUnsafePointer(to: &colorAttachment) {
            renderPassInfo.pAttachments = $0
        }
        renderPassInfo.subpassCount = 1
        withUnsafePointer(to: &subpass) {
            renderPassInfo.pSubpasses = $0
        }
        var dependency = VkSubpassDependency()
        dependency.srcSubpass = VK_SUBPASS_EXTERNAL
        dependency.dstSubpass = 0
        dependency.srcStageMask = VkPipelineStageFlagBits.colorAttachmentOutput.rawValue
        dependency.srcAccessMask = 0
        dependency.dstStageMask = VkPipelineStageFlagBits.colorAttachmentOutput.rawValue
        dependency.dstAccessMask = VkAccessFlagBits.colorAttachmentWrite.rawValue
        let dependencies: [VkSubpassDependency] = [dependency]
        dependencies.withUnsafeBufferPointer { dependenciesPointer in
            renderPassInfo.dependencyCount = CUnsignedInt(dependenciesPointer.count)
            renderPassInfo.pDependencies = dependenciesPointer.baseAddress!
        }

        return try device.create(with: &renderPassInfo)
    }

    func createGraphicsPipeline() throws -> SmartPointer<VkPipeline_T> {
        var pipelineLayoutInfo = VkPipelineLayoutCreateInfo()
        pipelineLayoutInfo.sType = .VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO
        pipelineLayoutInfo.setLayoutCount = 0
        pipelineLayoutInfo.pSetLayouts = nil
        pipelineLayoutInfo.pushConstantRangeCount = 0
        pipelineLayoutInfo.pPushConstantRanges = nil

        pipelineLayout = try device.create(with: &pipelineLayoutInfo)

        var viewportState = VkPipelineViewportStateCreateInfo()
        viewportState.sType = .VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO
        viewportState.pNext = nil
        viewportState.flags = VkPipelineViewportStateCreateFlags()
        viewportState.viewportCount = 1
        viewportState.scissorCount = 1
        
        var vertexInputInfo = VkPipelineVertexInputStateCreateInfo()
        vertexInputInfo.sType = .VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO
        vertexInputInfo.vertexBindingDescriptionCount = 0
        vertexInputInfo.pVertexBindingDescriptions = nil
        vertexInputInfo.vertexAttributeDescriptionCount = 0
        vertexInputInfo.pVertexAttributeDescriptions = nil

        var inputAssembly = VkPipelineInputAssemblyStateCreateInfo()
        inputAssembly.sType = .VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO
        inputAssembly.topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST
        inputAssembly.primitiveRestartEnable = false.vkBool

        var rasterizer = VkPipelineRasterizationStateCreateInfo()
        rasterizer.sType = .VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO
        rasterizer.depthClampEnable = false.vkBool
        rasterizer.rasterizerDiscardEnable = false.vkBool
        rasterizer.polygonMode = VK_POLYGON_MODE_FILL
        rasterizer.lineWidth = 1.0
        rasterizer.cullMode = VkCullModeFlagBits.back.rawValue
        rasterizer.frontFace = VK_FRONT_FACE_CLOCKWISE
        rasterizer.depthBiasEnable = false.vkBool
        rasterizer.depthBiasConstantFactor = 0.0
        rasterizer.depthBiasClamp = 0.0
        rasterizer.depthBiasSlopeFactor = 0.0

        var multisampling = VkPipelineMultisampleStateCreateInfo()
        multisampling.sType = .VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO
        multisampling.sampleShadingEnable = false.vkBool
        multisampling.rasterizationSamples = VkSampleCountFlagBits.VK_SAMPLE_COUNT_1_BIT
        multisampling.minSampleShading = 1.0
        multisampling.pSampleMask = nil
        multisampling.alphaToCoverageEnable = false.vkBool
        multisampling.alphaToOneEnable = false.vkBool

        var colorBlendAttachment = VkPipelineColorBlendAttachmentState()
        colorBlendAttachment.colorWriteMask = VkColorComponentFlagBits.rgba.rawValue
        colorBlendAttachment.blendEnable = false.vkBool
        colorBlendAttachment.srcColorBlendFactor = .one
        colorBlendAttachment.dstColorBlendFactor = .zero
        colorBlendAttachment.colorBlendOp = .add
        colorBlendAttachment.srcAlphaBlendFactor = .one
        colorBlendAttachment.dstAlphaBlendFactor = .zero
        colorBlendAttachment.alphaBlendOp = .add

        var colorBlending = VkPipelineColorBlendStateCreateInfo()
        colorBlending.sType = .VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO
        colorBlending.logicOpEnable = false.vkBool
        colorBlending.logicOp = VK_LOGIC_OP_COPY
        withUnsafePointer(to: &colorBlendAttachment) {
            colorBlending.attachmentCount = 1
            colorBlending.pAttachments = $0
        }
        colorBlending.blendConstants = (0.0, 0.0, 0.0, 0.0)

        let dynamicStates: [VkDynamicState] = [
            .viewport,
            .scissor,
            .lineWidth,
        ]
        
        var dynamicState: VkPipelineDynamicStateCreateInfo = dynamicStates.withUnsafeBufferPointer {
            return VkPipelineDynamicStateCreateInfo(sType: .VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO,
                                                    pNext: nil,
                                                    flags: VkPipelineDynamicStateCreateFlags(),
                                                    dynamicStateCount: CUnsignedInt($0.count),
                                                    pDynamicStates: $0.baseAddress!)
        }

        let fragmentShaderStageInfo = fragmentShader.createStageInfo(for: .fragment)
        let vertexShaderStageInfo = vertexShader.createStageInfo(for: .vertex)

        let shaderStages = [vertexShaderStageInfo, fragmentShaderStageInfo]

        var pipelineInfo = VkGraphicsPipelineCreateInfo()
        pipelineInfo.sType = .VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO
        pipelineInfo.stageCount = 2
        shaderStages.withUnsafeBufferPointer {
            pipelineInfo.pStages = $0.baseAddress!
        }

        withUnsafePointer(to: &vertexInputInfo) {
            pipelineInfo.pVertexInputState = $0
        }
        withUnsafePointer(to: &inputAssembly) {
            pipelineInfo.pInputAssemblyState = $0
        }
        withUnsafePointer(to: &viewportState) {
            pipelineInfo.pViewportState = $0
        }
        withUnsafePointer(to: &rasterizer) {
            pipelineInfo.pRasterizationState = $0
        }
        withUnsafePointer(to: &multisampling) {
            pipelineInfo.pMultisampleState = $0
        }
        withUnsafePointer(to: &colorBlending) {
            pipelineInfo.pColorBlendState = $0
        }
        withUnsafePointer(to: &dynamicState) {
            pipelineInfo.pDynamicState = $0
        }
        pipelineInfo.layout = pipelineLayout.pointer
        pipelineInfo.renderPass = renderPass.pointer
        pipelineInfo.subpass = 0

        pipelineInfo.basePipelineHandle = nil
        pipelineInfo.basePipelineIndex = -1

        pipelineInfo.pDepthStencilState = nil

        var pipelinePointer: UnsafeMutablePointer<VkPipeline_T>?
        try vulkanInvoke {
            vkCreateGraphicsPipelines(device.handle, nil, 1, &pipelineInfo, nil, &pipelinePointer)
        }
        let pipeline = SmartPointer(with: pipelinePointer!) { [unowned renderStack] in
            vkDestroyPipeline(renderStack.device.handle, $0, nil)
        }

        return pipeline
    }

    func createFramebuffers() throws -> [Framebuffer] {
        return try imageViews.map { imageView in
            return try Framebuffer(device: device, size: swapchain.size, renderPass: renderPass, attachments: [imageView])
        }
    }

    func createCommandBuffers() throws -> [CommandBuffer] {
        let renderArea = VkRect2D(offset: VkOffset2D(x: 0, y: 0), extent: swapchain.size)
        let clearColor = VkClearValue(color: VkClearColorValue(float32: (1.0, 1.0, 1.0, 1.0)))

        var viewport = VkViewport()
        viewport.x = 0.0
        viewport.y = 0.0
        viewport.width = Float(swapchain.size.width)
        viewport.height = Float(swapchain.size.height)
        viewport.minDepth = 0.0
        viewport.maxDepth = 1.0

        let viewports = [viewport]
        let scissors = [renderArea]

        let result: [CommandBuffer] = try framebuffers.map { framebuffer in
            let commandBuffer = try CommandBuffer(commandPool: commandPool)

            try commandBuffer.begin()

            try commandBuffer.beginRenderPass(renderPass, framebuffer: framebuffer, renderArea: renderArea, clearValues: [clearColor])
            try commandBuffer.bind(pipeline: pipeline)

            try commandBuffer.setViewports(viewports)
            try commandBuffer.setScissors(scissors)

            try commandBuffer.draw(vertexCount: 3, firstVertex: 0, instanceCount: 1, firstInstance: 0)

            try commandBuffer.endRenderPass()
            try commandBuffer.end()

            return commandBuffer
        }

        return result
    }

    func createVertexBuffer() throws -> SmartPointer<VkBuffer_T> {
        var info = VkBufferCreateInfo()
        info.sType = .VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO
        info.size = 0 // sizeof(vertices[0]) * vertices.size()
        info.usage = VkBufferUsageFlagBits.vertexBuffer.rawValue
        info.sharingMode = VK_SHARING_MODE_EXCLUSIVE

        return try device.create(with: &info)
    }
}
