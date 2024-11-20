import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor Superheroes {
  public type SuperheroId = Nat32;
  public type Superhero = {
    name : Text;
    superpowers : List.List<Text>;
  };

  private stable var next : SuperheroId = 0;
  private stable var superheroes : Trie.Trie<SuperheroId, Superhero> = Trie.empty();

  public func create(superhero : Superhero) : async SuperheroId {
    let superheroId = next;

    next += 1;
    superheroes := Trie.replace(
      superheroes,
      key(superheroId),
      Nat32.equal,
      ?superhero
    ).0;
    return superheroId;
  };

  public query func read(superheroId : SuperheroId) : async ?Superhero {
    return Trie.find(superheroes, key(superheroId), Nat32.equal);
  };

  private func key(x : SuperheroId) : Trie.Key<SuperheroId> {
    return {hash = x; key = x};
  };
};