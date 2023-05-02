import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

const String localizationPath = 'package/module_codegen';

class Generator {
  static const _kOutput = 'env_variables.g.dart';
  final _prologue = """
  //DO NOT EDIT. THIS is code generated via code generator

class EnviromentVariables{
  """;

  final _epilogue = "  }";

  String _getProperty(String value, String propertyName) => """
  String get $propertyName => "$value";
  """;

  void run({required int varNumber}) {
    print("Generation is started");


    final outPutFile = path.join(Directory.current.path, 'lib/$_kOutput');

    final output = StringBuffer();

    output.write(_prologue);

    for (final entry in Platform.environment.entries.take(varNumber)) {
      output.writeln(_getProperty(entry.value, entry.key.toLowerCase()));
    }

    output.writeln(_epilogue);

    final formattedCode = DartFormatter().format(output.toString());
    File(outPutFile).writeAsStringSync(formattedCode);

    print("Generation is Finished");
  }
}
