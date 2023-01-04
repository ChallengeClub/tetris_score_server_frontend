// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_table_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EntryTable {
  List<EntryModel> get entries => throw _privateConstructorUsedError;
  String get sortColumn => throw _privateConstructorUsedError;
  bool get isSortedAscending => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EntryTableCopyWith<EntryTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryTableCopyWith<$Res> {
  factory $EntryTableCopyWith(
          EntryTable value, $Res Function(EntryTable) then) =
      _$EntryTableCopyWithImpl<$Res, EntryTable>;
  @useResult
  $Res call(
      {List<EntryModel> entries, String sortColumn, bool isSortedAscending});
}

/// @nodoc
class _$EntryTableCopyWithImpl<$Res, $Val extends EntryTable>
    implements $EntryTableCopyWith<$Res> {
  _$EntryTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? sortColumn = null,
    Object? isSortedAscending = null,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<EntryModel>,
      sortColumn: null == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String,
      isSortedAscending: null == isSortedAscending
          ? _value.isSortedAscending
          : isSortedAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EntryTableCopyWith<$Res>
    implements $EntryTableCopyWith<$Res> {
  factory _$$_EntryTableCopyWith(
          _$_EntryTable value, $Res Function(_$_EntryTable) then) =
      __$$_EntryTableCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EntryModel> entries, String sortColumn, bool isSortedAscending});
}

/// @nodoc
class __$$_EntryTableCopyWithImpl<$Res>
    extends _$EntryTableCopyWithImpl<$Res, _$_EntryTable>
    implements _$$_EntryTableCopyWith<$Res> {
  __$$_EntryTableCopyWithImpl(
      _$_EntryTable _value, $Res Function(_$_EntryTable) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? sortColumn = null,
    Object? isSortedAscending = null,
  }) {
    return _then(_$_EntryTable(
      null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<EntryModel>,
      null == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String,
      null == isSortedAscending
          ? _value.isSortedAscending
          : isSortedAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EntryTable implements _EntryTable {
  const _$_EntryTable(
      final List<EntryModel> entries, this.sortColumn, this.isSortedAscending)
      : _entries = entries;

  final List<EntryModel> _entries;
  @override
  List<EntryModel> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final String sortColumn;
  @override
  final bool isSortedAscending;

  @override
  String toString() {
    return 'EntryTable(entries: $entries, sortColumn: $sortColumn, isSortedAscending: $isSortedAscending)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EntryTable &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.isSortedAscending, isSortedAscending) ||
                other.isSortedAscending == isSortedAscending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      sortColumn,
      isSortedAscending);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EntryTableCopyWith<_$_EntryTable> get copyWith =>
      __$$_EntryTableCopyWithImpl<_$_EntryTable>(this, _$identity);
}

abstract class _EntryTable implements EntryTable {
  const factory _EntryTable(final List<EntryModel> entries,
      final String sortColumn, final bool isSortedAscending) = _$_EntryTable;

  @override
  List<EntryModel> get entries;
  @override
  String get sortColumn;
  @override
  bool get isSortedAscending;
  @override
  @JsonKey(ignore: true)
  _$$_EntryTableCopyWith<_$_EntryTable> get copyWith =>
      throw _privateConstructorUsedError;
}
