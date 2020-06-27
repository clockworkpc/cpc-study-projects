public interface Mammal extends Animal {
  public String warmBlooded() {
    return animalAttributeTemplate("warm blooded");
  }

  public void isWarmBlooded() {
    System.out.println(warmBlooded());
  }
}
