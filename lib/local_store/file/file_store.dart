import 'dart:convert';
import 'dart:io';
import 'package:basic_frame/util/logger/logger_util.dart';
typedef DataBack<T> = Function(T value);
class FileStoreUtil {
  FileStoreUtil._internal();

  factory FileStoreUtil() => _instance;

  static final FileStoreUtil _instance = FileStoreUtil._internal();

  ///获取目标文件
  Future<File> _localFile(String filePath) async {
    return File(filePath);
  }

  ///向文件写入bytes数据
  void writeBytesSync(
      {required String filePath, required List<int> bytes}) async {
    try {
      final file = await _localFile(filePath);
      file.writeAsBytesSync(bytes, flush: true, mode: FileMode.append);
    } catch (e) {
      rethrow;
    }
  }

  ///向文件写入bytes数据
  Future<File> writeBytes(
      {required String filePath, required List<int> bytes}) async {
    try {
      final file = await _localFile(filePath);
      return file.writeAsBytes(bytes, flush: true, mode: FileMode.append);
    } catch (e) {
      rethrow;
    }
  }

  ///向文件写入string数据
  void writeStringSync(
      {required String filePath, required String contents}) async {
    try {
      final file = await _localFile(filePath);
      file.writeAsStringSync(contents, flush: true, mode: FileMode.append);
    } catch (e) {
      rethrow;
    }
  }

  ///按行向文件写入string数据
  Future<dynamic> writeLineString(
      {required String filePath, required String contents}) async {
    try {
      final file = await _localFile(filePath);
      final sink = file.openWrite(mode: FileMode.append);
      sink.writeln(contents);
      return sink.close();
    } catch (e) {
      rethrow;
    }
  }

  ///读取byte数据
  void readBytes({required String filePath, int? count}) async {
    try {
      final file = await _localFile(filePath);
      final raf = await file.open();
      count ??= 3;
      while (await read(raf, count)) {}
    } catch (e) {
      rethrow;
    }
  }

  ///读取一定数量的数据，返回是否到文件末尾
  ///false：表示已读取到末尾
  Future<bool> read(RandomAccessFile raf, int count) async {
    try {
      await raf.read(count);
      return raf.positionSync() < raf.lengthSync();
    } catch (e) {
      rethrow;
    }
  }

  ///按行读取string数据
  Stream<String> readLineString(String filePath) async* {
    RandomAccessFile? sink;
    try {
      final file = await _localFile(filePath);
      sink = await file.open();
      int b;
      var buffer = List<int>.empty(growable: true);
      while ((b = await sink.readByte()) != -1) {
        try {
          //检查当前字符是否是'\n',遇到换行符则打印字符串，释放buffer内存
          var str = utf8.decode([b]);
          if (str == '\n') {
            final line = utf8.decode(buffer.toList());
            yield line;
            buffer.clear();
            continue;
          }
          // ignore: empty_catches
        } catch (e) {}
        //当前byte添加到缓存
        buffer.add(b);
      }
      //最后一行文本输出
      final line = utf8.decode(buffer.toList());
      yield line;
      buffer.clear();
    } catch (e) {
      rethrow;
    } finally {
      sink?.close();
    }
  }

  ///用于测试
  void test() async {
    try {
      await writeLineString(filePath: 'test.txt', contents: '测试测试，，,,,');
      readLineString('test.txt');
    } catch(e) {
      LoggerUtil().e(e);
    }
  }
}
