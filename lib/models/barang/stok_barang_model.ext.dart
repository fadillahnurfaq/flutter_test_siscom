part of "stok_barang_model.dart";

extension StokBarangModelExt on StokBarangModel {
  static StokBarangModel toRealmObject(_StokBarangModel x) {
    return StokBarangModel(
      x.id,
      x.nama,
      x.kategoriId,
      x.stok,
      x.kelompok,
      x.harga,
    );
  }

  static StokBarangModel fromJson(Map<String, dynamic> json) =>
      toRealmObject(_$StokBarangModelFromJson(json));

  Map<String, dynamic> toJson() => _$StokBarangModelToJson(this);
}
