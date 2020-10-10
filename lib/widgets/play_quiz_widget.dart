import 'package:flutter/material.dart';

//there is a change happening even after we loaded the data. Therefore stateful widget.
class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile({
    @required this.option, @required this.description, @required this.correctAnswer, @required this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,),
      child: Row(
        children: [
          Container(
            height:28,
            width : 28,
            decoration: BoxDecoration(
              border : Border.all(color: widget.description == widget.optionSelected
              ? widget.optionSelected == widget.correctAnswer ? Colors.green.withOpacity(0.7) :
                  Colors.red.withOpacity(0.7) : Colors.grey,
                width : 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment : Alignment.center,
            child: Text("${widget.option}", style: TextStyle(color: widget.optionSelected == widget.description ?
            widget.optionSelected == widget.correctAnswer ? Colors.green.withOpacity(0.7) : Colors.red : Colors.grey
            ),), //to access a named parameter from another method, access it like a widget.
          ),
          SizedBox(width:8,),
          Text(
            widget.description, style: TextStyle(color: Colors.black54, fontSize: 16,),
          ),
        ],
      ),
    );
  }
}



