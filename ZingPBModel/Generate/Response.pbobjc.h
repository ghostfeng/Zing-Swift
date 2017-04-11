// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: response.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class ZTMAppConfiguration;
@class ZTMBlacklist;
@class ZTMChannel;
@class ZTMChannelCreateRule;
@class ZTMChannelDescription;
@class ZTMChannelProfile;
@class ZTMContacts;
@class ZTMDiscoveryBanner;
@class ZTMDiscoveryChannels;
@class ZTMEmoticon;
@class ZTMOssToken;
@class ZTMPayApplication;
@class ZTMPushMessage;
@class ZTMRegionDescription;
@class ZTMReply;
@class ZTMSense;
@class ZTMSharingMessage;
@class ZTMTalkMessage;
@class ZTMTogether;
@class ZTMUserConfig;
@class ZTMUserDescription;
@class ZTMUserProfile;
@class ZTMUserStatus;
@class ZTMVoteChoice;
@class ZTMVoteDetail;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ZTMResponseRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface ZTMResponseRoot : GPBRootObject
@end

#pragma mark - ZTMZingResponse

typedef GPB_ENUM(ZTMZingResponse_FieldNumber) {
  ZTMZingResponse_FieldNumber_Code = 1,
  ZTMZingResponse_FieldNumber_Next = 2,
  ZTMZingResponse_FieldNumber_Duration = 3,
  ZTMZingResponse_FieldNumber_Error = 4,
  ZTMZingResponse_FieldNumber_RequestAt = 5,
  ZTMZingResponse_FieldNumber_Config = 101,
  ZTMZingResponse_FieldNumber_OssToken = 102,
  ZTMZingResponse_FieldNumber_UserConfig = 103,
  ZTMZingResponse_FieldNumber_User = 104,
  ZTMZingResponse_FieldNumber_UsersArray = 105,
  ZTMZingResponse_FieldNumber_UserProfile = 106,
  ZTMZingResponse_FieldNumber_Blacklist = 107,
  ZTMZingResponse_FieldNumber_Channel = 108,
  ZTMZingResponse_FieldNumber_ChannelsArray = 109,
  ZTMZingResponse_FieldNumber_ChannelProfile = 110,
  ZTMZingResponse_FieldNumber_StayCount = 111,
  ZTMZingResponse_FieldNumber_Sense = 113,
  ZTMZingResponse_FieldNumber_SensesArray = 114,
  ZTMZingResponse_FieldNumber_Together = 115,
  ZTMZingResponse_FieldNumber_VoteDetailsArray = 116,
  ZTMZingResponse_FieldNumber_SamplesArray = 117,
  ZTMZingResponse_FieldNumber_Banners = 118,
  ZTMZingResponse_FieldNumber_DscvChannelsArray = 119,
  ZTMZingResponse_FieldNumber_RepliesArray = 120,
  ZTMZingResponse_FieldNumber_UserStatusArray = 121,
  ZTMZingResponse_FieldNumber_ChannelListArray = 122,
  ZTMZingResponse_FieldNumber_RegionsArray = 123,
  ZTMZingResponse_FieldNumber_Contacts = 126,
  ZTMZingResponse_FieldNumber_ContactsesArray = 127,
  ZTMZingResponse_FieldNumber_Emoticon = 128,
  ZTMZingResponse_FieldNumber_EmoticonsArray = 129,
  ZTMZingResponse_FieldNumber_TalkMessagesArray = 130,
  ZTMZingResponse_FieldNumber_PushMessagesArray = 131,
  ZTMZingResponse_FieldNumber_UnreadPushCount = 132,
  ZTMZingResponse_FieldNumber_Reply = 133,
  ZTMZingResponse_FieldNumber_PayApplication = 134,
  ZTMZingResponse_FieldNumber_ToppingChannelsArray = 135,
  ZTMZingResponse_FieldNumber_FollowedChannelsArray = 136,
  ZTMZingResponse_FieldNumber_RecentPushMessagesArray = 137,
  ZTMZingResponse_FieldNumber_ToppingContactsesArray = 138,
  ZTMZingResponse_FieldNumber_SharingMessage = 139,
  ZTMZingResponse_FieldNumber_FollowedToday = 140,
  ZTMZingResponse_FieldNumber_ShowModules = 141,
  ZTMZingResponse_FieldNumber_UnreadMessageCount = 142,
  ZTMZingResponse_FieldNumber_LastMessageAt = 143,
  ZTMZingResponse_FieldNumber_LastMessageTxt = 144,
  ZTMZingResponse_FieldNumber_DscvLastChannel = 145,
  ZTMZingResponse_FieldNumber_OrdinaryChannelRulesArray = 146,
  ZTMZingResponse_FieldNumber_HabitChannelRulesArray = 147,
  ZTMZingResponse_FieldNumber_AttitudeChannelRulesArray = 148,
};

