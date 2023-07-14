import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppStorage implements Storage {
  @override
  Future<void> clear() async {
    await HydratedBloc.storage.clear();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  read(String key) {
    return HydratedBloc.storage.read(key);
  }

  @override
  Future<void> write(String key, value) async {
    await HydratedBloc.storage.write(key, value);
  }
}
