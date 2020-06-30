import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/base/usecase_export.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/general/bloc_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadAreaRoute extends StatelessWidget {
  final List<String> appImages = [
    '/images/download/cgp_and.jpg',
    '/images/download/cgp_ios.jpg',
    '/images/download/dns_and.jpg',
    '/images/download/dns_ios.jpg',
  ];
  final List<String> appLabels = [
    'CGPAY Android版',
    'CGPAY IOS版',
    'DNS修复 Android版',
    'DNS修复 IOS版'
  ];
  final List<String> appHints = [
    '(安卓适用)',
    '(苹果适用)',
  ];
  final List<String> appLinks = [
    'https://mobile.cgpay.io/cgpdownload.aspx?type=android',
    'https://cgpay.pw/app_howIP.aspx',
    'https://play.google.com/store/apps/details?id=com.cloudflare.onedotonedotonedotone',
    'https://itunes.apple.com/us/app/1-1-1-1-faster-internet/id1423538627?mt=8',
  ];

  @override
  Widget build(BuildContext context) {
    if (appLinks.length != appImages.length) {
      return WarningDisplay(
        message:
            Failure.internal(FailureCode(typeCode: FailureTypeCode.SIDE_MENU))
                .message,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (_, index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        appLabels[index],
                        style: TextStyle(fontSize: 20),
                      ),
                      Text((index % 2 == 0) ? appHints[0] : appHints[1],
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 120,
                      maxWidth: Global.device.width - 32,
                    ),
                    child: Center(
                      child: GestureDetector(
                        child: networkImageBuilder(appImages[index]),
                        onTap: () async {
                          if (appLinks[index].isNotEmpty) {
                            String url = appLinks[index];
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              FLToast.showError(
                                text: localeStr.messageErrorLink(url),
                                showDuration: ToastDuration.DEFAULT.value,
                              );
                            }
                          }
                        },
                      ),
                    )),
              ],
            );
          },
        ),
      );
    }
  }
}
