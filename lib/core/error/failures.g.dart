// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Failure extends Equatable {
  const Failure(this._type);

  factory Failure.network() = Network;

  factory Failure.networkLocation() = NetworkLocation;

  factory Failure.server() = Server;

  factory Failure.jsonFormat() = JsonFormat;

  factory Failure.dataType() = DataType;

  factory Failure.cachedFile() = CachedFile;

  factory Failure.internal(FailureCode failureCode) = FailureCodeWrapper;

  factory Failure.login(RequestStatusModel requestStatusModel) =
      RequestStatusModelWrapper;

  factory Failure.token() = Token;

  final _Failure _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Network) network,
      @required R Function(NetworkLocation) networkLocation,
      @required R Function(Server) server,
      @required R Function(JsonFormat) jsonFormat,
      @required R Function(DataType) dataType,
      @required R Function(CachedFile) cachedFile,
      @required R Function(FailureCode) internal,
      @required R Function(RequestStatusModel) login,
      @required R Function(Token) token}) {
    assert(() {
      if (network == null ||
          networkLocation == null ||
          server == null ||
          jsonFormat == null ||
          dataType == null ||
          cachedFile == null ||
          internal == null ||
          login == null ||
          token == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Failure.Network:
        return network(this as Network);
      case _Failure.NetworkLocation:
        return networkLocation(this as NetworkLocation);
      case _Failure.Server:
        return server(this as Server);
      case _Failure.JsonFormat:
        return jsonFormat(this as JsonFormat);
      case _Failure.DataType:
        return dataType(this as DataType);
      case _Failure.CachedFile:
        return cachedFile(this as CachedFile);
      case _Failure.Internal:
        return internal((this as FailureCodeWrapper).failureCode);
      case _Failure.Login:
        return login((this as RequestStatusModelWrapper).requestStatusModel);
      case _Failure.Token:
        return token(this as Token);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Network) network,
      @required FutureOr<R> Function(NetworkLocation) networkLocation,
      @required FutureOr<R> Function(Server) server,
      @required FutureOr<R> Function(JsonFormat) jsonFormat,
      @required FutureOr<R> Function(DataType) dataType,
      @required FutureOr<R> Function(CachedFile) cachedFile,
      @required FutureOr<R> Function(FailureCode) internal,
      @required FutureOr<R> Function(RequestStatusModel) login,
      @required FutureOr<R> Function(Token) token}) {
    assert(() {
      if (network == null ||
          networkLocation == null ||
          server == null ||
          jsonFormat == null ||
          dataType == null ||
          cachedFile == null ||
          internal == null ||
          login == null ||
          token == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Failure.Network:
        return network(this as Network);
      case _Failure.NetworkLocation:
        return networkLocation(this as NetworkLocation);
      case _Failure.Server:
        return server(this as Server);
      case _Failure.JsonFormat:
        return jsonFormat(this as JsonFormat);
      case _Failure.DataType:
        return dataType(this as DataType);
      case _Failure.CachedFile:
        return cachedFile(this as CachedFile);
      case _Failure.Internal:
        return internal((this as FailureCodeWrapper).failureCode);
      case _Failure.Login:
        return login((this as RequestStatusModelWrapper).requestStatusModel);
      case _Failure.Token:
        return token(this as Token);
    }
  }

  R whenOrElse<R>(
      {R Function(Network) network,
      R Function(NetworkLocation) networkLocation,
      R Function(Server) server,
      R Function(JsonFormat) jsonFormat,
      R Function(DataType) dataType,
      R Function(CachedFile) cachedFile,
      R Function(FailureCode) internal,
      R Function(RequestStatusModel) login,
      R Function(Token) token,
      @required R Function(Failure) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Failure.Network:
        if (network == null) break;
        return network(this as Network);
      case _Failure.NetworkLocation:
        if (networkLocation == null) break;
        return networkLocation(this as NetworkLocation);
      case _Failure.Server:
        if (server == null) break;
        return server(this as Server);
      case _Failure.JsonFormat:
        if (jsonFormat == null) break;
        return jsonFormat(this as JsonFormat);
      case _Failure.DataType:
        if (dataType == null) break;
        return dataType(this as DataType);
      case _Failure.CachedFile:
        if (cachedFile == null) break;
        return cachedFile(this as CachedFile);
      case _Failure.Internal:
        if (internal == null) break;
        return internal((this as FailureCodeWrapper).failureCode);
      case _Failure.Login:
        if (login == null) break;
        return login((this as RequestStatusModelWrapper).requestStatusModel);
      case _Failure.Token:
        if (token == null) break;
        return token(this as Token);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Network) network,
      FutureOr<R> Function(NetworkLocation) networkLocation,
      FutureOr<R> Function(Server) server,
      FutureOr<R> Function(JsonFormat) jsonFormat,
      FutureOr<R> Function(DataType) dataType,
      FutureOr<R> Function(CachedFile) cachedFile,
      FutureOr<R> Function(FailureCode) internal,
      FutureOr<R> Function(RequestStatusModel) login,
      FutureOr<R> Function(Token) token,
      @required FutureOr<R> Function(Failure) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Failure.Network:
        if (network == null) break;
        return network(this as Network);
      case _Failure.NetworkLocation:
        if (networkLocation == null) break;
        return networkLocation(this as NetworkLocation);
      case _Failure.Server:
        if (server == null) break;
        return server(this as Server);
      case _Failure.JsonFormat:
        if (jsonFormat == null) break;
        return jsonFormat(this as JsonFormat);
      case _Failure.DataType:
        if (dataType == null) break;
        return dataType(this as DataType);
      case _Failure.CachedFile:
        if (cachedFile == null) break;
        return cachedFile(this as CachedFile);
      case _Failure.Internal:
        if (internal == null) break;
        return internal((this as FailureCodeWrapper).failureCode);
      case _Failure.Login:
        if (login == null) break;
        return login((this as RequestStatusModelWrapper).requestStatusModel);
      case _Failure.Token:
        if (token == null) break;
        return token(this as Token);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Network) network,
      FutureOr<void> Function(NetworkLocation) networkLocation,
      FutureOr<void> Function(Server) server,
      FutureOr<void> Function(JsonFormat) jsonFormat,
      FutureOr<void> Function(DataType) dataType,
      FutureOr<void> Function(CachedFile) cachedFile,
      FutureOr<void> Function(FailureCode) internal,
      FutureOr<void> Function(RequestStatusModel) login,
      FutureOr<void> Function(Token) token}) {
    assert(() {
      if (network == null &&
          networkLocation == null &&
          server == null &&
          jsonFormat == null &&
          dataType == null &&
          cachedFile == null &&
          internal == null &&
          login == null &&
          token == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Failure.Network:
        if (network == null) break;
        return network(this as Network);
      case _Failure.NetworkLocation:
        if (networkLocation == null) break;
        return networkLocation(this as NetworkLocation);
      case _Failure.Server:
        if (server == null) break;
        return server(this as Server);
      case _Failure.JsonFormat:
        if (jsonFormat == null) break;
        return jsonFormat(this as JsonFormat);
      case _Failure.DataType:
        if (dataType == null) break;
        return dataType(this as DataType);
      case _Failure.CachedFile:
        if (cachedFile == null) break;
        return cachedFile(this as CachedFile);
      case _Failure.Internal:
        if (internal == null) break;
        return internal((this as FailureCodeWrapper).failureCode);
      case _Failure.Login:
        if (login == null) break;
        return login((this as RequestStatusModelWrapper).requestStatusModel);
      case _Failure.Token:
        if (token == null) break;
        return token(this as Token);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Network extends Failure {
  const Network._() : super(_Failure.Network);

  factory Network() {
    _instance ??= const Network._();
    return _instance;
  }

  static Network _instance;
}

@immutable
class NetworkLocation extends Failure {
  const NetworkLocation._() : super(_Failure.NetworkLocation);

  factory NetworkLocation() {
    _instance ??= const NetworkLocation._();
    return _instance;
  }

  static NetworkLocation _instance;
}

@immutable
class Server extends Failure {
  const Server._() : super(_Failure.Server);

  factory Server() {
    _instance ??= const Server._();
    return _instance;
  }

  static Server _instance;
}

@immutable
class JsonFormat extends Failure {
  const JsonFormat._() : super(_Failure.JsonFormat);

  factory JsonFormat() {
    _instance ??= const JsonFormat._();
    return _instance;
  }

  static JsonFormat _instance;
}

@immutable
class DataType extends Failure {
  const DataType._() : super(_Failure.DataType);

  factory DataType() {
    _instance ??= const DataType._();
    return _instance;
  }

  static DataType _instance;
}

@immutable
class CachedFile extends Failure {
  const CachedFile._() : super(_Failure.CachedFile);

  factory CachedFile() {
    _instance ??= const CachedFile._();
    return _instance;
  }

  static CachedFile _instance;
}

@immutable
class FailureCodeWrapper extends Failure {
  const FailureCodeWrapper(this.failureCode) : super(_Failure.Internal);

  final FailureCode failureCode;

  @override
  String toString() => 'FailureCodeWrapper($failureCode)';
  @override
  List get props => [failureCode];
}

@immutable
class RequestStatusModelWrapper extends Failure {
  const RequestStatusModelWrapper(this.requestStatusModel)
      : super(_Failure.Login);

  final RequestStatusModel requestStatusModel;

  @override
  String toString() => 'RequestStatusModelWrapper($requestStatusModel)';
  @override
  List get props => [requestStatusModel];
}

@immutable
class Token extends Failure {
  const Token._() : super(_Failure.Token);

  factory Token() {
    _instance ??= const Token._();
    return _instance;
  }

  static Token _instance;
}