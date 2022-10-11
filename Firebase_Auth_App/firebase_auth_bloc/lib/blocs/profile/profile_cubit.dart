import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_bloc/models/custom_error.dart';
import 'package:firebase_auth_bloc/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit({required this.profileRepository})
      : super(ProfileState.initial());

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final User user = await profileRepository.getProfile(uid: uid);
      emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: user));
    } on CustomError catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error, error: e));
    }
  }
}
