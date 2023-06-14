import 'package:flutter/material.dart';
import 'package:quran_app/components/retrun_basmala.dart';
import 'package:quran_app/core/local_Storage/local_storage.dart';
import 'package:quran_app/core/model/model_data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constant_app/constant.dart';

class SurahBuilder extends StatefulWidget {
  final sura;
  final arabic;
  final suraName;
  int ayah;

  SurahBuilder(
      {Key? key, this.sura, this.arabic, this.suraName, required this.ayah})
      : super(key: key);

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool view = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = true;
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.arabic[index + previousVerses]['aya_text'],
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: arabicFontSize,
              fontFamily: arabicFont,
              color: const Color.fromARGB(196, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }

  SafeArea SingleSuraBuilder(LenghtOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    DateTime currentDate = DateTime.now();

    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < LenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (index == 0)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'A   حجم الخط ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF01807E),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Slider(
                                value: mushafFontSize,
                                min: 20,
                                max: 50,
                                activeColor: const Color(0XFF01807E),
                                onChanged: (value) {
                                  setState(() {
                                    mushafFontSize = value;
                                    arabicFontSize = value;
                                  });
                                  saveSettings();
                                },
                              ),
                            ),
                          ],
                        ),
                      (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                          ? const Text('')
                          : const RetunBasmala(),
                      Container(
                        color: const Color.fromARGB(255, 253, 251, 240),
                        child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () async {
                                      addNote(
                                        bookmarkedAyah: index,
                                        bookmarkedSura: widget.sura + 1,
                                        title: widget
                                                .arabic[index + previousVerses]
                                            ["aya_text_emlaey"],
                                        createdTime: currentDate.toString(),
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.bookmark_add,
                                          color: Color(0XFF01807E),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Bookmark'),
                                      ],
                                    ),
                                  ),
                                ]),
                      ),
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: LenghtOfSura,
              )
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 && widget.sura + 1 != 9
                                ? const RetunBasmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                fullSura,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mushafFontSize,
                                  fontFamily: arabicFont,
                                  color: const Color.fromARGB(196, 44, 44, 44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Tooltip(
          message: 'Mushaf Mode',
          child: TextButton(
            child: const Icon(
              Icons.chrome_reader_mode,
              color: Color(0XFF01807E),
            ),
            onPressed: () {
              setState(() {
                view = !view;
              });
            },
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward))
        ],
        title: const Text(
          'القرأن الكريم',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0XFF01807E),
      ),
      body: SingleSuraBuilder(LengthOfSura),
    );
  }

  Future<void> addNote({
    String? title,
    String? createdTime,
    int? bookmarkedAyah,
    int? bookmarkedSura,
  }) async {
    final note = AayahModel(
      bookmarkedAyah: bookmarkedAyah,
      bookmarkedSura: bookmarkedSura,
      title: title,
      createdTime: createdTime,
    );
    await AayahDataBase.instance.create(note);
  }
}
