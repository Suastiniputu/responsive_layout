import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredObatList = [];
  final int itemsPerPage = 10;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    filteredObatList = obatList;
  }

  void _filterObatList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredObatList = obatList;
      } else {
        filteredObatList = obatList
            .where((obat) => obat.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      currentPage = 0;
    });
  }

  List<String> getPaginatedObatList() {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage > filteredObatList.length)
        ? filteredObatList.length
        : startIndex + itemsPerPage;
    return filteredObatList.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth >= 800;
          return Row(
            children: [
              if (isDesktop)
                Flexible(
                  flex: 1,
                  child: buildSidebar(),
                ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildSearchBar(),
                      SizedBox(height: 20),
                      buildHeader(),
                      SizedBox(height: 10),
                      buildDataObatSection(),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: [
                            for (var obat in getPaginatedObatList())
                              CheckboxListTile(
                                title: Text(obat),
                                value: false,
                                onChanged: (value) {},
                              ),
                          ],
                        ),
                      ),
                      buildPaginationButtons(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildSidebar() {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Patient'),
            onTap: () {},
          ),
          ExpansionTile(
            leading: Icon(Icons.medical_services),
            title: Text('Products & Services'),
            children: [
              ListTile(
                title: Text('Medicine'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Medicine Stock'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Services'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Disposable'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.handshake),
            title: Text('Partner'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _filterObatList,
      decoration: InputDecoration(
        hintText: 'Search Obat',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nama Obat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Obat ${currentPage * itemsPerPage + 1}-${(currentPage * itemsPerPage + itemsPerPage) > filteredObatList.length ? filteredObatList.length : currentPage * itemsPerPage + itemsPerPage} dari ${filteredObatList.length}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildDataObatSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Data Obat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text('+ Add'),
        ),
      ],
    );
  }

  Widget buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: currentPage > 0
              ? () {
                  setState(() {
                    currentPage--;
                  });
                }
              : null,
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: (currentPage + 1) * itemsPerPage < filteredObatList.length
              ? () {
                  setState(() {
                    currentPage++;
                  });
                }
              : null,
          child: Text('Next'),
        ),
      ],
    );
  }

  final List<String> obatList = [
    'ACETYL CYSTEINE DRY SYR (NYTEX)',
    'ACETYLCYSTEINE TAB 200MG (ALSTEIN)',
    'Acetyl Sistine',
    'ACICLOVIR CREAM (ACIFAR) 5GR',
    'AMLODIPINE TAB 10MG (ZEVASK)',
    'AMOXICILLIN SYR (YUSIMOX FORTE)',
    'AZITHROMYCIN CAPS 500MG',
    'PARACETAMOL TAB 500MG',
    'IBUPROFEN TAB 200MG',
    'LORATADINE TAB 10MG',
    'METFORMIN TAB 500MG',
    'ACETYL CYSTEINE DRY SYR (NYTEX)',
    'ACETYLCYSTEINE TAB 200MG (ALSTEIN)',
    'Acetyl Sistine',
    'ACICLOVIR CREAM (ACIFAR) 5GR',
    'AMLODIPINE TAB 10MG (ZEVASK)',
    'AMOXICILLIN SYR (YUSIMOX FORTE)',
    'AZITHROMYCIN CAPS 500MG',
    'PARACETAMOL TAB 500MG',
    'IBUPROFEN TAB 200MG',
    'LORATADINE TAB 10MG',
    'METFORMIN TAB 500MG',
    'ACETYL CYSTEINE DRY SYR (NYTEX)',
    'ACETYLCYSTEINE TAB 200MG (ALSTEIN)',
    'Acetyl Sistine',
    'ACICLOVIR CREAM (ACIFAR) 5GR',
    'AMLODIPINE TAB 10MG (ZEVASK)',
    'AMOXICILLIN SYR (YUSIMOX FORTE)',
    'AZITHROMYCIN CAPS 500MG',
    'PARACETAMOL TAB 500MG',
    'IBUPROFEN TAB 200MG',
    'LORATADINE TAB 10MG',
    'METFORMIN TAB 500MG',
  ];
}
