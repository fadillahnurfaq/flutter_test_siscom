import 'package:fadillahnurfaqih_front_end/models/dropdown/select_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'kategori_barang_model.realm.dart';
part 'kategori_barang_model.g.dart';
part 'kategori_barang_model.ext.dart';

@RealmModel()
@JsonSerializable(explicitToJson: true)
class _KategoriBarangModel {
  @PrimaryKey()
  @JsonKey(required: true, defaultValue: 0, name: "id")
  late int id;
  @JsonKey(required: true, defaultValue: "", name: "nama_kategori")
  late String nama;
}