@interface ZTMZingResponse : GPBMessage

/** 返回码 */
@property(nonatomic, readwrite) int32_t code;

/** 下页请求的链接 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *next;

/** 接口运行时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *duration;

/** 错误描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *error;

/** 客户端发起请求的时间 */
@property(nonatomic, readwrite) uint64_t requestAt;

/** app配置 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMAppConfiguration *config;
/** Test to see if @c config has been set. */
@property(nonatomic, readwrite) BOOL hasConfig;

/** OSS Token */
@property(nonatomic, readwrite, strong, null_resettable) ZTMOssToken *ossToken;
/** Test to see if @c ossToken has been set. */
@property(nonatomic, readwrite) BOOL hasOssToken;

/** 用户APP配置 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMUserConfig *userConfig;
/** Test to see if @c userConfig has been set. */
@property(nonatomic, readwrite) BOOL hasUserConfig;

/** 用户 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMUserDescription *user;
/** Test to see if @c user has been set. */
@property(nonatomic, readwrite) BOOL hasUser;

/** 用户列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserDescription*> *usersArray;
/** The number of items in @c usersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger usersArray_Count;

/** 用户详情 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMUserProfile *userProfile;
/** Test to see if @c userProfile has been set. */
@property(nonatomic, readwrite) BOOL hasUserProfile;

/** 黑名单 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMBlacklist *blacklist;
/** Test to see if @c blacklist has been set. */
@property(nonatomic, readwrite) BOOL hasBlacklist;

/** 频道详情 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMChannel *channel;
/** Test to see if @c channel has been set. */
@property(nonatomic, readwrite) BOOL hasChannel;

/** 频道列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannel*> *channelsArray;
/** The number of items in @c channelsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger channelsArray_Count;

/** 用户频道配置 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMChannelProfile *channelProfile;
/** Test to see if @c channelProfile has been set. */
@property(nonatomic, readwrite) BOOL hasChannelProfile;

/** 驻留用户数量 */
@property(nonatomic, readwrite) int32_t stayCount;

/** 感言详情 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMSense *sense;
/** Test to see if @c sense has been set. */
@property(nonatomic, readwrite) BOOL hasSense;

/** 感言列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMSense*> *sensesArray;
/** The number of items in @c sensesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger sensesArray_Count;

/** 交集 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMTogether *together;
/** Test to see if @c together has been set. */
@property(nonatomic, readwrite) BOOL hasTogether;

/** 投票详情 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMVoteDetail*> *voteDetailsArray;
/** The number of items in @c voteDetailsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger voteDetailsArray_Count;

/** 采样数据 */
@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Array *samplesArray;
/** The number of items in @c samplesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger samplesArray_Count;

/** banner与类别 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, ZTMDiscoveryBanner*> *banners;
/** The number of items in @c banners without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger banners_Count;

/** 发现频道列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMDiscoveryChannels*> *dscvChannelsArray;
/** The number of items in @c dscvChannelsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger dscvChannelsArray_Count;

/** 评论列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMReply*> *repliesArray;
/** The number of items in @c repliesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger repliesArray_Count;

/** 本地用户列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserStatus*> *userStatusArray;
/** The number of items in @c userStatusArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger userStatusArray_Count;

/** 本地频道列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannelDescription*> *channelListArray;
/** The number of items in @c channelListArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger channelListArray_Count;

/** 区域列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMRegionDescription*> *regionsArray;
/** The number of items in @c regionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger regionsArray_Count;

/** 联系人 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMContacts *contacts;
/** Test to see if @c contacts has been set. */
@property(nonatomic, readwrite) BOOL hasContacts;

/** 联系人列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMContacts*> *contactsesArray;
/** The number of items in @c contactsesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger contactsesArray_Count;

/** 表情包 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMEmoticon *emoticon;
/** Test to see if @c emoticon has been set. */
@property(nonatomic, readwrite) BOOL hasEmoticon;

/** 表情包列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMEmoticon*> *emoticonsArray;
/** The number of items in @c emoticonsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger emoticonsArray_Count;

/** 聊天消息列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMTalkMessage*> *talkMessagesArray;
/** The number of items in @c talkMessagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger talkMessagesArray_Count;

/** 推送列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMPushMessage*> *pushMessagesArray;
/** The number of items in @c pushMessagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger pushMessagesArray_Count;

/** 未读消息个数 */
@property(nonatomic, readwrite) int32_t unreadPushCount;

/** 评论 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMReply *reply;
/** Test to see if @c reply has been set. */
@property(nonatomic, readwrite) BOOL hasReply;

/** 支付申请 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMPayApplication *payApplication;
/** Test to see if @c payApplication has been set. */
@property(nonatomic, readwrite) BOOL hasPayApplication;

