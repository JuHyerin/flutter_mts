import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeSceren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTS'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '주요 지수',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: 140,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.all(5)),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 110,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white10,
                    ),
                  );
                },
              ),
            ),
            const Text(
              '실시간 순위',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            /*ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    children: const [
                      Text('삼성전자'),
                      Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                );
              },
            ),*/
            Column(
              children: [
                 ListTile(
                   leading: const Text('1'),
                   title: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text('삼성전자'),
                       Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                     ],
                  ),
                ),
                ListTile(
                  leading: const Text('2'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('삼성전자'),
                      Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Text('3'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('삼성전자'),
                      Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Text('4'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('삼성전자'),
                      Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Text('5'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('삼성전자'),
                      Text('005930', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('더보기 >', style: TextStyle(color: Colors.grey),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}
