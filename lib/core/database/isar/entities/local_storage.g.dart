// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalStorageCollection on Isar {
  IsarCollection<LocalStorage> get localStorages => this.collection();
}

const LocalStorageSchema = CollectionSchema(
  name: r'LocalStorage',
  id: -2379085526934909078,
  properties: {
    r'accessToken': PropertySchema(
      id: 0,
      name: r'accessToken',
      type: IsarType.string,
    ),
    r'confirmCheckIn': PropertySchema(
      id: 1,
      name: r'confirmCheckIn',
      type: IsarType.bool,
    ),
    r'darkTheme': PropertySchema(
      id: 2,
      name: r'darkTheme',
      type: IsarType.bool,
    ),
    r'deviceHash': PropertySchema(
      id: 3,
      name: r'deviceHash',
      type: IsarType.string,
    ),
    r'isActivated': PropertySchema(
      id: 4,
      name: r'isActivated',
      type: IsarType.bool,
    ),
    r'isDevMode': PropertySchema(
      id: 5,
      name: r'isDevMode',
      type: IsarType.bool,
    ),
    r'isEnableNotification': PropertySchema(
      id: 6,
      name: r'isEnableNotification',
      type: IsarType.bool,
    ),
    r'isFirstTime': PropertySchema(
      id: 7,
      name: r'isFirstTime',
      type: IsarType.bool,
    ),
    r'isRememberMe': PropertySchema(
      id: 8,
      name: r'isRememberMe',
      type: IsarType.string,
    ),
    r'language': PropertySchema(
      id: 9,
      name: r'language',
      type: IsarType.string,
    ),
    r'organizationId': PropertySchema(
      id: 10,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'refreshToken': PropertySchema(
      id: 11,
      name: r'refreshToken',
      type: IsarType.string,
    ),
    r'theme': PropertySchema(
      id: 12,
      name: r'theme',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 13,
      name: r'userId',
      type: IsarType.string,
    ),
    r'userRole': PropertySchema(
      id: 14,
      name: r'userRole',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 15,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _localStorageEstimateSize,
  serialize: _localStorageSerialize,
  deserialize: _localStorageDeserialize,
  deserializeProp: _localStorageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localStorageGetId,
  getLinks: _localStorageGetLinks,
  attach: _localStorageAttach,
  version: '3.1.0+1',
);

int _localStorageEstimateSize(
  LocalStorage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accessToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.isRememberMe;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.language;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.organizationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.refreshToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.theme;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userRole;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localStorageSerialize(
  LocalStorage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessToken);
  writer.writeBool(offsets[1], object.confirmCheckIn);
  writer.writeBool(offsets[2], object.darkTheme);
  writer.writeString(offsets[3], object.deviceHash);
  writer.writeBool(offsets[4], object.isActivated);
  writer.writeBool(offsets[5], object.isDevMode);
  writer.writeBool(offsets[6], object.isEnableNotification);
  writer.writeBool(offsets[7], object.isFirstTime);
  writer.writeString(offsets[8], object.isRememberMe);
  writer.writeString(offsets[9], object.language);
  writer.writeString(offsets[10], object.organizationId);
  writer.writeString(offsets[11], object.refreshToken);
  writer.writeString(offsets[12], object.theme);
  writer.writeString(offsets[13], object.userId);
  writer.writeString(offsets[14], object.userRole);
  writer.writeString(offsets[15], object.username);
}

LocalStorage _localStorageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalStorage();
  object.accessToken = reader.readStringOrNull(offsets[0]);
  object.confirmCheckIn = reader.readBoolOrNull(offsets[1]);
  object.darkTheme = reader.readBoolOrNull(offsets[2]);
  object.deviceHash = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.isActivated = reader.readBoolOrNull(offsets[4]);
  object.isDevMode = reader.readBoolOrNull(offsets[5]);
  object.isEnableNotification = reader.readBoolOrNull(offsets[6]);
  object.isFirstTime = reader.readBoolOrNull(offsets[7]);
  object.isRememberMe = reader.readStringOrNull(offsets[8]);
  object.language = reader.readStringOrNull(offsets[9]);
  object.organizationId = reader.readStringOrNull(offsets[10]);
  object.refreshToken = reader.readStringOrNull(offsets[11]);
  object.theme = reader.readStringOrNull(offsets[12]);
  object.userId = reader.readStringOrNull(offsets[13]);
  object.userRole = reader.readStringOrNull(offsets[14]);
  object.username = reader.readStringOrNull(offsets[15]);
  return object;
}

P _localStorageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localStorageGetId(LocalStorage object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _localStorageGetLinks(LocalStorage object) {
  return [];
}

void _localStorageAttach(
    IsarCollection<dynamic> col, Id id, LocalStorage object) {
  object.id = id;
}

extension LocalStorageQueryWhereSort
    on QueryBuilder<LocalStorage, LocalStorage, QWhere> {
  QueryBuilder<LocalStorage, LocalStorage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalStorageQueryWhere
    on QueryBuilder<LocalStorage, LocalStorage, QWhereClause> {
  QueryBuilder<LocalStorage, LocalStorage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalStorageQueryFilter
    on QueryBuilder<LocalStorage, LocalStorage, QFilterCondition> {
  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accessToken',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accessToken',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accessToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accessToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessToken',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      accessTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accessToken',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      confirmCheckInIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'confirmCheckIn',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      confirmCheckInIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'confirmCheckIn',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      confirmCheckInEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confirmCheckIn',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      darkThemeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'darkTheme',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      darkThemeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'darkTheme',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      darkThemeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkTheme',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceHash',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceHash',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceHash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      deviceHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceHash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isActivatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isActivated',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isActivatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isActivated',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isActivatedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActivated',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isDevModeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDevMode',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isDevModeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDevMode',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isDevModeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDevMode',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isEnableNotificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEnableNotification',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isEnableNotificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEnableNotification',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isEnableNotificationEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEnableNotification',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isFirstTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFirstTime',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isFirstTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFirstTime',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isFirstTimeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFirstTime',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isRememberMe',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isRememberMe',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isRememberMe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isRememberMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isRememberMe',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRememberMe',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      isRememberMeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isRememberMe',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'language',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'language',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'language',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'language',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'refreshToken',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'refreshToken',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refreshToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'refreshToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refreshToken',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      refreshTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'refreshToken',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'theme',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'theme',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> themeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'theme',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      themeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'theme',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userRole',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userRole',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userRole',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userRole',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRole',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      userRoleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userRole',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension LocalStorageQueryObject
    on QueryBuilder<LocalStorage, LocalStorage, QFilterCondition> {}

extension LocalStorageQueryLinks
    on QueryBuilder<LocalStorage, LocalStorage, QFilterCondition> {}

extension LocalStorageQuerySortBy
    on QueryBuilder<LocalStorage, LocalStorage, QSortBy> {
  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByConfirmCheckIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmCheckIn', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByConfirmCheckInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmCheckIn', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkTheme', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkTheme', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByDeviceHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceHash', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByDeviceHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceHash', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByIsActivated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActivated', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByIsActivatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActivated', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByIsDevMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDevMode', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByIsDevModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDevMode', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByIsEnableNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnableNotification', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByIsEnableNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnableNotification', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByIsFirstTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFirstTime', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByIsFirstTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFirstTime', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByIsRememberMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRememberMe', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByIsRememberMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRememberMe', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      sortByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUserRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRole', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUserRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRole', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension LocalStorageQuerySortThenBy
    on QueryBuilder<LocalStorage, LocalStorage, QSortThenBy> {
  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByConfirmCheckIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmCheckIn', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByConfirmCheckInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmCheckIn', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkTheme', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkTheme', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByDeviceHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceHash', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByDeviceHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceHash', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIsActivated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActivated', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByIsActivatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActivated', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIsDevMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDevMode', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIsDevModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDevMode', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByIsEnableNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnableNotification', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByIsEnableNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnableNotification', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIsFirstTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFirstTime', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByIsFirstTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFirstTime', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByIsRememberMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRememberMe', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByIsRememberMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRememberMe', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy>
      thenByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUserRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRole', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUserRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRole', Sort.desc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension LocalStorageQueryWhereDistinct
    on QueryBuilder<LocalStorage, LocalStorage, QDistinct> {
  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByAccessToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accessToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct>
      distinctByConfirmCheckIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confirmCheckIn');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'darkTheme');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByDeviceHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByIsActivated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActivated');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByIsDevMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDevMode');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct>
      distinctByIsEnableNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEnableNotification');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByIsFirstTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFirstTime');
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByIsRememberMe(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRememberMe', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByOrganizationId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByRefreshToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refreshToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByTheme(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByUserRole(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userRole', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalStorage, LocalStorage, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension LocalStorageQueryProperty
    on QueryBuilder<LocalStorage, LocalStorage, QQueryProperty> {
  QueryBuilder<LocalStorage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accessToken');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations> confirmCheckInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confirmCheckIn');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations> darkThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'darkTheme');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> deviceHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceHash');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations> isActivatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActivated');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations> isDevModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDevMode');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations>
      isEnableNotificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEnableNotification');
    });
  }

  QueryBuilder<LocalStorage, bool?, QQueryOperations> isFirstTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFirstTime');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> isRememberMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRememberMe');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refreshToken');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> userRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userRole');
    });
  }

  QueryBuilder<LocalStorage, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
