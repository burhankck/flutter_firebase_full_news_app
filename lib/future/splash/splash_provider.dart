import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_full_news_app/product/enums/platform_enums.dart';

import 'package:flutter_firebase_full_news_app/product/models/number_model.dart';
import 'package:flutter_firebase_full_news_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_full_news_app/product/utility/version_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkApplicationVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();
    if (databaseValue == null || databaseValue.isEmpty) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }

    final checkIsNeedForceUpdate = VersionManager(
        deviceValue: clientVersion, databaseValue: databaseValue);
    if (checkIsNeedForceUpdate.isNeedUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    state = state.copyWith(isRedirectHome: true);
  }

  // if user coming from browser, we dont need to check version control
  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) return null;

    final response = await FirebaseCollections.version.reference
        .withConverter<NumberModel>(
            fromFirestore: (snapshot, options) =>
                NumberModel().fromFirebase(snapshot),
            toFirestore: (value, options) {
              return value.toJson();
            })
        .doc(PlatformEnums.versionName)
        .get();
    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  SplashState({this.isRequiredForceUpdate, this.isRedirectHome});

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
       isRequiredForceUpdate:  isRequiredForceUpdate ?? this.isRequiredForceUpdate,
       isRedirectHome:  isRedirectHome ?? this.isRedirectHome,
    );
  }
}
