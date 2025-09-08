import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MonitoresApp());
}

class MonitoresApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> monitores = []; 

  bool isLoading = true;

  @override
  void initState() {

    super.initState();
    procuraMonitores(); // carrega os dados da api 

  }

  Future<void> procuraMonitores() async {

    try {
      
      final response = await http.get(Uri.parse('http://localhost:3000/monitores'));

      if (response.statusCode == 200) {

        List<dynamic> dados = json.decode(response.body);
        print("Dados carregados: $dados"); // debug

        setState(() {

          monitores = dados.map((monitor) {
            return {

              'nome': monitor['nome'],
              'imagem': monitor['imagem'],
              'horarios': monitor['horarios'],
            };
          }).toList();

          isLoading = false;

        });

      } 

      else {
        throw Exception('Erro ao carregar monitores');
      }

    } 
    
    catch (e) {

      print("Erro ao carregar monitores: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 26, 125, 206),
     
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(143, 92, 172, 238),
       
        title: Center(

          child: Text(

            'Monitores do DPD',

            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
       
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(90.0),

        child: isLoading

            ? Center(child: CircularProgressIndicator())

            : monitores.isEmpty

                ? Center(child: Text('Nenhum monitor disponível'))

                : CarouselSlider.builder(

                    itemCount: monitores.length,

                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      
                      return GestureDetector( // permite clicar  para ir para outra tela

                      onTap: () {

                         Navigator.push(

                                 context,
                         MaterialPageRoute(

                            builder: (context) => TelaDetalhesMonitor(

                             nome: monitores[index]['nome']!,
                             imagem: monitores[index]['imagem']!,
                              horarios: monitores[index]['horarios'], 
                                             ),
                                           ),
                                        );
                                      },

                        child: Card(  // exibição da tela principal

                          child: Column(

                            children: [

                              SizedBox(height: 25),

                              monitores[index]['imagem'] != null && monitores[index]['imagem']!.isNotEmpty
                                
                                  ? Image.network(

                                      monitores[index]['imagem']!,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.broken_image, size: 100);

                                      },
                                    )

                                  : Icon(Icons.image_not_supported, size: 100),

                              SizedBox(height: 50),

                              Text(
                                monitores[index]['nome']!,

                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                              ),
                            ],
                          ),
                        ),
                      );
                    },

                    options: CarouselOptions(

                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 30,
                    ),
                  ),
      ),
    );
  }
}

class TelaDetalhesMonitor extends StatelessWidget {

  final String nome;
  final String imagem;
  final List<dynamic> horarios;

  TelaDetalhesMonitor({required this.nome, required this.imagem, required this.horarios});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text(nome)),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center, 

          children: [

            imagem.isNotEmpty

                ? Image.network( // Verificação

                    imagem,

                    errorBuilder: (context, error, stackTrace) {
                  
                    return Icon(Icons.broken_image, size: 100); 
                    },
                  )

                : Icon(Icons.image_not_supported, size: 100), 
            
            SizedBox(height: 20),

            Text(
              'Horários de monitoria do(a) $nome',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center, 
            ),

            SizedBox(height: 20),

            Expanded(

              child: Center( 


                child: ListView.builder(

                  shrinkWrap: true, // Evita o uso de espaço extra

                  itemCount: horarios.length,

                  itemBuilder: (context, index) {

                    final horario = horarios[index];

                    return Align(

                      alignment: Alignment.center, 

                      child: Column(

                        children: [

                          Text(
                            horario['dia'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),

                          Text(horario['horario']),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
