///
//  Generated code. Do not modify.
//  source: score_evaluation_message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use scoreEvaluationMessageDescriptor instead')
const ScoreEvaluationMessage$json = const {
  '1': 'ScoreEvaluationMessage',
  '2': const [
    const {'1': 'repository_url', '3': 1, '4': 1, '5': 9, '10': 'repositoryUrl'},
    const {'1': 'branch', '3': 2, '4': 1, '5': 9, '10': 'branch'},
    const {'1': 'drop_interval', '3': 3, '4': 1, '5': 5, '10': 'dropInterval'},
    const {'1': 'level', '3': 4, '4': 1, '5': 14, '6': '.tutorial.ScoreEvaluationMessage.GameLevel', '10': 'level'},
    const {'1': 'game_mode', '3': 5, '4': 1, '5': 9, '10': 'gameMode'},
    const {'1': 'game_time', '3': 6, '4': 1, '5': 5, '10': 'gameTime'},
    const {'1': 'timeout', '3': 7, '4': 1, '5': 5, '10': 'timeout'},
    const {'1': 'predict_weight_path', '3': 8, '4': 1, '5': 9, '10': 'predictWeightPath'},
    const {'1': 'trial_num', '3': 9, '4': 1, '5': 5, '10': 'trialNum'},
  ],
  '4': const [ScoreEvaluationMessage_GameLevel$json],
};

@$core.Deprecated('Use scoreEvaluationMessageDescriptor instead')
const ScoreEvaluationMessage_GameLevel$json = const {
  '1': 'GameLevel',
  '2': const [
    const {'1': 'ZERO', '2': 0},
    const {'1': 'ONE', '2': 1},
    const {'1': 'TWO', '2': 2},
    const {'1': 'THREE', '2': 3},
    const {'1': 'FOUR', '2': 4},
  ],
};

/// Descriptor for `ScoreEvaluationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreEvaluationMessageDescriptor = $convert.base64Decode('ChZTY29yZUV2YWx1YXRpb25NZXNzYWdlEiUKDnJlcG9zaXRvcnlfdXJsGAEgASgJUg1yZXBvc2l0b3J5VXJsEhYKBmJyYW5jaBgCIAEoCVIGYnJhbmNoEiMKDWRyb3BfaW50ZXJ2YWwYAyABKAVSDGRyb3BJbnRlcnZhbBJACgVsZXZlbBgEIAEoDjIqLnR1dG9yaWFsLlNjb3JlRXZhbHVhdGlvbk1lc3NhZ2UuR2FtZUxldmVsUgVsZXZlbBIbCglnYW1lX21vZGUYBSABKAlSCGdhbWVNb2RlEhsKCWdhbWVfdGltZRgGIAEoBVIIZ2FtZVRpbWUSGAoHdGltZW91dBgHIAEoBVIHdGltZW91dBIuChNwcmVkaWN0X3dlaWdodF9wYXRoGAggASgJUhFwcmVkaWN0V2VpZ2h0UGF0aBIbCgl0cmlhbF9udW0YCSABKAVSCHRyaWFsTnVtIjwKCUdhbWVMZXZlbBIICgRaRVJPEAASBwoDT05FEAESBwoDVFdPEAISCQoFVEhSRUUQAxIICgRGT1VSEAQ=');
