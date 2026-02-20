import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcc_remake_bloc/core/utils/storage/secure_storage_util.dart';

final userStorageProvider = Provider<UserStorageWrapper>((ref) {
  return UserStorageWrapper();
});