/** 至顶的频道列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannel*> *toppingChannelsArray;
/** The number of items in @c toppingChannelsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger toppingChannelsArray_Count;

/** 关注的频道列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannel*> *followedChannelsArray;
/** The number of items in @c followedChannelsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger followedChannelsArray_Count;

/** 近期的推送列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMPushMessage*> *recentPushMessagesArray;
/** The number of items in @c recentPushMessagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger recentPushMessagesArray_Count;

/** 至顶联系人列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMContacts*> *toppingContactsesArray;
/** The number of items in @c toppingContactsesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger toppingContactsesArray_Count;

/** 分享消息 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMSharingMessage *sharingMessage;
/** Test to see if @c sharingMessage has been set. */
@property(nonatomic, readwrite) BOOL hasSharingMessage;

/** 今日新增关注数 */
@property(nonatomic, readwrite) int32_t followedToday;

/** 频道详情页组件展示情况 */
@property(nonatomic, readwrite, strong, null_resettable) GPBStringInt32Dictionary *showModules;
/** The number of items in @c showModules without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger showModules_Count;

/** 未读消息数 */
@property(nonatomic, readwrite) int32_t unreadMessageCount;

/** 最后的消息时间 */
@property(nonatomic, readwrite) uint32_t lastMessageAt;

/** 最后的消息文本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *lastMessageTxt;

/** 最后的消息文本 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMDiscoveryChannels *dscvLastChannel;
/** Test to see if @c dscvLastChannel has been set. */
@property(nonatomic, readwrite) BOOL hasDscvLastChannel;

/** 频道创建规则 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannelCreateRule*> *ordinaryChannelRulesArray;
/** The number of items in @c ordinaryChannelRulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ordinaryChannelRulesArray_Count;

/** 习惯创建规则 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannelCreateRule*> *habitChannelRulesArray;
/** The number of items in @c habitChannelRulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger habitChannelRulesArray_Count;

/** 表态创建规则 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannelCreateRule*> *attitudeChannelRulesArray;
/** The number of items in @c attitudeChannelRulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger attitudeChannelRulesArray_Count;

@end

#pragma mark - ZTMOssToken

typedef GPB_ENUM(ZTMOssToken_FieldNumber) {
  ZTMOssToken_FieldNumber_AccessKeyId = 1,
  ZTMOssToken_FieldNumber_AccessKeySecret = 2,
  ZTMOssToken_FieldNumber_SecurityToken = 3,
  ZTMOssToken_FieldNumber_Expiration = 4,
};

@interface ZTMOssToken : GPBMessage

/** 表示Android/iOS应用初始化OSSClient获取的 AccessKeyId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *accessKeyId;

/** 表示Android/iOS应用初始化OSSClient获取AccessKeySecret */
@property(nonatomic, readwrite, copy, null_resettable) NSString *accessKeySecret;

/** 表示Android/iOS应用初始化的Token */
@property(nonatomic, readwrite, copy, null_resettable) NSString *securityToken;

/** 表示该Token失效的时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *expiration;

@end

#pragma mark - ZTMUserConfig

typedef GPB_ENUM(ZTMUserConfig_FieldNumber) {
  ZTMUserConfig_FieldNumber_IsOpenFriendship = 1,
};

@interface ZTMUserConfig : GPBMessage

/** 是否开启找朋友 */
@property(nonatomic, readwrite) int32_t isOpenFriendship;

@end

#pragma mark - ZTMBlacklist

typedef GPB_ENUM(ZTMBlacklist_FieldNumber) {
  ZTMBlacklist_FieldNumber_HateUserIdsArray = 1,
  ZTMBlacklist_FieldNumber_BeHatedUserIdsArray = 2,
  ZTMBlacklist_FieldNumber_IsMute = 3,
  ZTMBlacklist_FieldNumber_MuteEndAt = 4,
  ZTMBlacklist_FieldNumber_HateUsersArray = 5,
};

@interface ZTMBlacklist : GPBMessage

/** 加入黑名单的ID列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *hateUserIdsArray;
/** The number of items in @c hateUserIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger hateUserIdsArray_Count;

/** 被谁的ID加入了黑名单 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *beHatedUserIdsArray;
/** The number of items in @c beHatedUserIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger beHatedUserIdsArray_Count;

/** 是否被禁言 */
@property(nonatomic, readwrite) int32_t isMute;

/** 禁言的截止时间 */
@property(nonatomic, readwrite) uint32_t muteEndAt;

