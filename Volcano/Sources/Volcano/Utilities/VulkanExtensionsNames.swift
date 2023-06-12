//
//  VulkanExtensionsNames.swift
//  Volcano
//
//  Created by Serhii Mumriak on 20.07.2021.
//

import Foundation
import TinyFoundation

public enum InstanceExtension: String {
    case headlessSurfaceExt = "VK_EXT_headless_surface"
    case acquireXlibDisplayExt = "VK_EXT_acquire_xlib_display"
    case displaySurfaceCounterExt = "VK_EXT_display_surface_counter"
    case waylandSurfaceKhr = "VK_KHR_wayland_surface"
    case surfaceKhr = "VK_KHR_surface"
    case viSurfaceNn = "VK_NN_vi_surface"
    case directModeDisplayExt = "VK_EXT_direct_mode_display"
    case xlibSurfaceKhr = "VK_KHR_xlib_surface"
    case displayKhr = "VK_KHR_display"
    case streamDescriptorSurfaceGgp = "VK_GGP_stream_descriptor_surface"
    case androidSurfaceKhr = "VK_KHR_android_surface"
    case getPhysicalDeviceProperties2Khr = "VK_KHR_get_physical_device_properties2"
    case deviceGroupCreationKhr = "VK_KHR_device_group_creation"
    case swapchainColorspaceExt = "VK_EXT_swapchain_colorspace"
    case getDisplayProperties2Khr = "VK_KHR_get_display_properties2"
    case acquireDrmDisplayExt = "VK_EXT_acquire_drm_display"
    case surfaceProtectedCapabilitiesKhr = "VK_KHR_surface_protected_capabilities"
    case directfbSurfaceExt = "VK_EXT_directfb_surface"
    case externalSemaphoreCapabilitiesKhr = "VK_KHR_external_semaphore_capabilities"
    case screenSurfaceQnx = "VK_QNX_screen_surface"
    case surfacelessQueryGoogle = "VK_GOOGLE_surfaceless_query"
    case externalFenceCapabilitiesKhr = "VK_KHR_external_fence_capabilities"
    case imagepipeSurfaceFuchsia = "VK_FUCHSIA_imagepipe_surface"
    case win32SurfaceKhr = "VK_KHR_win32_surface"
    case validationFeaturesExt = "VK_EXT_validation_features"
    case externalMemoryCapabilitiesKhr = "VK_KHR_external_memory_capabilities"
    case getSurfaceCapabilities2Khr = "VK_KHR_get_surface_capabilities2"
    case debugUtilsExt = "VK_EXT_debug_utils"
    case metalSurfaceExt = "VK_EXT_metal_surface"
    case portabilityEnumerationKhr = "VK_KHR_portability_enumeration"
    case xcbSurfaceKhr = "VK_KHR_xcb_surface"
}

