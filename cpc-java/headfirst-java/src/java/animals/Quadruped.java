public class Quadruped extends Animal {
  public String fourLegs() {
    return animalFeatureTemplate("four legs");
  }

  public void hasFourLegs() {
    System.out.println(fourLegs());
  }
}
