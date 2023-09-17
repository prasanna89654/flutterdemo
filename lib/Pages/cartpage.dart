import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdemo/model.dart';
import 'package:flutterdemo/repos.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  FormGroup cartGroup(List<CartModel> data) {
    return FormGroup({
      'total': FormControl<int>(
          value: 0,),
      'books': FormArray([for (final qualif in data) bookGroup(qualif)]),
    });
  }

  FormGroup bookGroup(CartModel data) {
    return FormGroup({
      'bookId': FormControl<String>(value: data.bookId),
      'quantity': FormControl<int>(value: 1),
      'price': FormControl<int>(
        value: data.book!.price,
      ),
      'publisherId': FormControl<String>(value: data.publisherId),
      'isChecked': FormControl<bool>(value: false),
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
        backgroundColor: const Color.fromARGB(255, 165, 182, 190),
      ),
      body: details.when(
        data: (data) {
          return ReactiveFormBuilder(
              form: () => cartGroup(data),
              builder: (context, formGroup, child) {
                getTotal() {
                  formGroup.control('total').value = formGroup
                      .control('books')
                      .value
                      .fold(
                          0,
                          (dynamic prev, dynamic product) =>
                              prev + product['price']);
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print(formGroup.value);
                          },
                          child: const Text("Check")),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ReactiveCheckbox(
                                  formControlName:
                                      'books.$index.isChecked',
                                    onChanged: (control) {
                                      formGroup
                                          .control(
                                              'books.$index.isChecked')
                                          .value = control.value;

                                      if (control.value!) {
                                        formGroup.control('total').value =
                                            formGroup
                                                .control('total')
                                                .value +
                                            formGroup
                                                .control(
                                                    'books.$index.price')
                                                .value;
                                      } else {
                                        formGroup.control('total').value =
                                            formGroup
                                                .control('total')
                                                .value -
                                            formGroup
                                                .control(
                                                    'books.$index.price')
                                                .value;
                                      }
                                    },

                                ),
                                Text(data[index].book!.title.toString()),
                                const Spacer(),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          child: IconButton(
                                              onPressed: () {
                                                formGroup
                                                    .control(
                                                        'books.$index.quantity')
                                                    .value++;
                          
                                                final value = data[index]
                                                        .book!
                                                        .price! *
                                                    formGroup
                                                        .control(
                                                            'books.$index.quantity')
                                                        .value;
                          
                                                formGroup
                                                    .control(
                                                        'books.$index.price')
                                                    .value = value;
                                              if(formGroup.control('books.$index.isChecked').value) {
                                                getTotal();
                                              }
                                              },
                                              icon: const Icon(Icons.add)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        ReactiveValueListenableBuilder(
                                          builder:
                                              (context, controller, child) {
                                            return Text(
                                                controller.value.toString());
                                          },
                                          formControlName:
                                              'books.$index.quantity',
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Card(
                                          child: IconButton(
                                              onPressed: () {
                                                formGroup
                                                            .control(
                                                                'books.$index.quantity')
                                                            .value-- <=
                                                        1
                                                    ? formGroup
                                                        .control(
                                                            'books.$index.quantity')
                                                        .value = 1
                                                    : null;
                          
                                                final value = data[index]
                                                        .book!
                                                        .price! *
                                                    formGroup
                                                        .control(
                                                            'books.$index.quantity')
                                                        .value;
                          
                                                formGroup
                                                    .control(
                                                        'books.$index.price')
                                                    .value = value;
                          
                                               if(formGroup.control('books.$index.isChecked').value) {
                                                getTotal();
                                              }
                                              },
                                              icon: const Icon(Icons.remove)),
                                        ),
                                      ],
                                    ),
                                    ReactiveValueListenableBuilder(
                                      builder: (context, controller, child) {
                                        return Text(
                                            "Rs: ${controller.value.toString()}");
                                      },
                                      formControlName: 'books.$index.price',
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ));
                        },
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("Total Amount"),
                              const Spacer(),
                              ReactiveValueListenableBuilder(
                                builder: (context, controller, child) {
                                  return Text(controller.value.toString());
                                },
                                formControlName: 'total',
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  final newGroup = {
                                    "total": formGroup.control('total').value,
                                    "books": formGroup
                                        .control('books')
                                        .value
                                        .where((element) =>
                                            element['isChecked'] == true)
                                        .toList()
                                  };

                         
                                  ref
                                      .read(cartRepoProvider)
                                      .postOrder(newGroup)
                                      .then((value) {
                                    if (value == 200) {
                                      Navigator.pop(context);
                                      
                                    }
                                  });
                                },
                                child: const Text("Place Order")),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        error: (Object error, StackTrace stackTrace) {
          return null;
        },
        loading: () {
          return null;
        },
      ),
    );
  }
}
