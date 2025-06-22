import 'package:flutter/material.dart';
import 'package:printer_module/printer_module.dart';

class DataSelectionSheet extends StatefulWidget {
  final List<PrinterType> items;
  final String title;
  final PrinterType? initialSelected;
  final Function(PrinterType?) onSelectionChanged;
  final String? searchHint;
  final bool showSearch;

  const DataSelectionSheet({
    super.key,
    required this.items,
    required this.title,
    required this.onSelectionChanged,
    this.initialSelected,
    this.searchHint,
    this.showSearch = true,
  });

  @override
  State<DataSelectionSheet> createState() => _DataSelectionSheetState();

  // Static method untuk menampilkan sheet
  static Future<PrinterType?> show({
    required BuildContext context,
    required List<PrinterType> items,
    required String title,
    PrinterType? initialSelected,
    String? searchHint,
    bool showSearch = true,
  }) {
    return showModalBottomSheet<PrinterType>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: DataSelectionSheet(
            items: items,
            title: title,
            initialSelected: initialSelected,
            searchHint: searchHint,
            showSearch: showSearch,
            onSelectionChanged: (selected) {
              Navigator.pop(context, selected);
            },
          ),
        ),
      ),
    );
  }
}

class _DataSelectionSheetState extends State<DataSelectionSheet> {
  late List<PrinterType> _items;
  List<PrinterType> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  PrinterType? _selectedItems;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    _filteredItems = List.from(_items);

    // Set initial selected items
    if (widget.initialSelected != null) {
      _selectedItems = widget.initialSelected;
    }

    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(_items);
      } else {
        _filteredItems = _items.where((item) {
          return item.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _toggleItem(PrinterType item) {
    setState(() {
      _selectedItems = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle bar
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 4,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Search bar
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: widget.searchHint ?? 'Cari data...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
          ),

        // Items list
        ListView.builder(
          shrinkWrap: true,
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            final item = _filteredItems[index];
            return ListTile(
              title: Text(item.name),
              trailing: _selectedItems == item
                  ? Icon(
                      Icons.radio_button_checked,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(Icons.radio_button_unchecked),
              onTap: () => _toggleItem(item),
            );
          },
        ),

        // Action buttons
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSelectionChanged(_selectedItems);
                  },
                  child: Text('Pilih'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
