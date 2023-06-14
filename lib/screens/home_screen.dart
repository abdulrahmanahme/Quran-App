import 'package:flutter/material.dart';
import 'package:quran_app/components/componets_widgets.dart';
import 'package:quran_app/core/constant_app/constant.dart';
import 'package:quran_app/screens/saved_ayah.dart';
import 'package:quran_app/components/surah_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0XFF01807E),
          title: const Text(
            'القرأن الكريم',
            style: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward))
          ],
          bottom: const TabBar(
            indicatorWeight: 5,
            indicatorPadding: EdgeInsets.only(left: 40, right: 40, bottom: -1),
            indicatorColor: Colors.white,
            tabs: [
              Text(
                'المحفوظات',
              ),
              Text(
                'السور',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AyahSaved(),
            FutureBuilder(
              future: readJson(),
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    // return indexCreator(snapshot.data, context ,noOfVerses);
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormWidget(
                              hintText: "ابحث عما تريد....",
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade800,
                                size: 28,
                              ),
                              onTap: () {},
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        for (int i = 0; i < 114; i++)
                          ProfileButton(
                            icon: const AssetImage('assets/quran.png'),
                            name: arabicName[i]['name'],
                            type: ' :  رقم السوره ${arabicName[i]["surah"]}',
                            name2: '${surahTaype[i].toString()}',
                            type2: ': عدد اياتها ${noOfVerses[i].toString()}',
                            onPressed: () {
                              fabIsClicked = false;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SurahBuilder(
                                            arabic: quran[0],
                                            sura: i,
                                            suraName: arabicName[i]['name'],
                                            ayah: 0,
                                          )));
                            },
                          ),
                      ],
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