/** 加入黑名单的用户列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserDescription*> *hateUsersArray;
/** The number of items in @c hateUsersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger hateUsersArray_Count;

@end

#pragma mark - ZTMChannelProfile

typedef GPB_ENUM(ZTMChannelProfile_FieldNumber) {
  ZTMChannelProfile_FieldNumber_IsReceiveEvent = 1,
  ZTMChannelProfile_FieldNumber_IsOpenFriendship = 2,
  ZTMChannelProfile_FieldNumber_SexInFriendship = 3,
};

@interface ZTMChannelProfile : GPBMessage

/** 是否接收事件通知 */
@property(nonatomic, readwrite) int32_t isReceiveEvent;

/** 是否开启找朋友 */
@property(nonatomic, readwrite) int32_t isOpenFriendship;

/** 找朋友性别 */
@property(nonatomic, readwrite) int32_t sexInFriendship;

@end

#pragma mark - ZTMTogether

typedef GPB_ENUM(ZTMTogether_FieldNumber) {
  ZTMTogether_FieldNumber_Likes = 1,
  ZTMTogether_FieldNumber_LikeUsersArray = 2,
  ZTMTogether_FieldNumber_Views = 3,
  ZTMTogether_FieldNumber_ViewUsersArray = 4,
};

@interface ZTMTogether : GPBMessage

/** 同感的数量 */
@property(nonatomic, readwrite) int32_t likes;

/** 同感的用户 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserDescription*> *likeUsersArray;
/** The number of items in @c likeUsersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger likeUsersArray_Count;

/** 阅读的数量 */
@property(nonatomic, readwrite) int32_t views;

/** 阅读的用户 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserDescription*> *viewUsersArray;
/** The number of items in @c viewUsersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger viewUsersArray_Count;

@end

#pragma mark - ZTMVoteDetail

typedef GPB_ENUM(ZTMVoteDetail_FieldNumber) {
  ZTMVoteDetail_FieldNumber_Choice = 1,
  ZTMVoteDetail_FieldNumber_UsersArray = 2,
};

@interface ZTMVoteDetail : GPBMessage

/** 投票选项 */
@property(nonatomic, readwrite, strong, null_resettable) ZTMVoteChoice *choice;
/** Test to see if @c choice has been set. */
@property(nonatomic, readwrite) BOOL hasChoice;

/** 投票的用户 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMUserDescription*> *usersArray;
/** The number of items in @c usersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger usersArray_Count;

@end

#pragma mark - ZTMChannelCreateRule

typedef GPB_ENUM(ZTMChannelCreateRule_FieldNumber) {
  ZTMChannelCreateRule_FieldNumber_Rule = 1,
  ZTMChannelCreateRule_FieldNumber_IsPassed = 2,
};

@interface ZTMChannelCreateRule : GPBMessage

/** 规则 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *rule;

/** 是否通过 */
@property(nonatomic, readwrite) int32_t isPassed;

@end

#pragma mark - ZTMChannelOption

typedef GPB_ENUM(ZTMChannelOption_FieldNumber) {
  ZTMChannelOption_FieldNumber_Id_p = 1,
  ZTMChannelOption_FieldNumber_Category = 2,
  ZTMChannelOption_FieldNumber_Icon = 3,
  ZTMChannelOption_FieldNumber_Description_p = 4,
  ZTMChannelOption_FieldNumber_RefsArray = 6,
  ZTMChannelOption_FieldNumber_IsReceiveEvent = 7,
  ZTMChannelOption_FieldNumber_IsOpenFriendship = 8,
  ZTMChannelOption_FieldNumber_SexInFriendship = 9,
};

@interface ZTMChannelOption : GPBMessage

/** ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** 分类 */
@property(nonatomic, readwrite) int32_t category;

/** 频道ICON */
@property(nonatomic, readwrite, copy, null_resettable) NSString *icon;

/** 频道描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

/** 友情频道 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ZTMChannelDescription*> *refsArray;
/** The number of items in @c refsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger refsArray_Count;

/** 是否接收事件通知 */
@property(nonatomic, readwrite) int32_t isReceiveEvent;

/** 是否开启找朋友 */
@property(nonatomic, readwrite) int32_t isOpenFriendship;

/** 找朋友性别 */
@property(nonatomic, readwrite) int32_t sexInFriendship;

@end

#pragma mark - ZTMPayApplication

typedef GPB_ENUM(ZTMPayApplication_FieldNumber) {
  ZTMPayApplication_FieldNumber_PayId = 1,
  ZTMPayApplication_FieldNumber_AliURL = 2,
  ZTMPayApplication_FieldNumber_WxMap = 3,
};

@interface ZTMPayApplication : GPBMessage

/** 标明唯一支付行为的标识, 在不同支付中具体的字段名称不同 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *payId;

/** 阿里支付申请返回的请求URL, 该URL将用于调用支付API */
@property(nonatomic, readwrite, copy, null_resettable) NSString *aliURL;

/** 微信支付申请返回的请求MAP, 该MAP将对应调用支付API的参数列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *wxMap;
/** The number of items in @c wxMap without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger wxMap_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
