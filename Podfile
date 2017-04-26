workspace 'Zing-Swift.xcworkspace'

platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git' 
source 'https://github.com/aliyun/aliyun-specs.git'

target 'Zing-Swift' do
    project 'Zing-Swift.xcodeproj'
    
    # 网络组件
    pod 'Alamofire', '>= 4.4.0'
    # 序列化 protobuf
    pod 'Protobuf', '>= 3.2.1'
    # 序列化 JSON
    pod 'SwiftyJSON', '>= 3.1.4'
    # 阿里OSS SDK
    pod 'AliyunOSSiOS', '>= 2.6.0'
    # 阿里Push SDK
    pod 'AlicloudPush', '>= 1.9.1'
end

target 'ZingCommon' do
    project 'ZingCommon/ZingCommon.xcodeproj'
    
    # 序列化 protobuf
    pod 'Protobuf', '>= 3.2.0'
    # 阿里OSS SDK
    pod 'AliyunOSSiOS', '>= 2.6.0'
    # LeanCloud SDK
    pod 'AVOSCloudIM', '>= 4.0.0'
end

target 'ZingPBModel' do
    project 'ZingPBModel/ZingPBModel.xcodeproj'
    
    # 序列化 protobuf
    pod 'Protobuf', '>= 3.2.1'
end
