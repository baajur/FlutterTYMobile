import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/presentation/transaction_route.dart';
import 'package:flutter_ty_mobile/template/mobx/presentation/template_route.dart';
import 'package:flutter_ty_mobile/template/page/presentation/template2_route.dart';

import '../home/presentation/home_route.dart';
import '../member/presentation/member_route.dart';
import '../promo/presentation/promo_route.dart';
import '../subfeatures/bankcard/presentation/bankcard_route.dart';
import '../subfeatures/deposit/presentation/deposit_route.dart';
import '../subfeatures/downloadarea/download_area_route.dart';
import '../subfeatures/transfer/presentation/transfer_route.dart';
import '../subfeatures/accountcenter/presentation/center_route.dart';
import '../subfeatures/wallet/presentation/wallet_route.dart';
import '../subfeatures/accountcenter/presentation/widgets/center_display_account_pwd.dart';
import '../subfeatures/balance/presentation/balance_route.dart';
import '../subfeatures/message/presentation/message_route.dart';
import '../subfeatures/notice/presentation/notice_route.dart';
import '../test_area_route.dart';
import '../users/presentation/login_route.dart';
import '../web/web_route.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomeRoute homeRoute;
  LoginRoute loginRoute;
  WebRoute serviceRoute;
  MemberRoute memberRoute;
  PromoRoute promoRoute;
  DepositRoute depositRoute;
  WebRoute depositWebPage;
  TransferRoute transferRoute;
  BankcardRoute bankcardRoute;
  BalanceRoute balanceRoute;
  WalletRoute walletRoute;
  MessageRoute messageRoute;
  CenterRoute centerRoute;
  CenterDisplayAccountPassword centerPasswordPage;
  TransactionRoute transactionRoute;
  WebRoute centerWebPage;

  /// side menu route
  DownloadAreaRoute downloadAreaRoute;
  NoticeRoute noticeRoute;

  /// test route
  TestAreaRoute testAreaRoute;
  @MaterialRoute(fullscreenDialog: true)
  TemplateRoute templateRoute;
  @MaterialRoute(fullscreenDialog: true)
  Template2Route template2Route;
//  @CustomRoute(
//    transitionsBuilder: TransitionsBuilders.zoomIn,
//    durationInMilliseconds: 200,
//  )
}
