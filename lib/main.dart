import 'package:flutter/material.dart';
// import 'Order_card.dart';

void main() {
  runApp(Orders_dummy_page());
}

const String title = 'Orders';
const Color white_color = Colors.white;
const Icon icon_left_arrow = Icon(Icons.arrow_back, color: Colors.black);
const double divider_thickness = 0.5;
const cardbar_borderRadius = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
const Color color_delivered_text = Color.fromARGB(255, 12, 83, 15);
const Color color_delivered_verified = Color.fromARGB(255, 95, 205, 98); 
const Color color_canceled = Color.fromARGB(255, 219, 26, 26);
const Color color_pending = Color.fromARGB(255, 54, 30, 238); //same color for preparing and enroute
const Color color_partially_delivered = Color.fromARGB(255, 220, 200, 13);
const Color order_id_box_color = Color.fromARGB(255, 16, 2, 125);
const Color call_icon_color = Color.fromARGB(255, 50, 138, 53); //color for call_icon and verified(order_status)
const Color room_icon_color = Color.fromARGB(255, 67, 150, 245);
const sizedBox_w15 = SizedBox(width: 15,);
const sizedBox_w1 = SizedBox(width: 0.1,);
const sizedBox_w20 = SizedBox(width: 20,);
const sizedBox_h10 = SizedBox(height: 10,);
const sizedBox_h5 = SizedBox(height: 5,);
const sizedBox_h20 = SizedBox(height: 20,);
const String phone_number_text = 'Phone number';
const String address_text = 'Address';
//constants used for styling phone no. & address texts & values
const textStyle_texts = TextStyle
(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Color.fromARGB(255, 120, 118, 118)          
);
const textStyle_values = TextStyle
(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  // color: Colors.black,          
);
const icon_room = Icon
(
Icons.room,
color: room_icon_color,
);
const icon_call = Icon
(
Icons.call,
color: call_icon_color,  
);

//these values will come from backend
final String Order_Id = '1232';
final String Delivery_Status = 'Enroute';      //CASE SENSITIVE (required for changing color of the card_bar)
final String Phone_Number = '9090909993939393';
final String Address = 'A2-904, ARC Gaurav, Anthon Nagar, Kondhwa, Pune';
final String Stops = 'Stop 1';
final String Order_Status = 'Verified';          //CASE SENSITIVE (required for changing color of the status)



class Orders_dummy_page extends StatelessWidget {
  
  Orders_dummy_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appbar
        appBar: AppBar(
          backgroundColor: white_color,
          title: Text('$title',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: icon_left_arrow,
            onPressed: () {
              //logic for left arrow leading button
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //1st ORDER 
              Padding(
                padding: const EdgeInsets.all(20.0),

                //this is our card that will take these values from the backend
                child: Order_card(
                  order_id: Order_Id, 
                  delivery_status: Delivery_Status,
                  phone_number: Phone_Number,
                  address: Address,
                  stops: Stops,
                  order_status: Order_Status,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  //ALL THESE WIDGETS HAVE BEEN COPIED INTO DIFFERENT DART FILES

class Order_card extends StatelessWidget {

  Order_card({
    super.key,
    required order_id,
    required delivery_status,
    required phone_number,
    required address,
    required stops,
    required order_status,
  });

  @override
  Widget build(BuildContext context) {
  
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //includes CONTAINER -> CARD -> CARD -> CARD
        children: [
          
          //below widget i.e. card_bar() consists of a container that displays 
          //the top segment of the card & elements inside it i.e. the one that 
          //changes color according to status
          card_bar(
            // order_id: Order_Id, 
            // delivery_status: Delivery_Status,
          ),

          sizedBox_h20,
      
          // 1st card beneath top segment that includes phone number
          Info_Card(
              textStyle_texts: textStyle_texts,   //textstyle for phone number text
              textStyle_values: textStyle_values,   //textstyle for phone number value
              value: '$Phone_Number',
              text: '$phone_number_text',
              icon: icon_call,
            ),
          
          //divider between phone number & address (consists of sizedbox with a divider child)
          divider(padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10,)
          ),
      
          //2nd card (address text & address)                              
          Info_Card(
              textStyle_texts: textStyle_texts,  //textstyle for address text
              textStyle_values: textStyle_values,  //textstyle for address value
              value: '$Address',
              text: '$address_text',
              icon: icon_room,
            ),
      
          //divider between address and order_details
          divider(padding: const EdgeInsets.only(left: 0, right: 0)
          ),

          sizedBox_h10,
      
          Column(
            //contains row of stops and order_status -> edit button -> row of button_cards
            children: [
              stops_orderstatus(),
              
              ( //if this is true
                Delivery_Status == 'Enroute' || 
                Delivery_Status == 'Preparing' ||
                Delivery_Status == 'Pending'
              )
              ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: ElevatedButton(
                      onPressed: ()
                      {
                        //logic
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        elevation: MaterialStateProperty.all<double>(2.0),
                      ),
                    ),
                  ),

                  divider(padding: const EdgeInsets.only(left: 0, right: 0)),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        button_card(
                          button: 'Cancel',
                          color: Color.fromARGB(255, 158, 20, 10),
                        ),

                        button_card(
                          button: 'Ready to pickup', 
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                ],
              )
              : sizedBox_h5,        //else statement     
            ]
          )
        ],
      ),
    );
  }
}

class stops_orderstatus extends StatelessWidget {
  const stops_orderstatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 10,),
          child: Text(
            '$Stops',
            style: textStyle_values,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Text(
                  '$Order_Status',
                  style: TextStyle(
                    color: (Order_Status == 'Verified') ? call_icon_color : color_canceled,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
        ),
      ]
    );
  }
}

