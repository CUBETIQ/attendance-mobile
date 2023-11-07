// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLanguagesCollection on Isar {
  IsarCollection<Languages> get languages => this.collection();
}

const LanguagesSchema = CollectionSchema(
  name: r'Languages',
  id: -1188574120358875103,
  properties: {
    r'enUS': PropertySchema(
      id: 0,
      name: r'enUS',
      type: IsarType.string,
    ),
    r'kmKH': PropertySchema(
      id: 1,
      name: r'kmKH',
      type: IsarType.string,
    )
  },
  estimateSize: _languagesEstimateSize,
  serialize: _languagesSerialize,
  deserialize: _languagesDeserialize,
  deserializeProp: _languagesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _languagesGetId,
  getLinks: _languagesGetLinks,
  attach: _languagesAttach,
  version: '3.1.0+1',
);

int _languagesEstimateSize(
  Languages object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.enUS;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kmKH;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _languagesSerialize(
  Languages object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.enUS);
  writer.writeString(offsets[1], object.kmKH);
}

Languages _languagesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Languages();
  object.enUS = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.kmKH = reader.readStringOrNull(offsets[1]);
  return object;
}

P _languagesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _languagesGetId(Languages object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _languagesGetLinks(Languages object) {
  return [];
}

void _languagesAttach(IsarCollection<dynamic> col, Id id, Languages object) {
  object.id = id;
}

extension LanguagesQueryWhereSort
    on QueryBuilder<Languages, Languages, QWhere> {
  QueryBuilder<Languages, Languages, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LanguagesQueryWhere
    on QueryBuilder<Languages, Languages, QWhereClause> {
  QueryBuilder<Languages, Languages, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Languages, Languages, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Languages, Languages, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Languages, Languages, QAfterWhereClause> idBetween(
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

extension LanguagesQueryFilter
    on QueryBuilder<Languages, Languages, QFilterCondition> {
  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enUS',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enUS',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'enUS',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'enUS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'enUS',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enUS',
        value: '',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> enUSIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'enUS',
        value: '',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Languages, Languages, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kmKH',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kmKH',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kmKH',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kmKH',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kmKH',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kmKH',
        value: '',
      ));
    });
  }

  QueryBuilder<Languages, Languages, QAfterFilterCondition> kmKHIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kmKH',
        value: '',
      ));
    });
  }
}

extension LanguagesQueryObject
    on QueryBuilder<Languages, Languages, QFilterCondition> {}

extension LanguagesQueryLinks
    on QueryBuilder<Languages, Languages, QFilterCondition> {}

extension LanguagesQuerySortBy on QueryBuilder<Languages, Languages, QSortBy> {
  QueryBuilder<Languages, Languages, QAfterSortBy> sortByEnUS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enUS', Sort.asc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> sortByEnUSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enUS', Sort.desc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> sortByKmKH() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kmKH', Sort.asc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> sortByKmKHDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kmKH', Sort.desc);
    });
  }
}

extension LanguagesQuerySortThenBy
    on QueryBuilder<Languages, Languages, QSortThenBy> {
  QueryBuilder<Languages, Languages, QAfterSortBy> thenByEnUS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enUS', Sort.asc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> thenByEnUSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enUS', Sort.desc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> thenByKmKH() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kmKH', Sort.asc);
    });
  }

  QueryBuilder<Languages, Languages, QAfterSortBy> thenByKmKHDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kmKH', Sort.desc);
    });
  }
}

extension LanguagesQueryWhereDistinct
    on QueryBuilder<Languages, Languages, QDistinct> {
  QueryBuilder<Languages, Languages, QDistinct> distinctByEnUS(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enUS', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Languages, Languages, QDistinct> distinctByKmKH(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kmKH', caseSensitive: caseSensitive);
    });
  }
}

extension LanguagesQueryProperty
    on QueryBuilder<Languages, Languages, QQueryProperty> {
  QueryBuilder<Languages, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Languages, String?, QQueryOperations> enUSProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enUS');
    });
  }

  QueryBuilder<Languages, String?, QQueryOperations> kmKHProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kmKH');
    });
  }
}
