///
//  Generated code. Do not modify.
//  source: score_evaluation_message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ScoreEvaluationMessage_GameLevel extends $pb.ProtobufEnum {
  static const ScoreEvaluationMessage_GameLevel ZERO = ScoreEvaluationMessage_GameLevel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZERO');
  static const ScoreEvaluationMessage_GameLevel ONE = ScoreEvaluationMessage_GameLevel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONE');
  static const ScoreEvaluationMessage_GameLevel TWO = ScoreEvaluationMessage_GameLevel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TWO');
  static const ScoreEvaluationMessage_GameLevel THREE = ScoreEvaluationMessage_GameLevel._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'THREE');
  static const ScoreEvaluationMessage_GameLevel FOUR = ScoreEvaluationMessage_GameLevel._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOUR');

  static const $core.List<ScoreEvaluationMessage_GameLevel> values = <ScoreEvaluationMessage_GameLevel> [
    ZERO,
    ONE,
    TWO,
    THREE,
    FOUR,
  ];

  static final $core.Map<$core.int, ScoreEvaluationMessage_GameLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ScoreEvaluationMessage_GameLevel? valueOf($core.int value) => _byValue[value];

  const ScoreEvaluationMessage_GameLevel._($core.int v, $core.String n) : super(v, n);
}

