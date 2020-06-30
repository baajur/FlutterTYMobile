// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static m0(action, platform) => "是否确认${action} ${platform} 平台？";

  static m1(value) => "余额不足: ${value}";

  static m2(value) => "总计:￥${value}";

  static m3(no) => "${no}限用借记卡与支付宝余额支付！\n";

  static m4(value) => "单笔最高限额: ${value}";

  static m5(no) => "${no}【重要提醒】勿保留银行帐户，请您在每次充值前重新获取最新的收款帐户，若存款至停用的收款帐户，公司无法查收恕不负责！\n";

  static m6(no) => "${no}如遇到存款扫码失败等故障，请尝试刷新重试，并联系客服使用其他替换信道\n";

  static m7(no) => "${no}支付银行与帐户姓名等资料，请联系";

  static m8(no) => "${no}若单笔交易金额尾号不是0（如：1000元整），会造成无法成功存款\n";

  static m9(no) => "${no}发卡行限额解决方法：需要用户自己致电发卡行客服要求增加网上交易额度\n";

  static m10(no) => "${no}单笔最高限额\n";

  static m11(no) => "${no}超出在线支付单日额度限制或单笔大额充值，可使用其它充值方式\n";

  static m12(no) => "${no}温馨提醒：使用快捷支付需支付小数两位，系统会自动带入（若您提交小数两位为00则无法成功）\n";

  static m13(no) => "${no}想要使用银联扫码支付，前提是需要持有卡号为62开头银联卡，信用卡借记卡都可以。\n";

  static m14(no) => "${no}至中国银联开通快捷功能，让您的支付更加便利\n";

  static m15(value) => "訂單已成立，訂單編號：${value}";

  static m16(num, num2) => "输入范围:${num}~${num2}";

  static m17(num, num2, num3) => "输入范围:${num}~${num2}(金额为${num3}的倍数)";

  static m18(value) => "已累积签到${value}天";

  static m19(name) => "${name}您好！";

  static m20(msg) => "${msg}错误";

  static m21(wallet) => "${wallet}钱包綁定網址錯誤";

  static m22(msg, msg2) => "错误:${msg}(${msg2})";

  static m23(msg) => "请输入${msg}";

  static m24(url) => "無法開啟網頁連結：${url}";

  static m25(msg) => "错误:${msg}";

  static m26(num) => "金额最小值为${num}";

  static m27(num) => "密码至少为${num}个字";

  static m28(name) => "${name}，请重新登入";

  static m29(msg) => "已取消${msg}";

  static m30(msg) => "${msg}失败";

  static m31(msg) => "${msg}成功";

  static m32(name) => "欢迎，${name}";

  static m33(value) => "地址：${value}";

  static m34(from, to, total) => "顯示第 ${from} 至 ${to} 項結果，共 ${total} 項";

  static m35(value) => "姓名：${value}";

  static m36(value) => "电话：${value}";

  static m37(value) => "邮编：${value}";

  static m38(value) => "各平台${value}";

  static m39(value) => "${value}积分";

  static m40(value) => "￥ ${value}";

  static m41(separator) => "获取${separator}验证码";

  static m42(msg) => "查无${msg}纪录";

  static m43(num) => "累积幸运轮抽奖次数:${num}次数";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "agentAdButtonGenerate" : MessageLookupByLibrary.simpleMessage("产生广告"),
    "agentAdTabAvailable" : MessageLookupByLibrary.simpleMessage("可使用广告"),
    "agentAdTabGenerated" : MessageLookupByLibrary.simpleMessage("已生成广告"),
    "agentButtonTextCopy" : MessageLookupByLibrary.simpleMessage("复制"),
    "agentButtonTextLink" : MessageLookupByLibrary.simpleMessage("连结"),
    "agentButtonTextShare" : MessageLookupByLibrary.simpleMessage("分享"),
    "agentChartHeaderAccount" : MessageLookupByLibrary.simpleMessage("帐号"),
    "agentChartHeaderBet" : MessageLookupByLibrary.simpleMessage("注额"),
    "agentChartHeaderPayout" : MessageLookupByLibrary.simpleMessage("派彩"),
    "agentChartHeaderTotalBet" : MessageLookupByLibrary.simpleMessage("总注額"),
    "agentChartHeaderTotalPayout" : MessageLookupByLibrary.simpleMessage("总派彩"),
    "agentChartHeaderTotalValid" : MessageLookupByLibrary.simpleMessage("总有效注额"),
    "agentChartHeaderTotalWager" : MessageLookupByLibrary.simpleMessage("总投注量"),
    "agentChartHeaderValid" : MessageLookupByLibrary.simpleMessage("有效注額"),
    "agentChartHeaderWager" : MessageLookupByLibrary.simpleMessage("投注量"),
    "agentChartTableSpinner" : MessageLookupByLibrary.simpleMessage("表单"),
    "agentCommissionHeaderAdmin" : MessageLookupByLibrary.simpleMessage("行政费用"),
    "agentCommissionHeaderGroup" : MessageLookupByLibrary.simpleMessage("团体佣金"),
    "agentCommissionHeaderLowLine" : MessageLookupByLibrary.simpleMessage("下线佣金"),
    "agentCommissionHeaderMonth" : MessageLookupByLibrary.simpleMessage("月份"),
    "agentCommissionHeaderPlatform" : MessageLookupByLibrary.simpleMessage("平台费"),
    "agentCommissionHeaderReceive" : MessageLookupByLibrary.simpleMessage("实发佣金"),
    "agentInfoFieldAgents" : MessageLookupByLibrary.simpleMessage("下层帐号"),
    "agentInfoFieldButtonGetCode" : MessageLookupByLibrary.simpleMessage("取得代理码"),
    "agentInfoFieldCode" : MessageLookupByLibrary.simpleMessage("推荐码"),
    "agentInfoFieldLink" : MessageLookupByLibrary.simpleMessage("代理连结"),
    "agentLedgerFieldTitleAccount" : MessageLookupByLibrary.simpleMessage("请输入帐号"),
    "agentLedgerHeaderAccount" : MessageLookupByLibrary.simpleMessage("帐号"),
    "agentLedgerHeaderDeposit" : MessageLookupByLibrary.simpleMessage("存款"),
    "agentLedgerHeaderPromo" : MessageLookupByLibrary.simpleMessage("优惠"),
    "agentLedgerHeaderRefund" : MessageLookupByLibrary.simpleMessage("退水"),
    "agentLedgerHeaderWithdraw" : MessageLookupByLibrary.simpleMessage("提款"),
    "agentTabTitleAds" : MessageLookupByLibrary.simpleMessage("广告"),
    "agentTabTitleChart" : MessageLookupByLibrary.simpleMessage("报表"),
    "agentTabTitleCommission" : MessageLookupByLibrary.simpleMessage("佣金"),
    "agentTabTitleInfo" : MessageLookupByLibrary.simpleMessage("资讯"),
    "agentTabTitleLedger" : MessageLookupByLibrary.simpleMessage("存/提"),
    "agentTextChartCategory" : MessageLookupByLibrary.simpleMessage("类别"),
    "agentTextChartCheckFull" : MessageLookupByLibrary.simpleMessage("显示完整资料"),
    "agentTextChartDate" : MessageLookupByLibrary.simpleMessage("时间："),
    "agentTextChartMonth" : MessageLookupByLibrary.simpleMessage("本月"),
    "agentTextChartMonthPrev" : MessageLookupByLibrary.simpleMessage("上月"),
    "agentTextChartOption" : MessageLookupByLibrary.simpleMessage("选择"),
    "agentTextChartPlatform" : MessageLookupByLibrary.simpleMessage("平台"),
    "agentTextChartQuery" : MessageLookupByLibrary.simpleMessage("查询"),
    "alertButtonCancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "alertButtonClose" : MessageLookupByLibrary.simpleMessage("关闭"),
    "alertButtonNo" : MessageLookupByLibrary.simpleMessage("否"),
    "alertButtonOk" : MessageLookupByLibrary.simpleMessage("确认"),
    "alertButtonYes" : MessageLookupByLibrary.simpleMessage("是"),
    "alertTitleError" : MessageLookupByLibrary.simpleMessage("错误"),
    "alertTitleHint" : MessageLookupByLibrary.simpleMessage("提示"),
    "alertTitleWarning" : MessageLookupByLibrary.simpleMessage("警告"),
    "balanceHintText1" : MessageLookupByLibrary.simpleMessage("1.转账前请退出游戏或游戏投注界面。"),
    "balanceHintText2" : MessageLookupByLibrary.simpleMessage("2.不参与活动时，户内转账金额不能少于1元，户内转账不收取任何手续费。"),
    "balanceHintText3" : MessageLookupByLibrary.simpleMessage("3.如遇网速较慢时，请耐心等侯片刻，不要多次重复提交。"),
    "balanceHintText4" : MessageLookupByLibrary.simpleMessage("4.转帐成功後若平台金额未改变，请手动刷新平台或联系客服"),
    "balanceHintTextTitle" : MessageLookupByLibrary.simpleMessage("温馨提示："),
    "balanceStatusMaintenance" : MessageLookupByLibrary.simpleMessage("维护中"),
    "balanceTransferAlertMsg" : m0,
    "balanceTransferAlertTitle" : MessageLookupByLibrary.simpleMessage("确认信息"),
    "balanceTransferAmountError" : m1,
    "balanceTransferInText" : MessageLookupByLibrary.simpleMessage("转入"),
    "balanceTransferOutText" : MessageLookupByLibrary.simpleMessage("转出"),
    "bankcardViewTitleBankArea" : MessageLookupByLibrary.simpleMessage("地区"),
    "bankcardViewTitleBankName" : MessageLookupByLibrary.simpleMessage("银行名称"),
    "bankcardViewTitleBankPoint" : MessageLookupByLibrary.simpleMessage("银行支行"),
    "bankcardViewTitleBankProvince" : MessageLookupByLibrary.simpleMessage("开户网点"),
    "bankcardViewTitleCardNumber" : MessageLookupByLibrary.simpleMessage("账(卡)号"),
    "bankcardViewTitleOwner" : MessageLookupByLibrary.simpleMessage("帐户姓名"),
    "bankcardViewTitleSend" : MessageLookupByLibrary.simpleMessage("送出"),
    "betsFieldDateError" : MessageLookupByLibrary.simpleMessage("时间范围错误"),
    "betsFieldTitleEndTime" : MessageLookupByLibrary.simpleMessage("結束时间"),
    "betsFieldTitleStartTime" : MessageLookupByLibrary.simpleMessage("開始时间"),
    "betsHeaderAmount" : MessageLookupByLibrary.simpleMessage("投注额"),
    "betsHeaderBonus" : MessageLookupByLibrary.simpleMessage("派彩金额"),
    "betsHeaderDate" : MessageLookupByLibrary.simpleMessage("时间"),
    "betsHeaderGame" : MessageLookupByLibrary.simpleMessage("游戏名称"),
    "betsHeaderId" : MessageLookupByLibrary.simpleMessage("注单号"),
    "betsHeaderPlatform" : MessageLookupByLibrary.simpleMessage("平台"),
    "betsSpinnerOptionAllPlatform" : MessageLookupByLibrary.simpleMessage("全部平台"),
    "betsSpinnerTitlePlatform" : MessageLookupByLibrary.simpleMessage("游戏平台"),
    "betsSpinnerTitleTime" : MessageLookupByLibrary.simpleMessage("投注时间"),
    "betsTextTotal" : m2,
    "btnBack" : MessageLookupByLibrary.simpleMessage("返回"),
    "btnBind" : MessageLookupByLibrary.simpleMessage("点我绑定"),
    "btnConfirm" : MessageLookupByLibrary.simpleMessage("确定"),
    "btnConfirmSend" : MessageLookupByLibrary.simpleMessage("确定送出"),
    "btnDownload" : MessageLookupByLibrary.simpleMessage("点我下载"),
    "btnFastLogin" : MessageLookupByLibrary.simpleMessage("記住帳密"),
    "btnLogin" : MessageLookupByLibrary.simpleMessage("登入"),
    "btnMenu" : MessageLookupByLibrary.simpleMessage("选单"),
    "btnQueryNow" : MessageLookupByLibrary.simpleMessage("立即查询"),
    "btnRefresh" : MessageLookupByLibrary.simpleMessage("刷新"),
    "btnRegister" : MessageLookupByLibrary.simpleMessage("注册"),
    "btnResetPassword" : MessageLookupByLibrary.simpleMessage("忘记密码"),
    "btnSend" : MessageLookupByLibrary.simpleMessage("送出"),
    "btnShow" : MessageLookupByLibrary.simpleMessage("显示"),
    "btnSignUp" : MessageLookupByLibrary.simpleMessage("立即签到"),
    "btnSubmit" : MessageLookupByLibrary.simpleMessage("提交"),
    "centerDialogCpwLeftHint" : MessageLookupByLibrary.simpleMessage("※ 点击将退出APP(不支持iPad)"),
    "centerDialogCpwLeftTitle" : MessageLookupByLibrary.simpleMessage("还没有购宝APP？"),
    "centerDialogCpwRightHint" : MessageLookupByLibrary.simpleMessage("(绑定完成后请等侯页面更新)"),
    "centerDialogCpwRightHint2" : MessageLookupByLibrary.simpleMessage("或"),
    "centerDialogCpwRightLinkError" : MessageLookupByLibrary.simpleMessage("无法取得绑定网址，请联系客服"),
    "centerDialogCpwRightTitle" : MessageLookupByLibrary.simpleMessage("已有购宝APP"),
    "centerHintNoName" : MessageLookupByLibrary.simpleMessage("请至绑订银行卡做相关设定"),
    "centerLuckyButtonBind" : MessageLookupByLibrary.simpleMessage("确认绑定"),
    "centerLuckyButtonGenerate" : MessageLookupByLibrary.simpleMessage("自动生成"),
    "centerLuckyHint" : MessageLookupByLibrary.simpleMessage("绑定六合幸运码，就能参加六合彩运码对对碰哦，精彩大礼送给你!!!"),
    "centerLuckyNumberError" : MessageLookupByLibrary.simpleMessage("数字范围:01~49"),
    "centerLuckyTitle" : MessageLookupByLibrary.simpleMessage("请在以下7个空格中，填入01~49的数字"),
    "centerTextButtonBind" : MessageLookupByLibrary.simpleMessage("绑订"),
    "centerTextButtonChangePwd" : MessageLookupByLibrary.simpleMessage("更改密码"),
    "centerTextButtonEdit" : MessageLookupByLibrary.simpleMessage("修改"),
    "centerTextButtonSend" : MessageLookupByLibrary.simpleMessage("发送"),
    "centerTextTitleAccount" : MessageLookupByLibrary.simpleMessage("用户名："),
    "centerTextTitleBirth" : MessageLookupByLibrary.simpleMessage("生日："),
    "centerTextTitleCgp" : MessageLookupByLibrary.simpleMessage("Cgp钱包："),
    "centerTextTitleCpw" : MessageLookupByLibrary.simpleMessage("购宝钱包："),
    "centerTextTitleDateError" : MessageLookupByLibrary.simpleMessage("请输入正确日期(格式为：西元年–月–日)"),
    "centerTextTitleDateHint" : MessageLookupByLibrary.simpleMessage("格式为：0000–00–00"),
    "centerTextTitleMail" : MessageLookupByLibrary.simpleMessage("邮箱："),
    "centerTextTitleMailError" : MessageLookupByLibrary.simpleMessage("请输入正确邮箱"),
    "centerTextTitleName" : MessageLookupByLibrary.simpleMessage("姓名："),
    "centerTextTitlePhone" : MessageLookupByLibrary.simpleMessage("手机号："),
    "centerTextTitleWechat" : MessageLookupByLibrary.simpleMessage("微信号："),
    "centerViewTitleData" : MessageLookupByLibrary.simpleMessage("个人资料"),
    "centerViewTitleLotto" : MessageLookupByLibrary.simpleMessage("六合幸运码"),
    "centerViewTitleVip" : MessageLookupByLibrary.simpleMessage("Vip阶层"),
    "dealsHeaderAmount" : MessageLookupByLibrary.simpleMessage("金额"),
    "dealsHeaderDate" : MessageLookupByLibrary.simpleMessage("日期"),
    "dealsHeaderDetail" : MessageLookupByLibrary.simpleMessage("明细"),
    "dealsHeaderSerial" : MessageLookupByLibrary.simpleMessage("单号"),
    "dealsHeaderStatus" : MessageLookupByLibrary.simpleMessage("订单状态"),
    "dealsHeaderType" : MessageLookupByLibrary.simpleMessage("项目"),
    "dealsViewSpinnerStatus0" : MessageLookupByLibrary.simpleMessage("全部"),
    "dealsViewSpinnerStatus1" : MessageLookupByLibrary.simpleMessage("成功"),
    "dealsViewSpinnerStatus2" : MessageLookupByLibrary.simpleMessage("失败"),
    "dealsViewSpinnerStatus3" : MessageLookupByLibrary.simpleMessage("处理中"),
    "dealsViewSpinnerStatus4" : MessageLookupByLibrary.simpleMessage("新交易"),
    "dealsViewSpinnerType0" : MessageLookupByLibrary.simpleMessage("全部"),
    "dealsViewSpinnerType1" : MessageLookupByLibrary.simpleMessage("充值"),
    "dealsViewSpinnerType2" : MessageLookupByLibrary.simpleMessage("提现"),
    "dealsViewSpinnerType3" : MessageLookupByLibrary.simpleMessage("红利"),
    "depositHintTextAccount" : MessageLookupByLibrary.simpleMessage("充值帐号资讯请联络客服"),
    "depositHintTextAli" : m3,
    "depositHintTextAmount" : m4,
    "depositHintTextClearInfo" : m5,
    "depositHintTextFailure" : m6,
    "depositHintTextInfo" : m7,
    "depositHintTextLastNum" : m8,
    "depositHintTextLimit" : m9,
    "depositHintTextMax" : m10,
    "depositHintTextMaxExceed" : m11,
    "depositHintTextQuickpay" : m12,
    "depositHintTextService" : MessageLookupByLibrary.simpleMessage("在线客服"),
    "depositHintTextTitle" : MessageLookupByLibrary.simpleMessage("注意事项"),
    "depositHintTextUnion" : m13,
    "depositHintTextUnionA" : MessageLookupByLibrary.simpleMessage("A、手机下载中国银行App或银联钱包App；\n"),
    "depositHintTextUnionB" : MessageLookupByLibrary.simpleMessage("B、登入中国银行手机App，通过右上角“+”中的付款功能或移动支付模块中的付款功能；\n"),
    "depositHintTextUnionC" : MessageLookupByLibrary.simpleMessage("C、进入向商家付款的二维码页面，对准机具扫码即可。\n"),
    "depositHintTextUnionShortcut" : m14,
    "depositMessageFailed" : MessageLookupByLibrary.simpleMessage("充值失败，请稍候重试或联系客服"),
    "depositMessageSuccessLocal" : m15,
    "depositNewbieAli0" : MessageLookupByLibrary.simpleMessage("支付宝转银行卡教学"),
    "depositNewbieAli1" : MessageLookupByLibrary.simpleMessage("首先打开手机支付宝并登入，在主板面点击【转账】功能。"),
    "depositNewbieAli2" : MessageLookupByLibrary.simpleMessage("在转账页面下方选择【转到银行卡】按钮"),
    "depositNewbieAli3" : MessageLookupByLibrary.simpleMessage("同样需填写【收款人卡号】==【所属银行】==【收款人姓名】==【付款金额】"),
    "depositNewbieAli4" : MessageLookupByLibrary.simpleMessage("提交后再输入支付宝【支付密码】即可。"),
    "depositNewbieAli5" : MessageLookupByLibrary.simpleMessage("转账成功后，可在支付宝账单详情中查看，改转账明细、和到帐时间。"),
    "depositNewbieButtonCgp1" : MessageLookupByLibrary.simpleMessage("下载购宝支付APP"),
    "depositNewbieButtonCgp2" : MessageLookupByLibrary.simpleMessage("下载购宝教学手册"),
    "depositNewbieCgp0" : MessageLookupByLibrary.simpleMessage("下载链结"),
    "depositNewbieJd0" : MessageLookupByLibrary.simpleMessage("京东教学"),
    "depositNewbieJd1" : MessageLookupByLibrary.simpleMessage("1、下载京东app"),
    "depositNewbieJd2" : MessageLookupByLibrary.simpleMessage("2、进入页面后点击我的"),
    "depositNewbieJd3" : MessageLookupByLibrary.simpleMessage("3、注册或者登入京东帐户信用卡和储蓄卡皆可添加"),
    "depositNewbieJd4" : MessageLookupByLibrary.simpleMessage("4、点击首页的扫码即可支付与绑定银行卡"),
    "depositNewbieQuick0" : MessageLookupByLibrary.simpleMessage("借记卡教学"),
    "depositNewbieUnion0" : MessageLookupByLibrary.simpleMessage("银联支付教学"),
    "depositNewbieUnion1" : MessageLookupByLibrary.simpleMessage("1、银联钱包App下载"),
    "depositNewbieUnion2" : MessageLookupByLibrary.simpleMessage("2、注册并登入。"),
    "depositNewbieUnion3" : MessageLookupByLibrary.simpleMessage("3、绑定银行卡，选择卡管家→卡列表→添加银行卡→添加一张新卡。"),
    "depositNewbieUnion4" : MessageLookupByLibrary.simpleMessage("信用卡和储蓄卡皆可添加"),
    "depositNewbieWechat0" : MessageLookupByLibrary.simpleMessage("扫码教学"),
    "depositNewbieWechat1" : MessageLookupByLibrary.simpleMessage("1、先用一个手机拍下付款二维码。"),
    "depositNewbieWechat2" : MessageLookupByLibrary.simpleMessage("2、然后用另一个手机微信扫码付款。"),
    "depositPaymentButtonTitleTutorial" : MessageLookupByLibrary.simpleMessage("点我看教学"),
    "depositPaymentEditTitleAmount" : MessageLookupByLibrary.simpleMessage("存款金额"),
    "depositPaymentEditTitleAmountHintRange" : m16,
    "depositPaymentEditTitleAmountHintRangeStep" : m17,
    "depositPaymentEditTitleName" : MessageLookupByLibrary.simpleMessage("打款人姓名"),
    "depositPaymentEditTitleNameHint" : MessageLookupByLibrary.simpleMessage("请填写您的打款人姓名"),
    "depositPaymentMethodLocal1" : MessageLookupByLibrary.simpleMessage("转帐充值"),
    "depositPaymentMethodLocal2" : MessageLookupByLibrary.simpleMessage("ATM充值"),
    "depositPaymentNoPromo" : MessageLookupByLibrary.simpleMessage("放弃申请优惠"),
    "depositPaymentSpinnerTitleBank" : MessageLookupByLibrary.simpleMessage("支付银行"),
    "depositPaymentSpinnerTitleMethod" : MessageLookupByLibrary.simpleMessage("充值方式"),
    "depositPaymentSpinnerTitlePromo" : MessageLookupByLibrary.simpleMessage("选择优惠"),
    "depositPaymentTitleAli" : MessageLookupByLibrary.simpleMessage("支付宝支付"),
    "depositPaymentTitleAtm" : MessageLookupByLibrary.simpleMessage("网银转帐"),
    "depositPaymentTitleBank" : MessageLookupByLibrary.simpleMessage("银行充值"),
    "depositPaymentTitleCgp" : MessageLookupByLibrary.simpleMessage("购宝钱包"),
    "depositPaymentTitleJd" : MessageLookupByLibrary.simpleMessage("京东支付"),
    "depositPaymentTitleOnline" : MessageLookupByLibrary.simpleMessage("在线支付"),
    "depositPaymentTitleQuick" : MessageLookupByLibrary.simpleMessage("快捷支付(推荐)"),
    "depositPaymentTitleTutorial" : MessageLookupByLibrary.simpleMessage("使用教学"),
    "depositPaymentTitleUnion" : MessageLookupByLibrary.simpleMessage("银联支付"),
    "depositPaymentTitleWechat" : MessageLookupByLibrary.simpleMessage("微信支付"),
    "eventButtonSignUpAlready" : MessageLookupByLibrary.simpleMessage("已签到"),
    "eventButtonSignUpFailed" : MessageLookupByLibrary.simpleMessage("签到失败!!"),
    "eventButtonSignUpSuccess" : MessageLookupByLibrary.simpleMessage("签到成功!!"),
    "eventButtonSignUpTv" : m18,
    "eventSignUpHint1" : MessageLookupByLibrary.simpleMessage("已累积签到"),
    "eventSignUpHint2" : MessageLookupByLibrary.simpleMessage("天"),
    "exitAppHint" : MessageLookupByLibrary.simpleMessage("再按一次关闭APP"),
    "flowHeaderTextAmount" : MessageLookupByLibrary.simpleMessage("金额"),
    "flowHeaderTextCode" : MessageLookupByLibrary.simpleMessage("交易码"),
    "flowHeaderTextCurrent" : MessageLookupByLibrary.simpleMessage("当前注额"),
    "flowHeaderTextMultiple" : MessageLookupByLibrary.simpleMessage("倍数"),
    "flowHeaderTextNeed" : MessageLookupByLibrary.simpleMessage("注额须求剩馀"),
    "flowHeaderTextPromo" : MessageLookupByLibrary.simpleMessage("现金优惠"),
    "flowHeaderTextRequire" : MessageLookupByLibrary.simpleMessage("注额须求"),
    "flowHeaderTextTime" : MessageLookupByLibrary.simpleMessage("时间区间"),
    "flowHeaderTextTotal" : MessageLookupByLibrary.simpleMessage("合计"),
    "flowHeaderTextType" : MessageLookupByLibrary.simpleMessage("类型"),
    "hintAccount" : MessageLookupByLibrary.simpleMessage("您的会员帐号"),
    "hintAccountPassword" : MessageLookupByLibrary.simpleMessage("您的密码"),
    "hintActionLogin" : MessageLookupByLibrary.simpleMessage("请先登入"),
    "hintActionSelect" : MessageLookupByLibrary.simpleMessage("请选择"),
    "hintConfirmed" : MessageLookupByLibrary.simpleMessage("再次输入密码"),
    "hintEmail" : MessageLookupByLibrary.simpleMessage("输入信箱"),
    "hintName" : MessageLookupByLibrary.simpleMessage("输入用户名"),
    "hintPassword" : MessageLookupByLibrary.simpleMessage("输入密码"),
    "hintTitleLogin" : MessageLookupByLibrary.simpleMessage("请先登入您的会员帐号"),
    "homeHintMemberCreditLeft" : MessageLookupByLibrary.simpleMessage("余额"),
    "homeHintWelcome" : MessageLookupByLibrary.simpleMessage("您好！"),
    "homeHintWelcomeLogin" : MessageLookupByLibrary.simpleMessage("您好！ 请登入会员"),
    "homeHintWelcomeMember" : m19,
    "memberGridTitleAccount" : MessageLookupByLibrary.simpleMessage("帐户中心"),
    "memberGridTitleAgent" : MessageLookupByLibrary.simpleMessage("代理"),
    "memberGridTitleBalance" : MessageLookupByLibrary.simpleMessage("平台馀额"),
    "memberGridTitleBet" : MessageLookupByLibrary.simpleMessage("投注记录"),
    "memberGridTitleCard" : MessageLookupByLibrary.simpleMessage("银行卡"),
    "memberGridTitleDeal" : MessageLookupByLibrary.simpleMessage("交易记录"),
    "memberGridTitleDeposit" : MessageLookupByLibrary.simpleMessage("充值"),
    "memberGridTitleFlow" : MessageLookupByLibrary.simpleMessage("流水记录"),
    "memberGridTitleLogout" : MessageLookupByLibrary.simpleMessage("登出"),
    "memberGridTitleMessage" : MessageLookupByLibrary.simpleMessage("站内信"),
    "memberGridTitleTransaction" : MessageLookupByLibrary.simpleMessage("转帐记录"),
    "memberGridTitleTransfer" : MessageLookupByLibrary.simpleMessage("转帐"),
    "memberGridTitleWallet" : MessageLookupByLibrary.simpleMessage("免转钱包"),
    "memberGridTitleWithdraw" : MessageLookupByLibrary.simpleMessage("提现"),
    "messageActionFailed" : MessageLookupByLibrary.simpleMessage("操作无效"),
    "messageActionFillForm" : MessageLookupByLibrary.simpleMessage("请填写完整"),
    "messageClearDataRestart" : MessageLookupByLibrary.simpleMessage("语言已变更，清除数据中，稍后将重启"),
    "messageCopy" : MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
    "messageCopyError" : MessageLookupByLibrary.simpleMessage("复制失败"),
    "messageError" : m20,
    "messageErrorAutoLogin" : MessageLookupByLibrary.simpleMessage("数据错误，请手动登入"),
    "messageErrorBindBankcard" : MessageLookupByLibrary.simpleMessage("请先绑定银行卡！"),
    "messageErrorBindCgp" : MessageLookupByLibrary.simpleMessage("请先绑定Cgp钱包"),
    "messageErrorBindCpw" : MessageLookupByLibrary.simpleMessage("请先绑定购宝钱包"),
    "messageErrorBindUrl" : m21,
    "messageErrorCachedFile" : MessageLookupByLibrary.simpleMessage("缓存数据错误，请稍候再重试或联系客服"),
    "messageErrorCause" : m22,
    "messageErrorEvent" : MessageLookupByLibrary.simpleMessage("无法取得签到活动数据，请稍候再重试或联系客服"),
    "messageErrorFieldError" : m23,
    "messageErrorHasCardData" : MessageLookupByLibrary.simpleMessage("已绑定过银行卡"),
    "messageErrorInternal" : MessageLookupByLibrary.simpleMessage("内部错误，请稍候再重试或联系客服"),
    "messageErrorLink" : m24,
    "messageErrorLoadingGame" : MessageLookupByLibrary.simpleMessage("游戏加载发生错误，请稍候再重试"),
    "messageErrorLoadingPay" : MessageLookupByLibrary.simpleMessage("网页加载错误，请稍候再重试"),
    "messageErrorNoNetwork" : MessageLookupByLibrary.simpleMessage("请检查网络状态"),
    "messageErrorNoServerConnection" : MessageLookupByLibrary.simpleMessage("无法连接至伺服器!!"),
    "messageErrorNoStoragePermission" : MessageLookupByLibrary.simpleMessage("请开启\"保存\"权限"),
    "messageErrorNotLogin" : MessageLookupByLibrary.simpleMessage("请先登入"),
    "messageErrorServerData" : MessageLookupByLibrary.simpleMessage("伺服器資料错误，请稍候再重试或联系客服"),
    "messageErrorStatus" : m25,
    "messageErrorTimeoutError" : MessageLookupByLibrary.simpleMessage("网络逾時，请稍候再重试"),
    "messageErrorToken" : MessageLookupByLibrary.simpleMessage("用户验证失败，请重新登入或联系客服"),
    "messageFailed" : MessageLookupByLibrary.simpleMessage("更改失败，请稍候再重试"),
    "messageInvalidAccount" : MessageLookupByLibrary.simpleMessage("帐号为6~12个字"),
    "messageInvalidCardBankPoint" : MessageLookupByLibrary.simpleMessage("名称需大于3个字"),
    "messageInvalidCardNumber" : MessageLookupByLibrary.simpleMessage("卡号为16~19个字"),
    "messageInvalidCardOwner" : MessageLookupByLibrary.simpleMessage("持卡人名称错误"),
    "messageInvalidConfirmPassword" : MessageLookupByLibrary.simpleMessage("密码不符合"),
    "messageInvalidDepositAmount" : MessageLookupByLibrary.simpleMessage("金额输入错误"),
    "messageInvalidDepositAmountMin" : m26,
    "messageInvalidDepositName" : MessageLookupByLibrary.simpleMessage("帐号名称错误"),
    "messageInvalidEmail" : MessageLookupByLibrary.simpleMessage("信箱格式错误"),
    "messageInvalidFormat" : MessageLookupByLibrary.simpleMessage("格式错误"),
    "messageInvalidName" : MessageLookupByLibrary.simpleMessage("名称格式错误"),
    "messageInvalidPassword" : MessageLookupByLibrary.simpleMessage("密码为6~20个字"),
    "messageInvalidPasswordArg" : m27,
    "messageInvalidPasswordNew" : MessageLookupByLibrary.simpleMessage("密码为8~20个字"),
    "messageInvalidPhone" : MessageLookupByLibrary.simpleMessage("电话格式错误"),
    "messageInvalidVerify" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "messageInvalidWechat" : MessageLookupByLibrary.simpleMessage("微信号格式错误"),
    "messageInvalidWithdrawPassword" : MessageLookupByLibrary.simpleMessage("密码为4~8个字"),
    "messageLoginFailed" : MessageLookupByLibrary.simpleMessage("登入失败"),
    "messageLogout" : m28,
    "messageNoEvent" : MessageLookupByLibrary.simpleMessage("当前没有活动"),
    "messagePartFailed" : MessageLookupByLibrary.simpleMessage("部分平台转帐失败"),
    "messageRegisterFailed" : MessageLookupByLibrary.simpleMessage("注册失败"),
    "messageSuccess" : MessageLookupByLibrary.simpleMessage("成功"),
    "messageTaskCanceled" : m29,
    "messageTaskFailed" : m30,
    "messageTaskSuccess" : m31,
    "messageWait" : MessageLookupByLibrary.simpleMessage("处理请求中，请稍候…"),
    "messageWaitComplete" : MessageLookupByLibrary.simpleMessage("处理请求中，请勿退出"),
    "messageWarnLoadingGame" : MessageLookupByLibrary.simpleMessage("加载游戏中，请稍候…"),
    "messageWarnNetworkLocation" : MessageLookupByLibrary.simpleMessage("您所在的网络区域无法使用此服务"),
    "messageWarnNoHistoryData" : MessageLookupByLibrary.simpleMessage("查无资料"),
    "messageWarnNoPromoData" : MessageLookupByLibrary.simpleMessage("查无优惠"),
    "messageWarnNoPromoInfo" : MessageLookupByLibrary.simpleMessage("查无优惠信息"),
    "messageWarnUsingCellular" : MessageLookupByLibrary.simpleMessage("您正在使用移动网络"),
    "messageWelcome" : MessageLookupByLibrary.simpleMessage("欢迎光临，请先登入/注册"),
    "messageWelcomeUser" : m32,
    "noticeTabGeneral" : MessageLookupByLibrary.simpleMessage("一般讯息"),
    "noticeTabMaintenance" : MessageLookupByLibrary.simpleMessage("维护通知"),
    "pageTitleDeposit" : MessageLookupByLibrary.simpleMessage("充值"),
    "pageTitleDownload" : MessageLookupByLibrary.simpleMessage("APP下载区"),
    "pageTitleHome" : MessageLookupByLibrary.simpleMessage("首页"),
    "pageTitleLogin" : MessageLookupByLibrary.simpleMessage("登入"),
    "pageTitleLogin2" : MessageLookupByLibrary.simpleMessage("会员登入"),
    "pageTitleMember" : MessageLookupByLibrary.simpleMessage("我的"),
    "pageTitleMemberAgent" : MessageLookupByLibrary.simpleMessage("代理"),
    "pageTitleMemberAgentAbout" : MessageLookupByLibrary.simpleMessage("代理说明"),
    "pageTitleMemberBalance" : MessageLookupByLibrary.simpleMessage("平台馀额"),
    "pageTitleMemberBets" : MessageLookupByLibrary.simpleMessage("投注记录"),
    "pageTitleMemberCard" : MessageLookupByLibrary.simpleMessage("银行卡"),
    "pageTitleMemberCenter" : MessageLookupByLibrary.simpleMessage("帐户中心"),
    "pageTitleMemberDeals" : MessageLookupByLibrary.simpleMessage("交易记录"),
    "pageTitleMemberFlow" : MessageLookupByLibrary.simpleMessage("流水记录"),
    "pageTitleMemberMessage" : MessageLookupByLibrary.simpleMessage("站内信"),
    "pageTitleMemberPassword" : MessageLookupByLibrary.simpleMessage("更改密码"),
    "pageTitleMemberTransaction" : MessageLookupByLibrary.simpleMessage("转帐记录"),
    "pageTitleMemberTransfer" : MessageLookupByLibrary.simpleMessage("转帐"),
    "pageTitleMemberWallet" : MessageLookupByLibrary.simpleMessage("免转钱包"),
    "pageTitleMemberWithdraw" : MessageLookupByLibrary.simpleMessage("提现"),
    "pageTitleMore" : MessageLookupByLibrary.simpleMessage("更多"),
    "pageTitleNotice" : MessageLookupByLibrary.simpleMessage("公告"),
    "pageTitlePromo" : MessageLookupByLibrary.simpleMessage("优惠"),
    "pageTitleRank" : MessageLookupByLibrary.simpleMessage("VIP阶层"),
    "pageTitleRegister" : MessageLookupByLibrary.simpleMessage("注册"),
    "pageTitleRegister2" : MessageLookupByLibrary.simpleMessage("免费注册"),
    "pageTitleRoller" : MessageLookupByLibrary.simpleMessage("幸运轮盘"),
    "pageTitleRouter" : MessageLookupByLibrary.simpleMessage("线路导航"),
    "pageTitleService" : MessageLookupByLibrary.simpleMessage("客服"),
    "pageTitleSign" : MessageLookupByLibrary.simpleMessage("签到"),
    "pageTitleStore" : MessageLookupByLibrary.simpleMessage("商店"),
    "pageTitleTask" : MessageLookupByLibrary.simpleMessage("活跃任务"),
    "pageTitleTutorial" : MessageLookupByLibrary.simpleMessage("新手教学"),
    "promoCategoryAll" : MessageLookupByLibrary.simpleMessage("All"),
    "promoCategoryOther" : MessageLookupByLibrary.simpleMessage("其它"),
    "promoDetailApply" : MessageLookupByLibrary.simpleMessage("申请方式"),
    "promoDetailContent" : MessageLookupByLibrary.simpleMessage("活动内容"),
    "promoDetailPlatform" : MessageLookupByLibrary.simpleMessage("适用平台"),
    "promoDetailRules" : MessageLookupByLibrary.simpleMessage("活动细则"),
    "promoDetailText" : MessageLookupByLibrary.simpleMessage(">>活动细则"),
    "registerButtonTitleRefresh" : MessageLookupByLibrary.simpleMessage("点图刷新"),
    "registerButtonTitleRegister" : MessageLookupByLibrary.simpleMessage("注册"),
    "registerFieldTitleAccount" : MessageLookupByLibrary.simpleMessage("帐号:"),
    "registerFieldTitleConfirm" : MessageLookupByLibrary.simpleMessage("确认密码:"),
    "registerFieldTitlePassword" : MessageLookupByLibrary.simpleMessage("密码:"),
    "registerFieldTitlePhone" : MessageLookupByLibrary.simpleMessage("手机号:"),
    "registerFieldTitleRecommend" : MessageLookupByLibrary.simpleMessage("推荐码:"),
    "registerHintAutoLogin" : MessageLookupByLibrary.simpleMessage("登入中，请稍候..."),
    "sideBtnBackHome" : MessageLookupByLibrary.simpleMessage("回首页"),
    "sideBtnRotate" : MessageLookupByLibrary.simpleMessage("旋转屏幕"),
    "sideMenuThemeSwitch" : MessageLookupByLibrary.simpleMessage("更换皮肤："),
    "sideMenuThemeSwitchDark" : MessageLookupByLibrary.simpleMessage("深"),
    "sideMenuThemeSwitchLight" : MessageLookupByLibrary.simpleMessage("淺"),
    "spinnerDateAll" : MessageLookupByLibrary.simpleMessage("全部时间"),
    "spinnerDateCustom" : MessageLookupByLibrary.simpleMessage("自订时间"),
    "spinnerDateMonth" : MessageLookupByLibrary.simpleMessage("一个月内"),
    "spinnerDateToday" : MessageLookupByLibrary.simpleMessage("今天"),
    "spinnerDateYesterday" : MessageLookupByLibrary.simpleMessage("昨天"),
    "storeExchangeResultError" : MessageLookupByLibrary.simpleMessage("兑换失败，请稍候再重试或联系客服"),
    "storeExchangeResultWindowHint" : MessageLookupByLibrary.simpleMessage("恭喜会员"),
    "storeExchangeResultWindowHintItem1" : MessageLookupByLibrary.simpleMessage("兑换"),
    "storeExchangeResultWindowHintItem2" : MessageLookupByLibrary.simpleMessage("一个"),
    "storeExchangeResultWindowTitleSuccess" : MessageLookupByLibrary.simpleMessage("会员兑换成功"),
    "storeProductWindowHint1" : MessageLookupByLibrary.simpleMessage("数量有限，换完为止"),
    "storeProductWindowHint2" : MessageLookupByLibrary.simpleMessage("每支使用"),
    "storeProductWindowHint3" : MessageLookupByLibrary.simpleMessage("积分兑换"),
    "storeProductWindowTextRemain" : MessageLookupByLibrary.simpleMessage("剩余数量"),
    "storeProductWindowTitle" : MessageLookupByLibrary.simpleMessage("会员兑换"),
    "storeRecordButtonTitle" : MessageLookupByLibrary.simpleMessage("搜索"),
    "storeRecordFieldHint" : MessageLookupByLibrary.simpleMessage("请输入商品名称"),
    "storeRecordSpinnerTitle1" : MessageLookupByLibrary.simpleMessage("显示"),
    "storeRecordSpinnerTitle2" : MessageLookupByLibrary.simpleMessage("项"),
    "storeRecordTableDetailAddress" : m33,
    "storeRecordTableDetailItem" : m34,
    "storeRecordTableDetailName" : m35,
    "storeRecordTableDetailPhone" : m36,
    "storeRecordTableDetailPostCode" : m37,
    "storeRecordTableStatusPending" : MessageLookupByLibrary.simpleMessage("待出货"),
    "storeRecordTableTitleDate" : MessageLookupByLibrary.simpleMessage("日期"),
    "storeRecordTableTitleNo" : MessageLookupByLibrary.simpleMessage("订单号"),
    "storeRecordTableTitlePoint" : MessageLookupByLibrary.simpleMessage("积分"),
    "storeRecordTableTitleProduct" : MessageLookupByLibrary.simpleMessage("商品"),
    "storeRecordTableTitleState" : MessageLookupByLibrary.simpleMessage("状态"),
    "storeRequestWindowFieldTitleAddress" : MessageLookupByLibrary.simpleMessage("地址"),
    "storeRequestWindowFieldTitleArea" : MessageLookupByLibrary.simpleMessage("地区"),
    "storeRequestWindowFieldTitleName" : MessageLookupByLibrary.simpleMessage("姓名"),
    "storeRequestWindowFieldTitlePhone" : MessageLookupByLibrary.simpleMessage("电话"),
    "storeRequestWindowFieldTitlePostno" : MessageLookupByLibrary.simpleMessage("邮编"),
    "storeRequestWindowHint" : MessageLookupByLibrary.simpleMessage("收件人资讯"),
    "storeRequestWindowPoints" : MessageLookupByLibrary.simpleMessage("积分兑换："),
    "storeRequestWindowTextPoint" : MessageLookupByLibrary.simpleMessage("累计积分："),
    "storeRequestWindowTitle" : MessageLookupByLibrary.simpleMessage("联络资讯"),
    "storeRuleTableHeader" : MessageLookupByLibrary.simpleMessage("每100元有效投注额即可获得积分表"),
    "storeRuleTableTitle" : m38,
    "storeTextItemButton" : MessageLookupByLibrary.simpleMessage("立即兑换"),
    "storeTextItemButtonDisabled" : MessageLookupByLibrary.simpleMessage("積分不足"),
    "storeTextItemHint" : MessageLookupByLibrary.simpleMessage("数量有限换完为止"),
    "storeTextItemPoint" : m39,
    "storeTextTitlePoint" : MessageLookupByLibrary.simpleMessage("会员积分："),
    "storeTextTitleProduct" : MessageLookupByLibrary.simpleMessage("兑换商品"),
    "storeTextTitleRecord" : MessageLookupByLibrary.simpleMessage("积分记录"),
    "storeTextTitleRule" : MessageLookupByLibrary.simpleMessage("兑换规则"),
    "title" : MessageLookupByLibrary.simpleMessage("添运国际V1"),
    "toolBarMemberCredit" : m40,
    "transactionHeaderAmount" : MessageLookupByLibrary.simpleMessage("金额"),
    "transactionHeaderDate" : MessageLookupByLibrary.simpleMessage("日期"),
    "transactionHeaderDesc" : MessageLookupByLibrary.simpleMessage("说明"),
    "transactionHeaderSerial" : MessageLookupByLibrary.simpleMessage("序号"),
    "transactionHeaderType" : MessageLookupByLibrary.simpleMessage("类别"),
    "transactionViewSpinnerTitle" : MessageLookupByLibrary.simpleMessage("转帐时间"),
    "transferDataError" : MessageLookupByLibrary.simpleMessage("数据错误，请重新选择"),
    "transferPlatformError" : MessageLookupByLibrary.simpleMessage("所选平台当前无法转帐"),
    "transferResultAlertTitle" : MessageLookupByLibrary.simpleMessage("转帐失败"),
    "transferViewButtonConfirm" : MessageLookupByLibrary.simpleMessage("确认转帐"),
    "transferViewSiteHint" : MessageLookupByLibrary.simpleMessage("请选择平台"),
    "transferViewTextOptionAll" : MessageLookupByLibrary.simpleMessage("全部额度"),
    "transferViewTitleAmount" : MessageLookupByLibrary.simpleMessage("金额"),
    "transferViewTitleIn" : MessageLookupByLibrary.simpleMessage("转入"),
    "transferViewTitleOption" : MessageLookupByLibrary.simpleMessage("选择金额"),
    "transferViewTitleOut" : MessageLookupByLibrary.simpleMessage("转出"),
    "userPwdButtonTitle" : MessageLookupByLibrary.simpleMessage("修改密码"),
    "userPwdFieldHintConfirm" : MessageLookupByLibrary.simpleMessage("再次输入新密码"),
    "userPwdFieldHintNew" : MessageLookupByLibrary.simpleMessage("输入新密码"),
    "userPwdFieldHintOld" : MessageLookupByLibrary.simpleMessage("输入旧密码"),
    "userPwdFieldTitleConfirm" : MessageLookupByLibrary.simpleMessage("密码确认："),
    "userPwdFieldTitleNew" : MessageLookupByLibrary.simpleMessage("新密码："),
    "userPwdFieldTitleOld" : MessageLookupByLibrary.simpleMessage("旧密码："),
    "userVerifyButtonText" : m41,
    "userVerifyFieldHint" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "userVerifyFieldInfo" : MessageLookupByLibrary.simpleMessage("24小时内只能获取一组验证码"),
    "userVerifyFieldTitle" : MessageLookupByLibrary.simpleMessage("验证码:"),
    "walletViewButtonOneClick" : MessageLookupByLibrary.simpleMessage("一键归户"),
    "walletViewHintOneClick" : MessageLookupByLibrary.simpleMessage("所有平台额度转入主钱包"),
    "walletViewHintOneClickWait" : MessageLookupByLibrary.simpleMessage("归户中，请稍候..."),
    "walletViewHintWalletMulti" : MessageLookupByLibrary.simpleMessage("*需手动转移额度到该游戏平台"),
    "walletViewHintWalletSingle" : MessageLookupByLibrary.simpleMessage("*系统预设，自动将额度转入开启的游戏平台"),
    "walletViewMessageSetting" : MessageLookupByLibrary.simpleMessage("更改钱包设置"),
    "walletViewTitleMy" : MessageLookupByLibrary.simpleMessage("我的钱包"),
    "walletViewTitleRemain" : MessageLookupByLibrary.simpleMessage("总余额"),
    "walletViewTitleWalletMulti" : MessageLookupByLibrary.simpleMessage("多钱包"),
    "walletViewTitleWalletSingle" : MessageLookupByLibrary.simpleMessage("单一钱包"),
    "wheelApplyTableTextContent" : MessageLookupByLibrary.simpleMessage("内容"),
    "wheelApplyTableTextCount" : MessageLookupByLibrary.simpleMessage("旋转次数"),
    "wheelApplyTableTextProgress" : MessageLookupByLibrary.simpleMessage("进度"),
    "wheelApplyTableTextStatus" : MessageLookupByLibrary.simpleMessage("状态"),
    "wheelApplyTableTextStatus0" : MessageLookupByLibrary.simpleMessage("未达成"),
    "wheelApplyTableTextStatus1" : MessageLookupByLibrary.simpleMessage("已达成"),
    "wheelOrderTableTextPrize" : MessageLookupByLibrary.simpleMessage("奖项"),
    "wheelOrderTableTextStatus" : MessageLookupByLibrary.simpleMessage("派发状态"),
    "wheelOrderTableTextStatus0" : MessageLookupByLibrary.simpleMessage("未派发"),
    "wheelOrderTableTextStatus1" : MessageLookupByLibrary.simpleMessage("已派发"),
    "wheelOrderTableTextTime" : MessageLookupByLibrary.simpleMessage("时间"),
    "wheelRecordTableTextContent" : MessageLookupByLibrary.simpleMessage("内容"),
    "wheelRecordTableTextCount" : MessageLookupByLibrary.simpleMessage("次数"),
    "wheelRecordTableTextOperate" : MessageLookupByLibrary.simpleMessage("操作"),
    "wheelRecordTableTextTime" : MessageLookupByLibrary.simpleMessage("时间"),
    "wheelTableMessageEmpty" : m42,
    "wheelTextTitleCount" : m43,
    "wheelTextTitleGet" : MessageLookupByLibrary.simpleMessage("领取旋转次数"),
    "wheelTextTitlePrize" : MessageLookupByLibrary.simpleMessage("获奖纪录"),
    "wheelTextTitleRecord" : MessageLookupByLibrary.simpleMessage("操作纪录"),
    "wheelTextTitleRules" : MessageLookupByLibrary.simpleMessage("活动规则"),
    "withdrawViewOptionCgp" : MessageLookupByLibrary.simpleMessage("使用CGP钱包"),
    "withdrawViewOptionCpw" : MessageLookupByLibrary.simpleMessage("使用购宝钱包"),
    "withdrawViewOptionHint1" : MessageLookupByLibrary.simpleMessage("如需提取虚拟货币请绑定後选取"),
    "withdrawViewOptionHint2" : MessageLookupByLibrary.simpleMessage("流水要求剩余： "),
    "withdrawViewOptionHint3" : MessageLookupByLibrary.simpleMessage("提醒您流水数据会因为游戏商延迟而有差异"),
    "withdrawViewOptionVirtual" : MessageLookupByLibrary.simpleMessage("不使用虚拟货币"),
    "withdrawViewTitleAmount" : MessageLookupByLibrary.simpleMessage("提款金额"),
    "withdrawViewTitleNote" : MessageLookupByLibrary.simpleMessage("备注"),
    "withdrawViewTitlePwd" : MessageLookupByLibrary.simpleMessage("提现密码"),
    "workInProgress" : MessageLookupByLibrary.simpleMessage("功能即将上线!")
  };
}
