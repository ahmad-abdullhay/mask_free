import 'package:flutter/material.dart';

class MyMultiSelectableDropDownListController {
  List<String> allList;
  List<String> selectedList = [];
  String hint;
  MyMultiSelectableDropDownListController({this.allList,this.hint});
}

class MyMultiSelectableDropDownList extends StatefulWidget {
  final MyMultiSelectableDropDownListController controller;
  const MyMultiSelectableDropDownList({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _MyMultiSelectableDropDownListState createState() =>
      _MyMultiSelectableDropDownListState();
}

class _MyMultiSelectableDropDownListState
    extends State<MyMultiSelectableDropDownList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton(
          isExpanded: true,
          hint: Text(widget.controller.hint),
        
          onChanged: (newValue) {
            setState(() {
               FocusScope.of(context).requestFocus(FocusNode());
              if (!widget.controller.selectedList.contains(newValue))
                widget.controller.selectedList.add(newValue);
            });
          },
          items: widget.controller.allList.map((c) {
            return DropdownMenuItem(
              value: c,
              child: Text(
                c,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              
            );
          }).toList(),
        ),

        Container(
          width: MediaQuery.of(context).size.width*0.5,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical:8),
              itemCount: widget.controller.selectedList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical:4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(widget.controller.selectedList[index],style: TextStyle(color: Theme.of(context).primaryColor),),
                      IconButton(
                        icon: Icon(Icons.delete,color: Theme.of(context).primaryColor,),
                        onPressed: () {
                          setState(() {
                            widget.controller.selectedList.removeAt(index);
                          });
                        },
                      )
                    ]));
              }),
        ),
      ],
    );
  }
}

