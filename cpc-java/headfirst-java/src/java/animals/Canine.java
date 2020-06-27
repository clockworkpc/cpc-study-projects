abstract class Canine implements Mammal, Quadruped {
  public String canineDentition() {
    return animalFeatureTemplate("powerful molars and incissors");
  }

  public void hasCanineDentition() {
    System.out.println(canineDentition());
  }
}
