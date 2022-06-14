const _baseUrlDev = "http://120.55.182.117:8842";
// const _baseUrlMaster = "http://106.15.9.79:8842";
const _baseUrlMaster = "http://116.62.224.170:8402";
const bool _dev = false;
const baseUrl = _dev ? _baseUrlDev : _baseUrlMaster;

const String loginUrl = "/v1/app/login";

///获取设备列表
const String getDevicesUrl = "/v1/app/equipment/list/page";

///获取设备位置列表
const String getDevicesLocationUrl = "/v1/app/position/list";

///保存设备位置
const String postDeviceLocationUrl = "/v1/app/position/associate";

///更改设备名称
const String putDeviceNameUrl = "/v1/app/equipment/update";

///获取监护人信息
const String getGuardianInfoUrl = "/v1/app/equipment/monitor";

///加载血型、基础疾病、过敏原分类数据信息
const String getDictInfoUrl = "/v1/app/dict/list";

///修改监护对象信息
const String putGuardianInfoUrl = "/v1/app/equipment/monitor/update";

///清除监护对象
const String deleteGuardianInfoUrl = "/v1/app/equipment/monitor/update";

///设备解除绑定的位置
const String removeBindingUrl = "/v1/app/position/remove/binding";

///获取报警信息列表
const String getAlarmMessageUrl = "/v1/app/alarm/list/page";

///获取区域筛选信息
const String getAreaSelectionUrl = "/v1/app/position/tree";

///获取报警信息列表
const String saveAreaSelectionUrl = "/v1/app/alarm/save/query";

///处理报警
const String processAlarmUrl = "/v1/app/alarm/deal";

//***********************语音通话相关*********************
///获取RTC token
const String getRtcTokenUrl = "/v1/app/rtc/token";

///验证通道
const String getCheckChannelUrl = "/v1/rtc/check/can/join";

///传递通话通知
const String postTransferCallNotificationUrl = "/v1/app/rtc/notice/join";

///上传通话记录
const String postCallHistoryUrl = "/v1/app/equipment/save/call/records";

///获取通话记录
const String getCallHistoryUrl = "/v1/equipment/call/records";

///获取电话通知记录
const String getPhoneHistoryUrl = "/v1/app/equipment/callout/records";
//*******************************************************
