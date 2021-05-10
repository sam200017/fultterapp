import 'package:flutter/material.dart';
import"package:flutter/widgets.dart";

void main(){
  runApp(
      MaterialApp(
        title: 'SimpleInterestCalculator App',
        debugShowCheckedModeBanner: false,
        home:SIform(),
        theme: ThemeData(

          primaryColor: Colors.indigo,
          accentColor: Colors.indigo,
        ),
      )
      );
}
class SIform extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SIformState();
  }

}
class SIformState extends State<SIform>{
  var currencies=["Ruppees","Dollars","Pounds"];
  final minpadding=5.0;
  var currentval="Ruppees";
  TextEditingController principalcontroller=TextEditingController();
  TextEditingController roicontroller=TextEditingController();
  TextEditingController termcontroller=TextEditingController();
  var display="";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.headline6;
    return Scaffold(
      resizeToAvoidBottomInset: false ,

      appBar: AppBar(
        title: Text('Simple Interest calculator app'),
      ),
      body: Container(

        margin: EdgeInsets.all(minpadding*2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: minpadding,bottom: minpadding),
              child:TextField(
                style: textStyle,
              controller: principalcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter principal e.g. 12000',
                labelStyle: textStyle,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )),

            Padding(
              padding: EdgeInsets.only(top:minpadding,bottom:minpadding),
              child:TextField(
                style: textStyle,
              controller: roicontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Rate of interest',
                  hintText: 'In percent',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)

                  )
              ),
            )),
           Padding(
             padding: EdgeInsets.only(top:minpadding,bottom:minpadding),
             child:Row(
              children: <Widget>[


                   Expanded(
                       child: TextField(
                         style: textStyle,
                      controller: termcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Time period',
                          hintText: 'Time in Years',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)

                          )
                      ),
                    )),
               Container(width: minpadding*5,),
               Expanded(
                   child: DropdownButton<String>(
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: currentval,
                  onChanged: (String newval){
                    ondropdownselected(newval);

                  },
                ))
              ]
            )),

           Padding(
               padding: EdgeInsets.only(top:minpadding,bottom:minpadding),
             child: Row(children: <Widget> [
              Expanded(

                child: RaisedButton(
                  color:Theme.of(context).primaryColorDark,
                  child: Text('Calculate',textScaleFactor: 1.5,),
                  onPressed:(){
                    setState(() {
                      this.display=calculatetotalreturn();
                    });

                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorLight,
                  child: Text('Resest',textScaleFactor: 1.5,),
                  onPressed: (){
                    setState(() {
                      resetfun();
                    });
                  }
                ),
              )
            ],)),

            Padding(
              padding: EdgeInsets.all(minpadding*2),
              child: Text(this.display,style: textStyle),
            )

          ],

        ),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage=AssetImage('images/bankimage.jpg');
    Image image=Image(image:assetImage,width: 125.0,height: 125.0,);
    return Container(child: image,margin: EdgeInsets.all(minpadding),);
  }
 void ondropdownselected(String newcurrentval){
    setState(() {
      this.currentval=newcurrentval;
    });
 }
 String calculatetotalreturn(){
    double principal=double.parse(principalcontroller.text);
    double roi=double.parse(roicontroller.text);
    double term=double.parse(termcontroller.text);
    double totalamount=(principal*roi*term)/100;
    String result="After $term years your investment will be worth $totalamount $currentval";

    return result;
 }
 void resetfun(){
    principalcontroller.text='';
    roicontroller.text='';
    termcontroller.text='';
    display='';
    currentval=currencies[0];
 }
}