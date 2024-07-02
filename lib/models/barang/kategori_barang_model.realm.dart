// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_barang_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class KategoriBarangModel extends _KategoriBarangModel
    with RealmEntity, RealmObjectBase, RealmObject {
  KategoriBarangModel(
    int id,
    String nama,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'nama', nama);
  }

  KategoriBarangModel._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get nama => RealmObjectBase.get<String>(this, 'nama') as String;
  @override
  set nama(String value) => RealmObjectBase.set(this, 'nama', value);

  @override
  Stream<RealmObjectChanges<KategoriBarangModel>> get changes =>
      RealmObjectBase.getChanges<KategoriBarangModel>(this);

  @override
  Stream<RealmObjectChanges<KategoriBarangModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<KategoriBarangModel>(this, keyPaths);

  @override
  KategoriBarangModel freeze() =>
      RealmObjectBase.freezeObject<KategoriBarangModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'nama': nama.toEJson(),
    };
  }

  static EJsonValue _toEJson(KategoriBarangModel value) => value.toEJson();
  static KategoriBarangModel _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'nama': EJsonValue nama,
      } =>
        KategoriBarangModel(
          fromEJson(id),
          fromEJson(nama),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(KategoriBarangModel._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, KategoriBarangModel, 'KategoriBarangModel', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('nama', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