public enum DeviceExtension: String {
    case imagelessFramebufferKhr = "VK_KHR_imageless_framebuffer"
    case eightbitStorageKhr = "VK_KHR_8bit_storage"
    case accelerationStructureKhr = "VK_KHR_acceleration_structure"
    case negativeViewportHeightAmd = "VK_AMD_negative_viewport_height"
    case dedicatedAllocationImageAliasingNv = "VK_NV_dedicated_allocation_image_aliasing"
    case primitiveTopologyListRestartExt = "VK_EXT_primitive_topology_list_restart"
    case globalPriorityExt = "VK_EXT_global_priority"
    case shaderFloatControlsKhr = "VK_KHR_shader_float_controls"
    case externalMemoryFdKhr = "VK_KHR_external_memory_fd"
    case bindMemory2Khr = "VK_KHR_bind_memory2"
    case maintenance4Khr = "VK_KHR_maintenance4"
    case sharedPresentableImageKhr = "VK_KHR_shared_presentable_image"
    case incrementalPresentKhr = "VK_KHR_incremental_present"
    case copyCommands2Khr = "VK_KHR_copy_commands2"
    case gcnShaderAmd = "VK_AMD_gcn_shader"
    case clipSpaceWScalingNv = "VK_NV_clip_space_w_scaling"
    case provokingVertexExt = "VK_EXT_provoking_vertex"
    case rgba10x6FormatsExt = "VK_EXT_rgba10x6_formats"
    case relaxedBlockLayoutKhr = "VK_KHR_relaxed_block_layout"
    case borderColorSwizzleExt = "VK_EXT_border_color_swizzle"
    case imageViewHandleNvx = "VK_NVX_image_view_handle"
    case rayQueryKhr = "VK_KHR_ray_query"
    case vertexAttributeDivisorExt = "VK_EXT_vertex_attribute_divisor"
    case presentIdKhr = "VK_KHR_present_id"
    case linearColorAttachmentNv = "VK_NV_linear_color_attachment"
    case externalMemoryHostExt = "VK_EXT_external_memory_host"
    case robustness2Ext = "VK_EXT_robustness2"
    case extendedDynamicState2Ext = "VK_EXT_extended_dynamic_state2"
    case fourFourFourFourFormatsExt = "VK_EXT_4444_formats"
    case fragmentShadingRateKhr = "VK_KHR_fragment_shading_rate"
    case bufferCollectionFuchsia = "VK_FUCHSIA_buffer_collection"
    case shaderStencilExportExt = "VK_EXT_shader_stencil_export"
    case queueFamilyForeignExt = "VK_EXT_queue_family_foreign"
    case rotatedCopyCommandsQcom = "VK_QCOM_rotated_copy_commands"
    case pipelineExecutablePropertiesKhr = "VK_KHR_pipeline_executable_properties"
    case formatPvrtcImg = "VK_IMG_format_pvrtc"
    case ycbcr2Plane444FormatsExt = "VK_EXT_ycbcr_2plane_444_formats"
    case rasterizationOrderAmd = "VK_AMD_rasterization_order"
    case multiviewKhr = "VK_KHR_multiview"
    case invocationMaskHuawei = "VK_HUAWEI_invocation_mask"
    case scissorExclusiveNv = "VK_NV_scissor_exclusive"
    case transformFeedbackExt = "VK_EXT_transform_feedback"
    case shaderViewportIndexLayerExt = "VK_EXT_shader_viewport_index_layer"
    case representativeFragmentTestNv = "VK_NV_representative_fragment_test"
    case renderPassShaderResolveQcom = "VK_QCOM_render_pass_shader_resolve"
    case externalFenceWin32Khr = "VK_KHR_external_fence_win32"
    case displayControlExt = "VK_EXT_display_control"
    case externalFenceFdKhr = "VK_KHR_external_fence_fd"
    case memoryBudgetExt = "VK_EXT_memory_budget"
    case presentWaitKhr = "VK_KHR_present_wait"
    case extendedDynamicStateExt = "VK_EXT_extended_dynamic_state"
    case graphicsPipelineLibraryExt = "VK_EXT_graphics_pipeline_library"
    case subgroupSizeControlExt = "VK_EXT_subgroup_size_control"
    case subpassShadingHuawei = "VK_HUAWEI_subpass_shading"
    case samplerFilterMinmaxExt = "VK_EXT_sampler_filter_minmax"
    case shaderTrinaryMinmaxAmd = "VK_AMD_shader_trinary_minmax"
    case win32KeyedMutexNv = "VK_NV_win32_keyed_mutex"
    case shaderTerminateInvocationKhr = "VK_KHR_shader_terminate_invocation"
    case ycbcrImageArraysExt = "VK_EXT_ycbcr_image_arrays"
    case fullScreenExclusiveExt = "VK_EXT_full_screen_exclusive"
    case displaySwapchainKhr = "VK_KHR_display_swapchain"
    case createRenderpass2Khr = "VK_KHR_create_renderpass2"
    case shaderCoreProperties2Amd = "VK_AMD_shader_core_properties2"
    case cooperativeMatrixNv = "VK_NV_cooperative_matrix"
    case multiDrawExt = "VK_EXT_multi_draw"
    case externalSemaphoreWin32Khr = "VK_KHR_external_semaphore_win32"
    case shaderAtomicInt64Khr = "VK_KHR_shader_atomic_int64"
    case decorateStringGoogle = "VK_GOOGLE_decorate_string"
    case conservativeRasterizationExt = "VK_EXT_conservative_rasterization"
    case blendOperationAdvancedExt = "VK_EXT_blend_operation_advanced"
    case deviceDiagnosticCheckpointsNv = "VK_NV_device_diagnostic_checkpoints"
    case shaderAtomicFloat2Ext = "VK_EXT_shader_atomic_float2"
    case zeroInitializeWorkgroupMemoryKhr = "VK_KHR_zero_initialize_workgroup_memory"
    case filterCubicImg = "VK_IMG_filter_cubic"
    case externalSemaphoreKhr = "VK_KHR_external_semaphore"
    case videoDecodeQueueKhr = "VK_KHR_video_decode_queue"
    case renderPassStoreOpsQcom = "VK_QCOM_render_pass_store_ops"
    case swapchainKhr = "VK_KHR_swapchain"
    case videoDecodeH265Ext = "VK_EXT_video_decode_h265"
    case frameTokenGgp = "VK_GGP_frame_token"
    case shaderCorePropertiesAmd = "VK_AMD_shader_core_properties"
    case textureCompressionAstcHdrExt = "VK_EXT_texture_compression_astc_hdr"
    case maintenance2Khr = "VK_KHR_maintenance2"
    case shaderSmBuiltinsNv = "VK_NV_shader_sm_builtins"
    case geometryShaderPassthroughNv = "VK_NV_geometry_shader_passthrough"
    case mutableDescriptorTypeValve = "VK_VALVE_mutable_descriptor_type"
    case physicalDeviceDrmExt = "VK_EXT_physical_device_drm"
    case imageRobustnessExt = "VK_EXT_image_robustness"
    case deviceMemoryReportExt = "VK_EXT_device_memory_report"
    case rayTracingMotionBlurNv = "VK_NV_ray_tracing_motion_blur"
    case shaderNonSemanticInfoKhr = "VK_KHR_shader_non_semantic_info"
    case driverPropertiesKhr = "VK_KHR_driver_properties"
    case synchronization2Khr = "VK_KHR_synchronization2"
    case deviceGroupKhr = "VK_KHR_device_group"
    case shaderSubgroupUniformControlFlowKhr = "VK_KHR_shader_subgroup_uniform_control_flow"
    case binaryImportNvx = "VK_NVX_binary_import"
    case maintenance1Khr = "VK_KHR_maintenance1"
    case externalFenceKhr = "VK_KHR_external_fence"
    case storageBufferStorageClassKhr = "VK_KHR_storage_buffer_storage_class"
    case coverageReductionModeNv = "VK_NV_coverage_reduction_mode"
    case shaderIntegerDotProductKhr = "VK_KHR_shader_integer_dot_product"
    case pipelineCreationFeedbackExt = "VK_EXT_pipeline_creation_feedback"
    case multiviewPerViewAttributesNvx = "VK_NVX_multiview_per_view_attributes"
    case privateDataExt = "VK_EXT_private_data"
    case shaderFragmentMaskAmd = "VK_AMD_shader_fragment_mask"
    case hostQueryResetExt = "VK_EXT_host_query_reset"
    case fillRectangleNv = "VK_NV_fill_rectangle"
    case shaderAtomicFloatExt = "VK_EXT_shader_atomic_float"
    case lineRasterizationExt = "VK_EXT_line_rasterization"
    case globalPriorityQueryExt = "VK_EXT_global_priority_query"
    case swapchainMutableFormatKhr = "VK_KHR_swapchain_mutable_format"
    case descriptorSetHostMappingValve = "VK_VALVE_descriptor_set_host_mapping"
    case externalSemaphoreFdKhr = "VK_KHR_external_semaphore_fd"
    case texelBufferAlignmentExt = "VK_EXT_texel_buffer_alignment"
    case userTypeGoogle = "VK_GOOGLE_user_type"
    case fragmentCoverageToColorNv = "VK_NV_fragment_coverage_to_color"
    case bufferMarkerAmd = "VK_AMD_buffer_marker"
    case fragmentShaderInterlockExt = "VK_EXT_fragment_shader_interlock"
    case renderPassTransformQcom = "VK_QCOM_render_pass_transform"
    case performanceQueryIntel = "VK_INTEL_performance_query"
    case formatFeatureFlags2Khr = "VK_KHR_format_feature_flags2"
    case shaderBallotAmd = "VK_AMD_shader_ballot"
    case sixteenbitStorageKhr = "VK_KHR_16bit_storage"
    case imageDrmFormatModifierExt = "VK_EXT_image_drm_format_modifier"
    case videoEncodeH265Ext = "VK_EXT_video_encode_h265"
    case shaderClockKhr = "VK_KHR_shader_clock"
    case colorWriteEnableExt = "VK_EXT_color_write_enable"
    case shaderIntegerFunctions2Intel = "VK_INTEL_shader_integer_functions2"
    case shadingRateImageNv = "VK_NV_shading_rate_image"
    case externalMemoryRdmaNv = "VK_NV_external_memory_rdma"
    case externalMemoryWin32Khr = "VK_KHR_external_memory_win32"
    case variablePointersKhr = "VK_KHR_variable_pointers"
    case toolingInfoExt = "VK_EXT_tooling_info"
    case pipelineCreationCacheControlExt = "VK_EXT_pipeline_creation_cache_control"
    case cornerSampledImageNv = "VK_NV_corner_sampled_image"
    case deviceCoherentMemoryAmd = "VK_AMD_device_coherent_memory"
    case hlslFunctionality1Google = "VK_GOOGLE_hlsl_functionality1"
    case separateDepthStencilLayoutsKhr = "VK_KHR_separate_depth_stencil_layouts"
    case loadStoreOpNoneExt = "VK_EXT_load_store_op_none"
    case maintenance3Khr = "VK_KHR_maintenance3"
    case sampleLocationsExt = "VK_EXT_sample_locations"
    case shaderDrawParametersKhr = "VK_KHR_shader_draw_parameters"
    case performanceQueryKhr = "VK_KHR_performance_query"
    case meshShaderNv = "VK_NV_mesh_shader"
    case inheritedViewportScissorNv = "VK_NV_inherited_viewport_scissor"
    case shaderInfoAmd = "VK_AMD_shader_info"
    case pipelineLibraryKhr = "VK_KHR_pipeline_library"
    case pageableDeviceLocalMemoryExt = "VK_EXT_pageable_device_local_memory"
    case fragmentDensityMapOffsetQcom = "VK_QCOM_fragment_density_map_offset"
    case externalSemaphoreFuchsia = "VK_FUCHSIA_external_semaphore"
    case dynamicRenderingKhr = "VK_KHR_dynamic_rendering"
    case spirv14Khr = "VK_KHR_spirv_1_4"
    case vulkanMemoryModelKhr = "VK_KHR_vulkan_memory_model"
    case displayNativeHdrAmd = "VK_AMD_display_native_hdr"
    case viewportSwizzleNv = "VK_NV_viewport_swizzle"
    case shaderSubgroupExtendedTypesKhr = "VK_KHR_shader_subgroup_extended_types"
    case timelineSemaphoreKhr = "VK_KHR_timeline_semaphore"
    case computeShaderDerivativesNv = "VK_NV_compute_shader_derivatives"
    case framebufferMixedSamplesNv = "VK_NV_framebuffer_mixed_samples"
    case externalMemoryFuchsia = "VK_FUCHSIA_external_memory"
    case debugMarkerExt = "VK_EXT_debug_marker"
    case shaderDemoteToHelperInvocationExt = "VK_EXT_shader_demote_to_helper_invocation"
    case rasterizationOrderAttachmentAccessArm = "VK_ARM_rasterization_order_attachment_access"
    case workgroupMemoryExplicitLayoutKhr = "VK_KHR_workgroup_memory_explicit_layout"
    case shaderSubgroupPartitionedNv = "VK_NV_shader_subgroup_partitioned"
    case win32KeyedMutexKhr = "VK_KHR_win32_keyed_mutex"
    case discardRectanglesExt = "VK_EXT_discard_rectangles"
    case depthRangeUnrestrictedExt = "VK_EXT_depth_range_unrestricted"
    case videoQueueKhr = "VK_KHR_video_queue"
    case depthStencilResolveKhr = "VK_KHR_depth_stencil_resolve"
    case fragmentDensityMapExt = "VK_EXT_fragment_density_map"
    case videoDecodeH264Ext = "VK_EXT_video_decode_h264"
    case primitivesGeneratedQueryExt = "VK_EXT_primitives_generated_query"
    case videoEncodeH264Ext = "VK_EXT_video_encode_h264"
    case dedicatedAllocationKhr = "VK_KHR_dedicated_allocation"
    case indexTypeUint8Ext = "VK_EXT_index_type_uint8"
    case astcDecodeModeExt = "VK_EXT_astc_decode_mode"
    case deferredHostOperationsKhr = "VK_KHR_deferred_host_operations"
    case externalMemoryKhr = "VK_KHR_external_memory"
    case glslShaderNv = "VK_NV_glsl_shader"
    case drawIndirectCountAmd = "VK_AMD_draw_indirect_count"
    case descriptorUpdateTemplateKhr = "VK_KHR_descriptor_update_template"
    case scalarBlockLayoutExt = "VK_EXT_scalar_block_layout"
    case validationCacheExt = "VK_EXT_validation_cache"
    case portabilitySubsetKhr = "VK_KHR_portability_subset"
    case rayTracingNv = "VK_NV_ray_tracing"
    case pciBusInfoExt = "VK_EXT_pci_bus_info"
    case imageViewMinLodExt = "VK_EXT_image_view_min_lod"
    case fragmentShadingRateEnumsNv = "VK_NV_fragment_shading_rate_enums"
    case filterCubicExt = "VK_EXT_filter_cubic"
    case hdrMetadataExt = "VK_EXT_hdr_metadata"
    case externalMemoryAndroidHardwareBufferAndroid = "VK_ANDROID_external_memory_android_hardware_buffer"
    case fragmentShaderBarycentricNv = "VK_NV_fragment_shader_barycentric"
    case separateStencilUsageExt = "VK_EXT_separate_stencil_usage"
    case bufferDeviceAddressKhr = "VK_KHR_buffer_device_address"
    case memoryPriorityExt = "VK_EXT_memory_priority"
    case vertexInputDynamicStateExt = "VK_EXT_vertex_input_dynamic_state"
    case shaderFloat16Int8Khr = "VK_KHR_shader_float16_int8"
    case deviceDiagnosticsConfigNv = "VK_NV_device_diagnostics_config"
    case inlineUniformBlockExt = "VK_EXT_inline_uniform_block"
    case globalPriorityKhr = "VK_KHR_global_priority"
    case textureGatherBiasLodAmd = "VK_AMD_texture_gather_bias_lod"
    case samplerYcbcrConversionKhr = "VK_KHR_sampler_ycbcr_conversion"
    case rayTracingPipelineKhr = "VK_KHR_ray_tracing_pipeline"
    case videoEncodeQueueKhr = "VK_KHR_video_encode_queue"
    case getMemoryRequirements2Khr = "VK_KHR_get_memory_requirements2"
    case samplerMirrorClampToEdgeKhr = "VK_KHR_sampler_mirror_clamp_to_edge"
    case postDepthCoverageExt = "VK_EXT_post_depth_coverage"
    case drawIndirectCountKhr = "VK_KHR_draw_indirect_count"
    case depthClipControlExt = "VK_EXT_depth_clip_control"
    case externalMemoryDmaBufExt = "VK_EXT_external_memory_dma_buf"
    case shaderImageLoadStoreLodAmd = "VK_AMD_shader_image_load_store_lod"
    case fragmentDensityMap2Ext = "VK_EXT_fragment_density_map2"
    case shaderExplicitVertexParameterAmd = "VK_AMD_shader_explicit_vertex_parameter"
    case mixedAttachmentSamplesAmd = "VK_AMD_mixed_attachment_samples"
    case memoryOverallocationBehaviorAmd = "VK_AMD_memory_overallocation_behavior"
    case pipelineCompilerControlAmd = "VK_AMD_pipeline_compiler_control"
    case pushDescriptorKhr = "VK_KHR_push_descriptor"
    case viewportArray2Nv = "VK_NV_viewport_array2"
    case shaderImageAtomicInt64Ext = "VK_EXT_shader_image_atomic_int64"
    case acquireWinrtDisplayNv = "VK_NV_acquire_winrt_display"
    case image2DViewOf3DExt = "VK_EXT_image_2d_view_of_3d"
    case conditionalRenderingExt = "VK_EXT_conditional_rendering"
    case customBorderColorExt = "VK_EXT_custom_border_color"
    case descriptorIndexingExt = "VK_EXT_descriptor_indexing"
    case deviceGeneratedCommandsNv = "VK_NV_device_generated_commands"
    case uniformBufferStandardLayoutKhr = "VK_KHR_uniform_buffer_standard_layout"
    case calibratedTimestampsExt = "VK_EXT_calibrated_timestamps"
    case shaderImageFootprintNv = "VK_NV_shader_image_footprint"
    case depthClipEnableExt = "VK_EXT_depth_clip_enable"
    case displayTimingGoogle = "VK_GOOGLE_display_timing"
    case sampleMaskOverrideCoverageNv = "VK_NV_sample_mask_override_coverage"
    case imageFormatListKhr = "VK_KHR_image_format_list"
}
