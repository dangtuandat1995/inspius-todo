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
    as _i11;
import '../../features/home/data/repository/home_repository_impl.dart' as _i13;
import '../../features/home/domain/repository/home_repository.dart' as _i12;
import '../../features/home/domain/usecases/get_image_info.dart' as _i16;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i17;
import '../../features/todo/data/data_source/todo_data_source.dart' as _i5;
import '../../features/todo/data/repository/todo_repository_impl.dart' as _i7;
import '../../features/todo/domain/repository/todo_repository.dart' as _i6;
import '../../features/todo/domain/usecases/create_task.dart' as _i9;
import '../../features/todo/domain/usecases/delete_task.dart' as _i10;
import '../../features/todo/domain/usecases/read_task.dart' as _i14;
import '../../features/todo/domain/usecases/update_task.dart' as _i8;
import '../../features/todo/presentation/bloc/todo_bloc.dart' as _i15;
import '../service/network_service.dart' as _i4;
import 'dependency_injections.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i5.TodoDataSource>(() => _i5.TodoDataSource(
      connectionChecker: get<_i3.InternetConnectionChecker>()));
  gh.factory<_i6.TodoRepository>(
      () => _i7.TodoRepositoryImpl(dataSource: get<_i5.TodoDataSource>()));
  gh.factory<_i8.UpdateTask>(
      () => _i8.UpdateTask(repository: get<_i6.TodoRepository>()));
  gh.factory<_i9.CreateTask>(
      () => _i9.CreateTask(repository: get<_i6.TodoRepository>()));
  gh.factory<_i10.DeleteTask>(
      () => _i10.DeleteTask(repository: get<_i6.TodoRepository>()));
  gh.factory<_i11.HomeRemoteDataSource>(() =>
      _i11.HomeRemoteDataSource(networkService: get<_i4.NetworkService>()));
  gh.factory<_i12.HomeRepository>(() =>
      _i13.HomeRepositoryImpl(dataSource: get<_i11.HomeRemoteDataSource>()));
  gh.factory<_i14.ReadTask>(
      () => _i14.ReadTask(repository: get<_i6.TodoRepository>()));
  gh.factory<_i15.TodoBloc>(() => _i15.TodoBloc(
        createTask: get<_i9.CreateTask>(),
        readTask: get<_i14.ReadTask>(),
        updateTask: get<_i8.UpdateTask>(),
        deleteTask: get<_i10.DeleteTask>(),
      ));
  gh.factory<_i16.GetImageInfo>(
      () => _i16.GetImageInfo(repository: get<_i12.HomeRepository>()));
  gh.factory<_i17.HomeBloc>(
      () => _i17.HomeBloc(getImageInfo: get<_i16.GetImageInfo>()));
  return get;
}

class _$RegisterModules extends _i18.RegisterModules {
  @override
  _i3.InternetConnectionChecker get internetConnectionChecker =>
      _i3.InternetConnectionChecker();
}
