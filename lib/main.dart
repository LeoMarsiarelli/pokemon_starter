import 'package:flutter/material.dart';

void main() {
  runApp(PokemonStarterApp());
}

class PokemonStarterApp extends StatelessWidget {
  const PokemonStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: PokemonStarterScreen(),
    );
  }
}

class PokemonStarterScreen extends StatefulWidget {
  const PokemonStarterScreen({super.key});

  @override
  State<PokemonStarterScreen> createState() => _PokemonStarterScreenState();
}

class PokemonOption extends StatelessWidget {
  final bool selected;
  final Pokemon pokemon;
  final Function(Pokemon) onSelected;

  const PokemonOption({
    super.key,
    required this.selected,
    required this.pokemon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(pokemon),
      child: Column(
        children: [
          Image.asset(
            selected
                ? "images/pokeball_selected.png"
                : "images/pokeball_unselected.png",
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 4),
          Text(pokemon.name, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class PokemonOptionList extends StatelessWidget {
  final List<Pokemon> options;
  final Pokemon pokemonSelected;
  final Function(Pokemon) onSelected;
  const PokemonOptionList({
    super.key,
    required this.options,
    required this.pokemonSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((pokemon) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PokemonOption(
            pokemon: pokemon,
            selected: pokemon == pokemonSelected,
            onSelected: onSelected,
          ),
        );
      }).toList(),
    );
  }
}

final starters = [
  Pokemon(name: "Bulbassaur", image: "images/bulbassaur.png"),
  Pokemon(name: "Charmander", image: "images/charmander.png"),
  Pokemon(name: "Squirtle", image: "images/squirtle.png"),
];

class _PokemonStarterScreenState extends State<PokemonStarterScreen> {
  Pokemon pokemonSelected = starters.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PokeHeader("Escolha seu Pokemon inicial"),
          PokemonCard(pokemon: pokemonSelected),
          PokemonOptionList(
            options: starters,
            pokemonSelected: pokemonSelected,
            onSelected: (pokemon) {
              setState(() {
                pokemonSelected = pokemon;
              });
            },
          ),
        ],
      ),
    );
  }
}

class PokeHeader extends StatelessWidget {
  const PokeHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class Pokemon {
  final String name;
  final String image;

  Pokemon({required this.name, required this.image});
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(pokemon.image, width: 250, height: 250),
        Text(
          pokemon.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class PokemonStarterScreenPortrait extends StatelessWidget {
  final Pokemon pokemonSelected;
  final List<Pokemon> options;
  final Function(Pokemon) onSelected;

  const PokemonStarterScreenPortrait({
    super.key,
    required this.pokemonSelected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PokeHeader("Escolha seu Pokemon inicial"),
        PokemonCard(pokemon: pokemonSelected),
        PokemonOptionList(
          options: options,
          pokemonSelected: pokemonSelected,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class PokemonStarterScreenLandscape extends StatelessWidget {
  final Pokemon pokemonSelected;
  final List<Pokemon> options;
  final Function(Pokemon) onSelected;

  const PokemonStarterScreenLandscape({
    super.key,
    required this.pokemonSelected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(child: PokemonCard(pokemon: pokemonSelected)),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PokeHeader("Escolha seu Pokemon inicial"),
              SizedBox(height: 38),
              PokemonOptionList(
                options: options,
                pokemonSelected: pokemonSelected,
                onSelected: onSelected,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
