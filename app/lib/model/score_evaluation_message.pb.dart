///
//  Generated code. Do not modify.
//  source: score_evaluation_message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'score_evaluation_message.pbenum.dart';

export 'score_evaluation_message.pbenum.dart';

class ScoreEvaluationMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScoreEvaluationMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'tutorial'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'repositoryUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'branch')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dropInterval', $pb.PbFieldType.O3)
    ..e<ScoreEvaluationMessage_GameLevel>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: ScoreEvaluationMessage_GameLevel.ZERO, valueOf: ScoreEvaluationMessage_GameLevel.valueOf, enumValues: ScoreEvaluationMessage_GameLevel.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameMode')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameTime', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeout', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'predictWeightPath')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trialNum', $pb.PbFieldType.O3)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', $pb.PbFieldType.O3)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..p<$fixnum.Int64>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'randomSeeds', $pb.PbFieldType.KU6)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'competition')
    ..hasRequiredFields = false
  ;

  ScoreEvaluationMessage._() : super();
  factory ScoreEvaluationMessage({
    $core.String? repositoryUrl,
    $core.String? branch,
    $core.int? dropInterval,
    ScoreEvaluationMessage_GameLevel? level,
    $core.String? gameMode,
    $core.int? gameTime,
    $core.int? timeout,
    $core.String? predictWeightPath,
    $core.int? trialNum,
    $core.String? id,
    $core.int? createdAt,
    $core.String? name,
    $core.Iterable<$fixnum.Int64>? randomSeeds,
    $core.String? competition,
  }) {
    final _result = create();
    if (repositoryUrl != null) {
      _result.repositoryUrl = repositoryUrl;
    }
    if (branch != null) {
      _result.branch = branch;
    }
    if (dropInterval != null) {
      _result.dropInterval = dropInterval;
    }
    if (level != null) {
      _result.level = level;
    }
    if (gameMode != null) {
      _result.gameMode = gameMode;
    }
    if (gameTime != null) {
      _result.gameTime = gameTime;
    }
    if (timeout != null) {
      _result.timeout = timeout;
    }
    if (predictWeightPath != null) {
      _result.predictWeightPath = predictWeightPath;
    }
    if (trialNum != null) {
      _result.trialNum = trialNum;
    }
    if (id != null) {
      _result.id = id;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (name != null) {
      _result.name = name;
    }
    if (randomSeeds != null) {
      _result.randomSeeds.addAll(randomSeeds);
    }
    if (competition != null) {
      _result.competition = competition;
    }
    return _result;
  }
  factory ScoreEvaluationMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScoreEvaluationMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScoreEvaluationMessage clone() => ScoreEvaluationMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScoreEvaluationMessage copyWith(void Function(ScoreEvaluationMessage) updates) => super.copyWith((message) => updates(message as ScoreEvaluationMessage)) as ScoreEvaluationMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScoreEvaluationMessage create() => ScoreEvaluationMessage._();
  ScoreEvaluationMessage createEmptyInstance() => create();
  static $pb.PbList<ScoreEvaluationMessage> createRepeated() => $pb.PbList<ScoreEvaluationMessage>();
  @$core.pragma('dart2js:noInline')
  static ScoreEvaluationMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScoreEvaluationMessage>(create);
  static ScoreEvaluationMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get repositoryUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set repositoryUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRepositoryUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearRepositoryUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get branch => $_getSZ(1);
  @$pb.TagNumber(2)
  set branch($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBranch() => $_has(1);
  @$pb.TagNumber(2)
  void clearBranch() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get dropInterval => $_getIZ(2);
  @$pb.TagNumber(3)
  set dropInterval($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDropInterval() => $_has(2);
  @$pb.TagNumber(3)
  void clearDropInterval() => clearField(3);

  @$pb.TagNumber(4)
  ScoreEvaluationMessage_GameLevel get level => $_getN(3);
  @$pb.TagNumber(4)
  set level(ScoreEvaluationMessage_GameLevel v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLevel() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get gameMode => $_getSZ(4);
  @$pb.TagNumber(5)
  set gameMode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGameMode() => $_has(4);
  @$pb.TagNumber(5)
  void clearGameMode() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get gameTime => $_getIZ(5);
  @$pb.TagNumber(6)
  set gameTime($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGameTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearGameTime() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get timeout => $_getIZ(6);
  @$pb.TagNumber(7)
  set timeout($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTimeout() => $_has(6);
  @$pb.TagNumber(7)
  void clearTimeout() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get predictWeightPath => $_getSZ(7);
  @$pb.TagNumber(8)
  set predictWeightPath($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPredictWeightPath() => $_has(7);
  @$pb.TagNumber(8)
  void clearPredictWeightPath() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get trialNum => $_getIZ(8);
  @$pb.TagNumber(9)
  set trialNum($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTrialNum() => $_has(8);
  @$pb.TagNumber(9)
  void clearTrialNum() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get id => $_getSZ(9);
  @$pb.TagNumber(10)
  set id($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasId() => $_has(9);
  @$pb.TagNumber(10)
  void clearId() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get createdAt => $_getIZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get name => $_getSZ(11);
  @$pb.TagNumber(12)
  set name($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasName() => $_has(11);
  @$pb.TagNumber(12)
  void clearName() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$fixnum.Int64> get randomSeeds => $_getList(12);

  @$pb.TagNumber(14)
  $core.String get competition => $_getSZ(13);
  @$pb.TagNumber(14)
  set competition($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCompetition() => $_has(13);
  @$pb.TagNumber(14)
  void clearCompetition() => clearField(14);
}

