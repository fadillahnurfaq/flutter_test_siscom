import 'package:fadillahnurfaqih_front_end/models/barang/kategori_barang_model.dart';
import 'package:fadillahnurfaqih_front_end/models/barang/stok_barang_model.dart';
import 'package:realm/realm.dart';

import '../utils/realm_connector.dart';

class BarangService {
  static final RealmConnector _connector = RealmConnector();
  static Future<StokBarangModel?> saveStokBarang({
    required final String nama,
    required final int kategoriId,
    required final int stok,
    required final String kelompok,
    required final double harga,
  }) async {
    StokBarangModel? result;
    try {
      await _connector.open().then((realm) {
        int nextId = 0;
        RealmResults<StokBarangModel> results =
            realm.query<StokBarangModel>('TRUEPREDICATE SORT(id DESC)');
        if (results.isNotEmpty) {
          final int lastId = results.first.id;
          nextId = lastId + 1;
        } else {
          nextId = 1;
        }
        realm.write(() {
          result = realm.add(
            StokBarangModel(
              nextId,
              nama,
              kategoriId,
              stok,
              kelompok,
              harga,
            ),
          );
        });
      });
      return result;
    } catch (e) {
      return Future.error("Gagal simpan data stok barang, Error : $e");
    }
  }

  static Future<StokBarangModel?> editStokBarang({
    required final StokBarangModel data,
  }) async {
    StokBarangModel? result;
    try {
      await _connector.open().then((realm) {
        realm.write(() {
          result = realm.add(
            data,
            update: true,
          );
        });
      });
      return result;
    } catch (e) {
      return Future.error("Gagal edit data stok barang, Error : $e");
    }
  }

  static Future<List<StokBarangModel>> getAllStokBarang(
      {final String? keyword}) async {
    List<StokBarangModel> results = [];
    try {
      await _connector.open().then((realm) {
        String filter = "";
        if (keyword?.isNotEmpty == true) {
          filter = r"nama CONTAINS[c] $0";
        }
        if (filter == "") filter = "TRUEPREDICATE";
        filter += " SORT(id DESC)";
        results.addAll(realm.query<StokBarangModel>(filter, [keyword]));
      });
      return results;
    } catch (e) {
      return Future.error("Gagal mendapatkan data stok barang, Error : $e");
    }
  }

  static Future<List<StokBarangModel>> deleteBulkStokBarang(
      {required final List<StokBarangModel> datas}) async {
    List<StokBarangModel> results = [];
    try {
      await _connector.open().then((realm) {
        realm.write(() {
          realm.deleteMany<StokBarangModel>(datas);
        });
        results = datas;
      });
      return results;
    } catch (e) {
      return Future.error("Gagal menghapus data stok barang, Error : $e");
    }
  }

  static Future<bool> deleteStokBarang(
      {required final StokBarangModel data}) async {
    try {
      return await _connector.open().then((realm) {
        final StokBarangModel? getData = realm.find<StokBarangModel>(data.id);
        if (getData != null) {
          realm.write(() {
            realm.delete<StokBarangModel>(getData);
          });
          return true;
        }
        return false;
      });
    } catch (e) {
      return Future.error("Gagal menghapus data stok barang, Error : $e");
    }
  }

  static Future<void> saveInitialKategori() async {
    await _connector.open().then((realm) {
      RealmResults<KategoriBarangModel> results =
          realm.all<KategoriBarangModel>();
      if (results.isEmpty) {
        final List<KategoriBarangModel> datas = [
          KategoriBarangModel(1, "Buku"),
          KategoriBarangModel(2, "Novel"),
          KategoriBarangModel(3, "Elektronik"),
        ];
        realm.write(() {
          realm.addAll<KategoriBarangModel>(datas, update: true);
        });
      }
    });
  }

  static Future<List<KategoriBarangModel>> getAllKategori() async {
    List<KategoriBarangModel> results = [];
    try {
      await _connector.open().then((realm) {
        results = realm.all<KategoriBarangModel>().toList();
      });
      return results;
    } catch (e) {
      return Future.error("Gagal mendapatkan data kategori barang, Error : $e");
    }
  }

  static Future<bool> deleteAllKategori() async {
    try {
      await _connector.open().then((realm) {
        realm.write(() {
          realm.deleteAll<KategoriBarangModel>();
        });
      });
      return true;
    } catch (e) {
      return Future.error(
          "Gagal menghapus semua data kategori barang, Error : $e");
    }
  }
}
