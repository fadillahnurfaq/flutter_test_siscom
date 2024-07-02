import 'package:fadillahnurfaqih_front_end/models/barang/kategori_barang_model.dart';
import 'package:fadillahnurfaqih_front_end/models/barang/stok_barang_model.dart';
import 'package:realm/realm.dart';

class RealmConnector {
  Realm? _realm;

  Future<Realm> open() async {
    if (_realm == null) {
      final config = Configuration.local(
        [
          StokBarangModel.schema,
          KategoriBarangModel.schema,
        ],
        shouldDeleteIfMigrationNeeded: false,
        schemaVersion: 1,
        migrationCallback: (migration, oldSchemaVersion) {},
      );
      _realm = await Realm.open(config);
    }

    if (_realm == null) {
      return Future.error("Koneksi ke database gagal");
    }
    return _realm!;
  }

  close() {
    try {
      if (_realm != null) {
        if (!_realm!.isClosed) _realm!.close();
      }
    } catch (_) {}
  }
}
