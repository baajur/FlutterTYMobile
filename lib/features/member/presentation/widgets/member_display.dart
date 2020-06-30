import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/font_size.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/route_page_export.dart';

import '../state/member_credit_store.dart';
import 'member_grid_data.dart';
import 'member_display_header.dart';

class MemberDisplay extends StatefulWidget {
  final MemberCreditStore store;

  MemberDisplay(this.store);

  @override
  _MemberDisplayState createState() => _MemberDisplayState();
}

class _MemberDisplayState extends State<MemberDisplay> with AfterLayoutMixin {
  List<ReactionDisposer> _disposers;
  final GlobalKey<MemberDisplayHeaderState> headerKey =
      new GlobalKey<MemberDisplayHeaderState>(debugLabel: 'header');

  double headerMaxHeight;
  double headerMinHeight = 160;

  static final List<MemberGridItemV2> gridItems = [
    MemberGridItemV2.deposit,
    MemberGridItemV2.transfer,
    MemberGridItemV2.bankcard,
    MemberGridItemV2.withdraw,
    MemberGridItemV2.balance,
    MemberGridItemV2.wallet,
    MemberGridItemV2.stationMessages,
    MemberGridItemV2.accountCenter,
    MemberGridItemV2.transferRecord,
    MemberGridItemV2.betRecord,
    MemberGridItemV2.dealRecord,
    MemberGridItemV2.flowRecord,
    MemberGridItemV2.agent,
    MemberGridItemV2.logout,
  ];

  @override
  void initState() {
    headerMaxHeight =
        (Global.device.height - Global.APP_BAR_HEIGHT * 2) / 7 * 2;
    print('header height, max: $headerMaxHeight, min: $headerMinHeight');
    if (headerMaxHeight > 200) headerMaxHeight = 200;
    if (headerMaxHeight < headerMinHeight) headerMaxHeight = headerMinHeight;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Tell the reaction which observable to observe
        (_) => widget.store.credit,
        // Run some logic with the content of the observed field
        (credit) {
          print('reaction on credit update');
          headerKey.currentState.updateCredit = credit;
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minHeight: headerMinHeight,
              maxHeight: headerMaxHeight,
              maxWidth: Global.device.width,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Themes.linearAccentColor1,
                  Themes.linearAccentColor2,
                  Themes.linearAccentColor3
                ],
                tileMode: TileMode.clamp,
              ),
            ),
            child: MemberDisplayHeader(
              key: headerKey,
              userName: widget.store.user.account,
              vipLevel: widget.store.user.vip,
              onRefresh: () => widget.store.getCredit(),
            ),
          ),
          /* Features Grid */
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 2.0),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 4,
                //3,
                crossAxisSpacing: 4,
                childAspectRatio: 1.0,
                //1.4,
                shrinkWrap: true,
                children: gridItems
                    .map((itemData) => _createGridItemV2(itemData.value))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.store.getCredit();
  }
}

void _itemTapped(MemberGridDataV2 data) {
  print('item tapped: ${data.title}, route: ${data.route}');
  if (data.route != null) {
    if (data.route == RoutePage.withdraw)
      RouterNavigate.navigateToPage(data.route,
          arg: BankcardRouteArguments(withdraw: true));
    else
      RouterNavigate.navigateToPage(data.route);
  } else {
    FLToast.showInfo(text: localeStr.workInProgress);
  }
}

Widget _createGridItemV2(MemberGridDataV2 data) {
  return GestureDetector(
    onTap: () => _itemTapped(data),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 6.0),
              child: networkImageBuilder(data.imageName, imgScale: 2.0)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              data.title,
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value - 1,
                color: Themes.defaultAccentColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
