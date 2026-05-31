import 'dart:typed_data';
import 'package:logger/logger.dart';
import '../app/app.logger.dart';

class WalrusService {
  final Logger _logger = getLogger('WalrusService');

  Future<String> uploadBlob(Uint8List data) async {
    _logger.i('Uploading blob to Walrus (${data.lengthInBytes} bytes)');
    throw UnimplementedError();
  }

  Future<Uint8List> fetchBlob(String blobId) async {
    _logger.i('Fetching Walrus blob $blobId');
    throw UnimplementedError();
  }
}
