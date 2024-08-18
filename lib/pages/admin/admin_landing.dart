import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/admin/add_clinic.dart';
import 'package:flutter_application_1/pages/admin/list_clinics.dart';
import 'package:flutter_application_1/pages/category/add_category.dart';
import 'package:flutter_application_1/pages/category/list_category.dart';
import 'package:flutter_application_1/services/dataService.dart';

class AdminPage extends StatelessWidget {
  final String text;

  const AdminPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xfffeac5e), Color(0xffc779d0), Color(0xff4bc0c8)],
          stops: [0, 0.5, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        )
      
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Welcome Admin!",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const Text(
                  "What do you want to do today?",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,),
                ),
                const SizedBox(height: 40),
                Expanded(  
                                  
                  child: GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,                      
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 10,                      
                    ),
                    itemCount: 6, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return _buildGridItem(context, index);
                    },
                  ),
                ),
                
                ElevatedButton(
                  onPressed: (){
                    logout();
                     Navigator.pushReplacementNamed(context, '/login');
                  },                  
                  child: const Text("Logout"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    List<Widget> buttons = [
      RawMaterialButton(        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClinicPage()),
          );
        },        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),          
        ),
        fillColor: const Color.fromARGB(74, 0, 0, 0),
        child: const Column(
            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
            children: [
              Text(
                'Add Clinic',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Space between text and icon
              Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 40,                
              ),
            ],
          ),
      ),
      AdminPageButton(),
      RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryPage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        fillColor: const Color.fromARGB(74, 0, 0, 0),
        child: const Column(
            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
            children: [
              Text(
                'Add Category',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Space between text and icon
              Icon(
                Icons.add_card_sharp,
                color: Colors.white,
                size: 40,                
              ),
            ],
          ),
      ),
      RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoryListPage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
       fillColor: const Color.fromARGB(74, 0, 0, 0),
        child: const Column(
            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
            children: [
              Text(
                'List Categories',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Space between text and icon
              Icon(
                Icons.list_rounded,
                color: Colors.white,
                size: 40,                
              ),
            ],
          ),
      ),
      RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoryListPage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        fillColor: const Color.fromARGB(74, 0, 0, 0),
        child: const Column(
            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
            children: [
              Text(
                'All Users',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Space between text and icon
              Icon(
                Icons.supervised_user_circle_sharp,
                color: Colors.white,
                size: 40,                
              ),
            ],
          ),
      ),
      RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoryListPage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
       fillColor: const Color.fromARGB(74, 0, 0, 0),
        child: const Column(
            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
            children: [
              Text(
                'All Applications',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Space between text and icon
              Icon(
                Icons.verified_rounded,
                color: Colors.white,
                size: 40,                
              ),
            ],
          ),
      ),
    ];
    return buttons[index];
  }

  
}

class AdminPageButton extends StatelessWidget {
  const AdminPageButton({
    super.key    
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClinicsPage()),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      fillColor: const Color.fromARGB(74, 0, 0, 0),
      child: const Column(
          mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
          children: [
            Text(
              'List Clinics',
              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Space between text and icon
            Icon(
              Icons.list_alt_outlined,
              color: Colors.white,
              size: 40,                
            ),
          ],
        ),
    );
  }
}
