// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_barang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KategoriBarangModel _$KategoriBarangModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'nama_kategori'],
  );
  return _KategoriBarangModel()
    ..id = (json['id'] as num?)?.toInt() ?? 0
    ..nama = json['nama_kategori'] as String? ?? '';
}

Map<String, dynamic> _$KategoriBarangModelToJson(
        _KategoriBarangModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama_kategori': instance.nama,
    };