class button_card extends StatelessWidget {
  const button_card({
    super.key,
    required this.button,
    required this.color
  });

  final String button;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
              
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 7.5, 25, 7.5),
        child: Text('$button',
        style: TextStyle(
          color: white_color,
          fontSize: 20,
        ),

      ),
      ),
    );
  }
}

class Info_Card extends StatelessWidget {
  const Info_Card({
    super.key,
    required this.textStyle_texts,
    required this.textStyle_values,
    required this.text,
    required this.icon,
    required this.value
  });

  final TextStyle textStyle_texts;
  final TextStyle textStyle_values;
  final Icon icon;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      // row consists room_icon & coulumn(add. text & address)
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        sizedBox_w20,
    
        //room_icon
        icon,
    
        sizedBox_w15,
    
        Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text
              Text(
                text,
                style: textStyle_texts,
              ),
                    
              sizedBox_h10,
                    
              // value
              Text(
                value,
                style: textStyle_values,
              ),
                  
              sizedBox_h5,
            ],
          ),
        ),
      ],
    );
  }
}


//  this widget determines the appearance of the top bar of the card
class card_bar extends StatelessWidget {
  card_bar({
    super.key,
  });

  //function to decide the color of card_bar
  Color card_bar_color(String status){
    if (status == 'Delivered') {
      return color_delivered_verified;
    }
    else if((status == 'All Stops Canceled') || (status == 'Returned')){
      return color_canceled;
    }
    else if(status == 'Partially Delivered'){
      return color_partially_delivered;
    }
    else 
      return color_pending;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration of container (top segment)
      decoration: BoxDecoration(
        borderRadius: cardbar_borderRadius,
        color: card_bar_color(Delivery_Status), // variable  ***
      ),
          
      //element inside the top segment of the card (order id & status)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //order id
          Container(
            decoration: BoxDecoration(
              color: order_id_box_color,
              borderRadius: BorderRadius.circular(40),
            ),
            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),

            child: Text('Order_id: ' + '${Order_Id}',   // variable  1st child
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ),
                  
          //delivery_status
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text('${Delivery_Status}',  // variable 2nd child
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: (Delivery_Status == 'Delivered') ? color_delivered_text : white_color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class divider extends StatelessWidget {
  divider({
    super.key,
    required this.padding,
  });

  final EdgeInsets padding ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 10,
        child: Padding(
          padding: padding,
          child: Expanded(
            child: Divider(
            color: Colors.black,
            thickness: divider_thickness,
            ),
          ),
        ),
    );
  }
}