// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stok_barang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StokBarangModel _$StokBarangModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'nama_barang',
      'kategori_id',
      'stok',
      'kelompok_barang',
      'harga'
    ],
  );
  return _StokBarangModel()
    ..id = (json['id'] as num?)?.toInt() ?? 0
    ..nama = json['nama_barang'] as String? ?? ''
    ..kategoriId = (json['kategori_id'] as num?)?.toInt() ?? 0
    ..stok = (json['stok'] as num?)?.toInt() ?? 0
    ..kelompok = json['kelompok_barang'] as String? ?? ''
    ..harga = (json['harga'] as num?)?.toDouble() ?? 0;
}

Map<String, dynamic> _$StokBarangModelToJson(_StokBarangModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama_barang': instance.nama,
      'kategori_id': instance.kategoriId,
      'stok': instance.stok,
      'kelompok_barang': instance.kelompok,
      'harga': instance.harga,
    };
