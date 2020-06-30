import 'dart:convert' show jsonDecode;

import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../source/member_data_source.dart';

abstract class MemberRepository {
  Future<String> updateCredit(String account);
}

class MemberRepositoryImpl implements MemberRepository {
  final tag = 'MemberRepository';
  final MemberRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MemberRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<String> updateCredit(String account) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.updateCredit(account));
      return result.fold(
        (failure) => 'NaN',
        (data) {
          try {
            var map = jsonDecode(data);
            if (map.containsKey('creditlimit')) {
              print('decoded limit: ${map['creditlimit']}');
              return map['creditlimit'];
            } else {
              print('decoded: $map');
              return '-1';
            }
          } catch (e) {
            print('credit limit error: $e');
            return '-1';
          }
        },
      );
    }
    return 'NaN';
  }
}
