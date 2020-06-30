import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_ty_mobile/features/user/login/presentation/state/login_store.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_api_service.dart';
import 'core/network/util/network_info.dart';
import 'features/home/home_inject.dart';
import 'features/member/member_inject.dart';
import 'features/promo/promo_inject.dart';
import 'features/router/route_user_streams.dart';
import 'features/screen/web_game_screen_store.dart';
import 'features/subfeatures/bankcard/bankcard_inject.dart';
import 'features/subfeatures/betrecord/bet_record_inject.dart';
import 'features/subfeatures/deposit/deposit_inject.dart';
import 'features/subfeatures/register/register_inject.dart';
import 'features/subfeatures/store/store_inject.dart';
import 'features/subfeatures/transfer/transfer_inject.dart';
import 'features/subfeatures/balance/balance_inject.dart';
import 'features/subfeatures/wallet/wallet_inject.dart';
import 'features/subfeatures/message/message_inject.dart';
import 'features/subfeatures/accountcenter/center_inject.dart';
import 'features/subfeatures/transactions/transaction_inject.dart';
import 'features/subfeatures/deals/deals_inject.dart';
import 'features/subfeatures/notice/notice_inject.dart';
import 'features/subfeatures/flows/flows_inject.dart';
import 'features/subfeatures/agent/agent_inject.dart';
import 'features/subfeatures/viplevel/vip_level_inject.dart';
import 'features/user/event/event_inject.dart';
import 'features/user/login/login_inject.dart';
import 'template/template_inject.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<RouteUserStreams>(() => RouteUserStreams());

  /// Bloc
  sl.registerFactory(
    () => HomeBannerBloc(
      homeBannerData: sl(),
      homeBannerImageInfo: sl(),
    ),
  );
  sl.registerFactory(
    () => HomeMarqueeBloc(homeMarqueeData: sl()),
  );
  sl.registerFactory(
    () => HomeGameTabsBloc(gameTypesData: sl()),
  );
  sl.registerFactory(
    () => HomeGameBloc(gamesData: sl(), gameUrl: sl()),
  );

  /// Use cases
  sl.registerLazySingleton(() => GetHomeBannerData(sl()));
  sl.registerLazySingleton(() => GetHomeBannerImage());
  sl.registerLazySingleton(() => GetHomeMarqueeData(sl()));
  sl.registerLazySingleton(() => GetGameTypesData(sl()));
  sl.registerLazySingleton(() => GetGamesData(sl()));
  sl.registerLazySingleton(() => GetGameUrl(sl()));

  /// Mobx Store
  sl.registerLazySingleton<WebGameScreenStore>(
    () => WebGameScreenStore(),
  );
  sl.registerFactory(
    () => LoginStore(sl<UserRepository>()),
  );
  sl.registerFactory(
    () => RegisterStore(sl<RegisterRepository>(), sl<UserRepository>()),
  );
  sl.registerFactory(
    () => PromoStore(sl<PromoRepository>()),
  );
  sl.registerFactory(
    () => MemberCreditStore(sl<MemberRepository>()),
  );
  sl.registerFactory(
    () => DepositStore(sl<DepositRepository>()),
  );
  sl.registerFactory(
    () => TransferStore(sl<TransferRepository>()),
  );
  sl.registerFactory(
    () => BankcardStore(sl<BankcardRepository>()),
  );
  sl.registerFactory(
    () => WithdrawStore(sl<WithdrawRepository>()),
  );
  sl.registerFactory(
    () => BalanceStore(sl<BalanceRepository>()),
  );
  sl.registerFactory(
    () => WalletStore(sl<WalletRepository>()),
  );
  sl.registerFactory(
    () => MessageStore(sl<MessageRepository>()),
  );
  sl.registerFactory(
    () => CenterStore(sl<CenterRepository>()),
  );
  sl.registerFactory(
    () => TransactionStore(sl<TransactionRepository>()),
  );
  sl.registerFactory(
    () => BetRecordStore(sl<BetRecordRepository>()),
  );
  sl.registerFactory(
    () => DealsStore(sl<DealsRepository>()),
  );
  sl.registerFactory(
    () => FlowsStore(sl<FlowsRepository>()),
  );
  sl.registerFactory(
    () => AgentStore(sl<AgentRepository>()),
  );
  sl.registerFactory(
    () => NoticeStore(sl<NoticeRepository>()),
  );
  sl.registerFactory(
    () => VipLevelStore(sl<VipLevelRepository>()),
  );
  sl.registerFactory(
    () => PointStore(sl<StoreRepository>()),
  );

  /// Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<PromoRepository>(
    () => PromoRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DepositRepository>(
    () => DepositRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<BankcardRepository>(
    () => BankcardRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<WithdrawRepository>(
    () => WithdrawRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CenterRepository>(
    () => CenterRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<PromoRemoteDataSource>(
    () => PromoRemoteDataSourceImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<PromoLocalDataSource>(
    () => PromoLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<MemberRemoteDataSource>(
    () => MemberRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<MemberJwtInterface>(
    () => MemberJwtInterfaceImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<DepositRemoteDataSource>(
    () => DepositRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<TransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<BankcardRemoteDataSource>(
    () => BankcardRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<WithdrawRemoteDataSource>(
    () => WithdrawRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<BalanceRepository>(
    () => BalanceRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<CenterRemoteDataSource>(
    () => CenterRemoteDataSourceImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<BetRecordRepository>(
    () => BetRecordRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<DealsRepository>(
    () => DealsRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<FlowsRepository>(
    () => FlowsRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<AgentRepository>(
    () => AgentRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<NoticeRepository>(
    () => NoticeRepositoryImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<VipLevelRepository>(
    () => VipLevelRepositoryImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<StoreRepository>(
    () => StoreRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );

  /// Core
  sl.registerLazySingleton(() => DioApiService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External Package
  sl.registerSingleton(() => MyLogger());
  sl.registerLazySingleton(() => DataConnectionChecker());

  /// Test only
  /* Template Mobx */
  sl.registerLazySingleton<TemplateRemoteDataSource>(
    () => TemplateRemoteDataSourceImpl(dioApiService: sl()),
  );

  sl.registerLazySingleton<TemplateRepository>(
    () => TemplateRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TemplateStore>(
    () => TemplateStore(sl<TemplateRepository>()),
  );

  /* Template Bloc */
  sl.registerFactory(
    () => Template2Bloc(
      descriptionData: sl(),
      descriptionData2: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetDescriptionData(sl()));
  sl.registerLazySingleton(() => GetDescriptionData2(sl()));

  sl.registerLazySingleton<Template2Repository>(
    () => Template2RepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<Template2DataSource>(
    () => Template2DataSourceImpl(dioApiService: sl()),
  );
}
