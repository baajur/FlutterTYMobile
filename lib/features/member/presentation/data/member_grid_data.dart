import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData, Color;
import 'package:flutter_ty_mobile/core/internal/hex_color.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generic_enum/generic_enum.dart';

part 'member_grid_data.freezed.dart';

@Deprecated('old version of grid item data')
@freezed
abstract class MemberGridData with _$MemberGridData {
  const factory MemberGridData({
    @required String title,
    @required IconData iconData,
    @required Color iconDecorColorStart,
    @required Color iconDecorColorEnd,
    RoutePage route,
  }) = _MemberGridData;
}

@Deprecated('old version of grid item enum, use [MemberGridItem] instead')
class MemberGridItem extends GenericEnum<MemberGridData> {
  const MemberGridItem._(MemberGridData value) : super(value);

  static MemberGridItem deposit = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleDeposit,
    iconData: const IconData(0xf1c0, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#ffb468'),
    iconDecorColorEnd: HexColor.fromHex('#f36500'),
    route: RoutePage.deposit,
  ));
  static MemberGridItem transfer = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleTransfer,
    iconData: const IconData(0xf079, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#6ede52'),
    iconDecorColorEnd: HexColor.fromHex('#32a063'),
    route: RoutePage.transfer,
  ));
  static MemberGridItem bankcard = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleCard,
    iconData: const IconData(0xf09d, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#7bdefb'),
    iconDecorColorEnd: HexColor.fromHex('#0082ce'),
    route: RoutePage.bankcard,
  ));
  static MemberGridItem withdraw = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleWithdraw,
    iconData: const IconData(0xf155, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#7294f5'),
    iconDecorColorEnd: HexColor.fromHex('#3054bb'),
    route: RoutePage.withdraw,
  ));
  static MemberGridItem balance = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleBalance,
    iconData: const IconData(0xf03a, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#ff88f0'),
    iconDecorColorEnd: HexColor.fromHex('#ad2087'),
    route: RoutePage.balance,
  ));
  static MemberGridItem wallet = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleWallet,
    iconData: const IconData(0xf155, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#3df3c0'),
    iconDecorColorEnd: HexColor.fromHex('#119c8f'),
    route: RoutePage.wallet,
  ));
  static MemberGridItem stationMessages = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleMessage,
    iconData: const IconData(0xf0e0, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#d265ff'),
    iconDecorColorEnd: HexColor.fromHex('#7c2fad'),
    route: RoutePage.message,
  ));
  static MemberGridItem accountCenter = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleAccount,
    iconData: const IconData(0xf2b9, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#e65757'),
    iconDecorColorEnd: HexColor.fromHex('#ce0909'),
    route: RoutePage.center,
  ));
  static MemberGridItem transferRecord = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleTransaction,
    iconData: const IconData(0xf0ca, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#f1dd98'),
    iconDecorColorEnd: HexColor.fromHex('#9c7407'),
    route: RoutePage.transaction,
  ));
  static MemberGridItem betRecord = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleBet,
    iconData: const IconData(0xf1cd, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#33c8ff'),
    iconDecorColorEnd: HexColor.fromHex('#185cc3'),
    route: RoutePage.betRecord,
  ));
  static MemberGridItem dealRecord = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleDeal,
    iconData: const IconData(0xf0cb, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#c8de59'),
    iconDecorColorEnd: HexColor.fromHex('#7c9c1f'),
    route: RoutePage.deals,
  ));
  static MemberGridItem flowRecord = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleFlow,
    iconData: const IconData(0xf06d, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#ed6b72'),
    iconDecorColorEnd: HexColor.fromHex('#b72541'),
    route: RoutePage.flows,
  ));
  static MemberGridItem agent = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleAgent,
    iconData: const IconData(0xf2ba, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#e68f63'),
    iconDecorColorEnd: HexColor.fromHex('#a75433'),
    route: RoutePage.agent,
  ));
  static MemberGridItem logout = MemberGridItem._(MemberGridData(
    title: localeStr.memberGridTitleLogout,
    iconData: const IconData(0xf08b, fontFamily: 'FontAwesome'),
    iconDecorColorStart: HexColor.fromHex('#cccccc'),
    iconDecorColorEnd: HexColor.fromHex('#929292'),
  ));
}
