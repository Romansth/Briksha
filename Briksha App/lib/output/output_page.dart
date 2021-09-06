import 'package:flutter/material.dart';
import 'package:briksha/reports/report.dart';
import 'package:briksha/buttons/send.dart';

class OutputPage extends StatefulWidget {
  final String disease, plant, remedy;

  const OutputPage(
      {Key? key,
      required this.disease,
      required this.plant,
      required this.remedy})
      : super(key: key);

  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Final Report"),
          backgroundColor: Colors.green[600]),
          
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding:EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.06,
                    // left: MediaQuery.of(context).size.width*0.03
                  ) ,
                 child: 
                 Container(
                   height:MediaQuery.of(context).size.height * 0.1,
                   width:MediaQuery.of(context).size.width*0.85,
                   color: Colors.yellow,
                   child:Center(child:
                 Text("Plant Name: " + widget.plant,
                      style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold
                      
                      )),
                      
                      ))),
              Padding(padding:EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.06,
                    // left: MediaQuery.of(context).size.width*0.03
                  ) ,
                 child: 
                 Container(
                   height:MediaQuery.of(context).size.height * 0.1,
                   width:MediaQuery.of(context).size.width*0.85,
                   color: Colors.red[600],
                   child:Center(child:
                
                  widget.disease == "healthy"
                      ? Text("Your Plant is Healthy!!",
                          style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold))
                      : Text("Disease detected: " + widget.disease,
                          style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:Colors.white))
                      
                      ))),
                    Padding(padding:EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.06,
                    // left: MediaQuery.of(context).size.width*0.03
                  ) ,
                 child: 
                 Container(
                   height:MediaQuery.of(context).size.height * 0.3,
                   width:MediaQuery.of(context).size.width*0.85,
                   color: Colors.green[300],
                   child:Center(child:
                   
                  Column(children: [
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                    child:
                  widget.disease == "healthy"
                      ? Container()
                      : Text("Possible Remedy: ",
                          style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          
                          ))),
                      
                      
                 widget.disease == "healthy"
                      ? Container()
                      : Padding(padding:EdgeInsets.only(
                        top: MediaQuery.of(context).size.width*0.03,
                        left: MediaQuery.of(context).size.width*0.03),child:Text(widget.remedy,
                          style: TextStyle(
                              fontSize: 17,
                         
                              fontWeight: FontWeight.bold)))])))),
                  Spacer(
                    flex: 1,
                  ),
                
            
           
            SendButton(
                title: "Download Report",
            
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  bool result = await makeReport(
                    plant: widget.plant,
                    disease: widget.disease,
                    remedy: widget.remedy,
                  );
                  setState(() {
                    isLoading = false;
                  });
                  print(result);
                }),
            isLoading
                ? Expanded(
                    flex: 1, child: Center(child: CircularProgressIndicator(
                      color: Colors.green,
                    )))
                : Spacer(
                    flex: 1,
                  )
          ],
        ),
      ),
    );
  }
}
 