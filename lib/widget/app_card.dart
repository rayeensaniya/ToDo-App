import 'package:flutter/material.dart';
import 'package:todo_app/bloc/dashboard_bloc.dart';
import 'package:todo_app/widget/button.dart';

class AppCard extends StatefulWidget {
  const AppCard({Key? key,required this.dashboardBloc}) : super(key: key);
final DashboardBloc dashboardBloc;
  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                widget.dashboardBloc.isHideFab.add(true);
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Title'),
                            IconButton(onPressed: () {
                              widget.dashboardBloc.isHideFab.add(false);
                              Navigator.pop(context);
                            }, icon: const Icon(Icons.cancel_outlined))
                          ],
                        ),
                        const Text('Description in flutter is a material design widget. It is always used in the Stateful Widget as it does not maintain a state of its own. We can use its onChanged property to interact or modify other widgets in the flutter app. Like most of the other flutter widgets, it also comes with many properties like activeColor, checkColor, mouseCursor, etc, to let developers have ',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          TextButton(onPressed: () {

                          }, child: const Text('Completed',style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),)),
                            TextButton(onPressed: () {

                            }, child: const Text('Delete',style: TextStyle(color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),))
                          ],
                        )
                      ],
                    ),
                  )
                );
              },
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title'),
                              SizedBox(height: 10),
                              Text(
                                'Description in flutter is a material design widget. It is always used in the Stateful Widget as it does not maintain a state of its own. We can use its onChanged property to interact or modify other widgets in the flutter app. Like most of the other flutter widgets, it also comes with many properties like activeColor, checkColor, mouseCursor, etc, to let developers have ',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            StreamBuilder<bool>(
                                initialData: false,
                                stream: widget.dashboardBloc.isChecked,
                                builder: (context, snapshot) {
                                  return Checkbox(
                                    value: snapshot.data,
                                    onChanged: (value) {
                                      widget.dashboardBloc.isChecked.add(value!);
                                    },
                                  );
                                }),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text('Status : Pending'),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Due Date : 10 November 2023'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
          );
        },
        itemCount: 10);
  }
}
