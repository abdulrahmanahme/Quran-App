import 'package:flutter/material.dart';
import 'package:quran_app/components/componets_widgets.dart';

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
        backgroundColor:  Colors.grey.shade300,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0XFF01807E),
          
          title: const Text('القرأن الكريم',
          style: TextStyle(
            // fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward))
          ],
          bottom:const TabBar(
            indicatorWeight: 5,
          indicatorPadding: EdgeInsets.only(left: 40,right: 40,bottom: -1),
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
           
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'You ',
                ),
              ],
            ),
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child:TextFormWidget(
                        
                          hintText: "ابحث عما تريد...." ,
                         
                          suffixIcon: Icon(Icons.search,color: Colors.grey.shade800,size: 28,),
                          
                          onTap: () {},
                          onChanged: (value) {
                         
                           
                          },
                        ),
                      ),
                    ),
                       ProfileButton(
              icon: AssetImage('assets/quran.png'),
              name: 'الفاتحة',
              type: ':  رقم السوره2',
              name2: 'مكيه',
              type2:' : عدد اياتها 200' ,

            ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}

