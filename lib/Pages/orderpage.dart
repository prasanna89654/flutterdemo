import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdemo/repos.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final details = ref.watch(orderProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Page'),
          backgroundColor: const Color.fromARGB(255, 165, 182, 190),
        ),
        body: details.when(
          data: (data) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 30,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order ID: ${data[index].id}"),
                  Text("User Name: ${data[index].user!.name}"),
                  Text("Order Date: ${data[index].createdAt}"),
                  Text("Total: ${data[index].total}"),
                  Text(" ${data[index].status}"),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data[index].orderItem!.length,
                    itemBuilder: (context, dindex) {
                      return Card(
                        child: ListTile(
                          horizontalTitleGap: 0,
                          title: Text(
                              " ${data[index].orderItem![dindex].book!.title.toString()}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Price : ${data[index].orderItem![dindex].price.toString()}"),
                              Text(
                                  "Quantity :${data[index].orderItem![dindex].quantity.toString()}"),
                            ],
                          ),
                          trailing: Text(
                              data[index].orderItem![dindex].status.toString()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          error: (Object error, StackTrace stackTrace) {
            return null;
          },
          loading: () {
            return null;
          },
        ));
  }
}
