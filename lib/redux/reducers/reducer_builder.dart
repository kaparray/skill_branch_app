import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/redux/reducers/user_reducer.dart';

import 'package:skill_branch_flutter/redux/states/app_state.dart';

//ignore_for_file:could_not_infer

final reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()..combineNested(createUserReducer());

final reducers = reducerBuilder.build();
