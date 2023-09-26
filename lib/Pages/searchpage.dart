import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdemo/repos.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchpageState();
}

class _SearchpageState extends ConsumerState<SearchPage> {
  dynamic titlevalue;
  @override
  Widget build(BuildContext context) {
    final searchdata = ref.watch(
        searchProvider(titlevalue.toString().isEmpty ? null : titlevalue));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        backgroundColor: const Color.fromARGB(255, 165, 182, 190),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  titlevalue = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            const SizedBox(
              height: 10,
            ),
            searchdata.when(
              data: (data) => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Text(data[index].title!);
                  },
                ),
              ),
              error: (Object error, StackTrace stackTrace) {
                return const Center();
              },
              loading: () {
                return const Center();
              },
            ),
          ],
        ),
      ),
    );
  }
}
