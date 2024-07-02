part of "kategori_barang_model.dart";

extension KategoriBarangModelExt on KategoriBarangModel {
  static KategoriBarangModel toRealmObject(_KategoriBarangModel x) {
    return KategoriBarangModel(
      x.id,
      x.nama,
    );
  }

  static KategoriBarangModel fromJson(Map<String, dynamic> json) =>
      toRealmObject(_$KategoriBarangModelFromJson(json));

  Map<String, dynamic> toJson() => _$KategoriBarangModelToJson(this);

  SelectDataModel asSelectData() =>
      SelectDataModel(id: id.toString(), title: nama, subTitle: "", data: this);
}
