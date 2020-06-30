import 'package:data_connection_checker/data_connection_checker.dart';
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
  /// App User
  sl.registerLazySingleton<RouteUserStreams>(() => RouteUserStreams());

  /// Core
  sl.registerLazySingleton(() => DioApiService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External Package
  sl.registerSingleton(() => MyLogger());
  sl.registerLazySingleton(() => DataConnectionChecker());

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

  /// Data sources
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  /// Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<PromoLocalStorage>(
    () => PromoLocalStorageImpl(),
  );
  sl.registerLazySingleton<PromoRepository>(
    () => PromoRepositoryImpl(
        dioApiService: sl(), localStorage: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<MemberJwtInterface>(
    () => MemberJwtInterfaceImpl(dioApiService: sl()),
  );
  sl.registerLazySingleton<DepositRepository>(
    () => DepositRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<BankcardRepository>(
    () => BankcardRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<WithdrawRepository>(
    () => WithdrawRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<BalanceRepository>(
    () => BalanceRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton<CenterRepository>(
    () => CenterRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
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
