import 'package:chaquopy/chaquopy.dart';
import 'package:code_text_field/code_text_field.dart';
import "package:flutter/material.dart";
import "package:highlight/languages/dart.dart";
import "package:highlight/languages/python.dart";
import "package:flutter_highlight/themes/monokai-sublime.dart";
import "package:flutter_highlight/themes/VS.dart";
import "package:flutter_highlight/themes/Dracula.dart";
import "package:flutter_highlight/themes/atom-one-dark.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Compiler(),
  ));
}

class Compiler extends StatefulWidget {
  const Compiler({Key? key}) : super(key: key);

  @override
  State<Compiler> createState() => _CompilerState();
}

class _CompilerState extends State<Compiler> {
  CodeController? _codeController;
  Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String code = "";
  @override
  Widget build(BuildContext context) {
    final source = "print(\"Hello, World!\")";
    _codeController = CodeController(
      text: source,
      language: python,
      theme: theme,
    );
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Flutter Compiler")),
          backgroundColor: Colors.black,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                dropdownColor: Colors.black,
                elevation: 20,
                icon: Icon(Icons.color_lens_outlined),
                iconEnabledColor: Colors.white,
                items: ["Atom", "Monokai-sublime", "VS", "Dracula"]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      setState(() {
                        if (value == "Monokai-sublime") {
                          theme = monokaiSublimeTheme;
                        } else if (value == "Atom") {
                          theme:
                          atomOneDarkTheme;
                        } else if (value == "VS") {
                          theme:
                          vsTheme;
                        } else if (value == "Dracula") {
                          theme:
                          draculaTheme;
                        }
                      });
                    },
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CodeField(
                controller: _codeController!,
                textStyle: TextStyle(fontFamily: "SourceCode"),
              ),
            ),
            Container(
              child: Text(
                "Output: $code",
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          var here = await Chaquopy.executeCode(_codeController!.text);
          setState(() {
            code = " ";
          });
        },
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
