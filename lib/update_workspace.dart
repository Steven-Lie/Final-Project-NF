import 'package:flutter/material.dart';

enum ProducTypeEnum { Team, User }

class UpdateWorkspace extends StatelessWidget {
  UpdateWorkspace({super.key});

  ProducTypeEnum? _producTypeEnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Workspace',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Workspace Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF787878),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFF4C53FF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    helperText: "This is the name of your workspace",
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF787878),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFF4C53FF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    helperText:
                        "Get your members on board with a few words about your workspace",
                    alignLabelWithHint: true,
                  ),
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Visibility',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF787878),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFF4C53FF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    helperText:
                        "Get your members on board with a few words about your workspace",
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
