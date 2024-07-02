// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stok_barang_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class StokBarangModel extends _StokBarangModel
    with RealmEntity, RealmObjectBase, RealmObject {
  StokBarangModel(
    int id,
    String nama,
    int kategoriId,
    int stok,
    String kelompok,
    double harga,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'nama', nama);
    RealmObjectBase.set(this, 'kategoriId', kategoriId);
    RealmObjectBase.set(this, 'stok', stok);
    RealmObjectBase.set(this, 'kelompok', kelompok);
    RealmObjectBase.set(this, 'harga', harga);
  }

  StokBarangModel._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get nama => RealmObjectBase.get<String>(this, 'nama') as String;
  @override
  set nama(String value) => RealmObjectBase.set(this, 'nama', value);

  @override
  int get kategoriId => RealmObjectBase.get<int>(this, 'kategoriId') as int;
  @override
  set kategoriId(int value) => RealmObjectBase.set(this, 'kategoriId', value);

  @override
  int get stok => RealmObjectBase.get<int>(this, 'stok') as int;
  @override
  set stok(int value) => RealmObjectBase.set(this, 'stok', value);

  @override
  String get kelompok =>
      RealmObjectBase.get<String>(this, 'kelompok') as String;
  @override
  set kelompok(String value) => RealmObjectBase.set(this, 'kelompok', value);

  @override
  double get harga => RealmObjectBase.get<double>(this, 'harga') as double;
  @override
  set harga(double value) => RealmObjectBase.set(this, 'harga', value);

  @override
  Stream<RealmObjectChanges<StokBarangModel>> get changes =>
      RealmObjectBase.getChanges<StokBarangModel>(this);

  @override
  Stream<RealmObjectChanges<StokBarangModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<StokBarangModel>(this, keyPaths);

  @override
  StokBarangModel freeze() =>
      RealmObjectBase.freezeObject<StokBarangModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'nama': nama.toEJson(),
      'kategoriId': kategoriId.toEJson(),
      'stok': stok.toEJson(),
      'kelompok': kelompok.toEJson(),
      'harga': harga.toEJson(),
    };
  }

  static EJsonValue _toEJson(StokBarangModel value) => value.toEJson();
  static StokBarangModel _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'nama': EJsonValue nama,
        'kategoriId': EJsonValue kategoriId,
        'stok': EJsonValue stok,
        'kelompok': EJsonValue kelompok,
        'harga': EJsonValue harga,
      } =>
        StokBarangModel(
          fromEJson(id),
          fromEJson(nama),
          fromEJson(kategoriId),
          fromEJson(stok),
          fromEJson(kelompok),
          fromEJson(harga),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(StokBarangModel._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, StokBarangModel, 'StokBarangModel', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('nama', RealmPropertyType.string),
      SchemaProperty('kategoriId', RealmPropertyType.int),
      SchemaProperty('stok', RealmPropertyType.int),
      SchemaProperty('kelompok', RealmPropertyType.string),
      SchemaProperty('harga', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
