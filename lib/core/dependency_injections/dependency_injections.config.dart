// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i3;

import '../../features/home/data/data_sources/remote/home_remote_data_source.dart'
    as _i5;
import '../../features/home/data/repository/home_repository_impl.dart' as _i7;
import '../../features/home/domain/repository/home_repository.dart' as _i6;
import '../../features/home/domain/usecases/get_image_info.dart' as _i8;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i9;
import '../service/network_service.dart' as _i4;
import 'dependency_injections.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModules = _$RegisterModules();
  gh.factory<_i3.InternetConnectionChecker>(
      () => registerModules.internetConnectionChecker);
  gh.factory<_i4.NetworkService>(() => _i4.NetworkService(
      connectionChecker: get<_i3.InternetConnectionChecker>()));
  gh.factory<_i5.HomeRemoteDataSource>(() =>
      _i5.HomeRemoteDataSource(networkService: get<_i4.NetworkService>()));
  gh.factory<_i6.HomeRepository>(() =>
      _i7.HomeRepositoryImpl(dataSource: get<_i5.HomeRemoteDataSource>()));
  gh.factory<_i8.GetImageInfo>(
      () => _i8.GetImageInfo(repository: get<_i6.HomeRepository>()));
  gh.factory<_i9.HomeBloc>(
      () => _i9.HomeBloc(getImageInfo: get<_i8.GetImageInfo>()));
  return get;
}

class _$RegisterModules extends _i10.RegisterModules {
  @override
  _i3.InternetConnectionChecker get internetConnectionChecker =>
      _i3.InternetConnectionChecker();
}
