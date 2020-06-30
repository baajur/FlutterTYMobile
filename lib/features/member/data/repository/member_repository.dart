import 'dart:convert' show jsonDecode;

import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../source/member_data_source.dart';

abstract class MemberRepository {
  Future<Either<Failure, String>> updateCredit(String account);
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
  Future<Either<Failure, String>> updateCredit(String account) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.updateCredit(account));
      return result.fold(
        (failure) => Left(failure),
        (data) {
          try {
            var map = jsonDecode(data);
            if (map.containsKey('creditlimit')) {
              print('decoded limit: ${map['creditlimit']}');
              return Right(map['creditlimit']);
            } else {
              print('decoded: $map');
              return Left(Failure.token());
            }
          } catch (e) {
            print('credit limit error: $e');
            return Left(Failure.server());
          }
        },
      );
    }
    return Right('NaN');
  }
}
