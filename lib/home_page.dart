import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num tip_percentage =20;
  num tip=20;
  num orderTotal=100;
  int selection=0;
  bool roundTip = true;
  var tipController = TextEditingController();

  var radioValues={
    0: "Amazing 20%",
    1: "Good 18%",
    2: "Okay 15%"
  };
  
  _tipCalculation() {

    num subTotal = double.parse(tipController.text ?? '0.0');
    tip = subTotal * (tip_percentage/100);
    orderTotal = subTotal + tip;

    if(roundTip)
      tip = tip.ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
        backgroundColor: Colors.green
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingresar propina",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Column( children:
            radioValues.entries.map((e) => ListTile(
              leading: Radio(
                value: e.key,
                groupValue: selection,
                onChanged: (newSelection){
                  switch (e.key) {
                    case 0:
                      tip_percentage = 20;
                      break;
                    case 1:
                      tip_percentage = 18;
                      break;
                    default:
                      tip_percentage = 15;
                  }
                  setState(() {
                    selection = newSelection;
                  });
                }),
                title: Text(e.value),
              )).toList(),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(value: roundTip, onChanged: (switchstate){
              roundTip = switchstate;
              setState(() {});
            },),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text("CALCULATE", style: TextStyle(color: Colors.grey[200]),),
                    onPressed: (){
                      _tipCalculation();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
          Text("Tip amount: \$"+tip.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
