import 'package:realm/realm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stok_barang_model.realm.dart';
part 'stok_barang_model.g.dart';
part 'stok_barang_model.ext.dart';

@RealmModel()
@JsonSerializable(explicitToJson: true)
class _StokBarangModel {
  @PrimaryKey()
  @JsonKey(required: true, defaultValue: 0, name: "id")
  late int id;
  @JsonKey(required: true, defaultValue: "", name: "nama_barang")
  late String nama;
  @JsonKey(required: true, defaultValue: 0, name: "kategori_id")
  late int kategoriId;
  @JsonKey(required: true, defaultValue: 0, name: "stok")
  late int stok;
  @JsonKey(required: true, defaultValue: "", name: "kelompok_barang")
  late String kelompok;
  @JsonKey(required: true, defaultValue: 0, name: "harga")
  late double harga;
}
